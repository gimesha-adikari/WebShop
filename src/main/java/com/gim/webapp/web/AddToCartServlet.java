package com.gim.webapp.web;

import com.gim.webapp.dao.ProductDao;
import com.gim.webapp.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;

public class AddToCartServlet extends HttpServlet {
    private final ProductDao productDao = new ProductDao();

    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Long productId = Long.valueOf(req.getParameter("productId"));

        int qty = 1;
        try {
            String q = req.getParameter("qty");
            if (q != null) qty = Integer.parseInt(q);
        } catch (NumberFormatException ignored) { }
        if (qty < 1) qty = 1;

        Product product = productDao.tx(s -> s.get(Product.class, productId));
        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            return;
        }

        HttpSession session = req.getSession(true);
        Map<Long, CartItem> cart = (Map<Long, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }

        CartItem existing = cart.get(productId);
        if (existing == null) {
            CartItem item = new CartItem();
            item.setProductId(product.getId());
            item.setName(product.getName());
            item.setUnitPrice(product.getPrice());
            item.setQuantity(qty);
            item.setImageUrl(product.getImageUrl());
            cart.put(productId, item);
        } else {
            existing.setQuantity(existing.getQuantity() + qty);
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }


    public static class CartItem {
        private Long productId;
        private String name;
        private BigDecimal unitPrice;
        private int quantity;
        private String imageUrl;

        public Long getProductId() { return productId; }
        public void setProductId(Long productId) { this.productId = productId; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public BigDecimal getUnitPrice() { return unitPrice; }
        public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }

        public String getImageUrl() { return imageUrl; }
        public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

        public BigDecimal getLineTotal() {
            return unitPrice.multiply(BigDecimal.valueOf(quantity));
        }
    }
}
