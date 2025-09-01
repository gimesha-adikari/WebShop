package com.gim.webapp.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

public class ViewCartServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<Long, AddToCartServlet.CartItem> cart = (Map<Long, AddToCartServlet.CartItem>) req.getSession(true).getAttribute("cart");
        req.setAttribute("total", computeTotal(cart));
        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
    }

    private BigDecimal computeTotal(Map<Long, AddToCartServlet.CartItem> cart) {
        if (cart == null) return BigDecimal.ZERO;
        return cart.values().stream().map(AddToCartServlet.CartItem::getLineTotal).reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}
