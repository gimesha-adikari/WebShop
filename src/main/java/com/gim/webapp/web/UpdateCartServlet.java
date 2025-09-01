package com.gim.webapp.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

public class UpdateCartServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<Long, AddToCartServlet.CartItem> cart =
                (Map<Long, AddToCartServlet.CartItem>) req.getSession(true).getAttribute("cart");

        if (cart != null) {
            for (String name : req.getParameterMap().keySet()) {
                if (name.startsWith("qty_")) {
                    Long id = Long.valueOf(name.substring(4));
                    int qty = Integer.parseInt(req.getParameter(name));
                    if (qty <= 0) cart.remove(id);
                    else if (cart.get(id) != null) cart.get(id).setQuantity(qty);
                }
            }
        }

        String action = req.getParameter("action");
        if ("checkout".equals(action)) {
            req.getRequestDispatcher("/checkout").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}
