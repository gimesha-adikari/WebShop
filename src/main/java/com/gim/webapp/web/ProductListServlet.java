package com.gim.webapp.web;

import com.gim.webapp.dao.ProductDao;
import com.gim.webapp.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ProductListServlet extends HttpServlet {
    private final ProductDao productDao = new ProductDao();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String q = req.getParameter("q");
        if (q == null) q = "";
        int page = 1, pageSize = 8;
        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception ignored) {
        }
        long total = productDao.countByNameLike(q);
        int totalPages = (int) Math.ceil((double) total / pageSize);
        int offset = (page - 1) * pageSize;
        List<Product> products = productDao.searchByNameLike(q, offset, pageSize);
        req.setAttribute("q", q);
        req.setAttribute("page", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("products", products);
        req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, resp);
    }
}
