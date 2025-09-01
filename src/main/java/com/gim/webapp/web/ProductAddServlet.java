package com.gim.webapp.web;

import com.gim.webapp.dao.ProductDao;
import com.gim.webapp.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Locale;
import java.util.UUID;

@MultipartConfig(fileSizeThreshold = 0, maxFileSize = 5242880, maxRequestSize = 10485760)
public class ProductAddServlet extends HttpServlet {
    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/product_add.jsp").forward(req, resp);
    }

    private Path uploadsRoot(HttpServletRequest req) throws IOException {
        String cfg = getServletContext().getInitParameter("uploads.dir");
        Path root = cfg != null && !cfg.isBlank()
                ? Paths.get(cfg).toAbsolutePath().normalize()
                : Paths.get(System.getProperty("java.io.tmpdir"), "webapp-uploads").toAbsolutePath().normalize();
        Files.createDirectories(root);
        return root;
    }

    private String safeExt(String name) {
        if (name == null) return null;
        int i = name.lastIndexOf('.');
        if (i < 0) return null;
        String e = name.substring(i + 1).toLowerCase(Locale.ROOT);
        if (e.equals("jpg") || e.equals("jpeg") || e.equals("png") || e.equals("webp")) return "." + e;
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String stockStr = req.getParameter("stock");

        if (name == null || name.trim().isEmpty() || priceStr == null || stockStr == null) {
            req.setAttribute("error", "Missing required fields");
            req.setAttribute("name", name);
            req.setAttribute("description", description);
            req.setAttribute("price", priceStr);
            req.setAttribute("stock", stockStr);
            req.getRequestDispatcher("/WEB-INF/views/product_add.jsp").forward(req, resp);
            return;
        }

        BigDecimal price;
        int stock;
        try {
            price = new BigDecimal(priceStr);
            stock = Integer.parseInt(stockStr);
            if (price.signum() < 0 || stock < 0) throw new IllegalArgumentException();
        } catch (Exception e) {
            req.setAttribute("error", "Invalid price or stock");
            req.setAttribute("name", name);
            req.setAttribute("description", description);
            req.setAttribute("price", priceStr);
            req.setAttribute("stock", stockStr);
            req.getRequestDispatcher("/WEB-INF/views/product_add.jsp").forward(req, resp);
            return;
        }

        Part file = null;
        try { file = req.getPart("image"); } catch (Exception ignored) {}
        String imageUrl = null;
        if (file != null && file.getSize() > 0) {
            String ext = safeExt(file.getSubmittedFileName());
            String ct = file.getContentType() == null ? "" : file.getContentType().toLowerCase(Locale.ROOT);
            if (ext == null || !ct.startsWith("image/")) {
                req.setAttribute("error", "Invalid image");
                req.setAttribute("name", name);
                req.setAttribute("description", description);
                req.setAttribute("price", priceStr);
                req.setAttribute("stock", stockStr);
                req.getRequestDispatcher("/WEB-INF/views/product_add.jsp").forward(req, resp);
                return;
            }
            String fname = UUID.randomUUID().toString().replace("-", "") + ext;
            Path root = uploadsRoot(req);
            Path target = root.resolve(fname).normalize();
            try (InputStream in = file.getInputStream()) {
                Files.copy(in, target);
            }
            imageUrl = "/uploads/" + fname;
        }

        Product p = new Product();
        p.setName(name.trim());
        p.setDescription(description);
        p.setPrice(price);
        p.setStock(stock);
        p.setImageUrl(imageUrl);
        productDao.save(p);
        resp.sendRedirect(req.getContextPath() + "/products");
    }
}
