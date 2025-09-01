package com.gim.webapp.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class ImageServlet extends HttpServlet {
    private Path root(HttpServletRequest req) throws IOException {
        String cfg = getServletContext().getInitParameter("uploads.dir");
        Path r = cfg != null && !cfg.isBlank()
                ? Paths.get(cfg).toAbsolutePath().normalize()
                : Paths.get(System.getProperty("java.io.tmpdir"), "webapp-uploads").toAbsolutePath().normalize();
        Files.createDirectories(r);
        return r;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String info = req.getPathInfo();
        if (info == null || info.contains("..")) {
            resp.sendError(400);
            return;
        }
        Path r = root(req);
        Path f = r.resolve(info.substring(1)).normalize();
        if (!f.startsWith(r) || !Files.isRegularFile(f)) {
            resp.sendError(404);
            return;
        }
        String ctype = Files.probeContentType(f);
        if (ctype == null || !ctype.startsWith("image/")) {
            resp.sendError(415);
            return;
        }
        resp.setContentType(ctype);
        resp.setHeader("Cache-Control", "public, max-age=604800");
        Files.copy(f, resp.getOutputStream());
    }
}
