package com.gim.webapp.web;

import com.gim.webapp.dao.ProductDao;
import com.gim.webapp.model.Order;
import com.gim.webapp.model.OrderItem;
import com.gim.webapp.model.Product;
import com.gim.webapp.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CheckoutServlet extends HttpServlet {
    private final ProductDao productDao = new ProductDao();

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long userId = (Long) req.getSession().getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        Map<Long, AddToCartServlet.CartItem> cart =
                (Map<Long, AddToCartServlet.CartItem>) req.getSession().getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        try {
            Long orderId = productDao.tx(s -> {
                Order order = new Order();
                User userRef = new User();
                userRef.setId(userId);
                order.setUser(userRef);

                List<OrderItem> items = new ArrayList<>();
                BigDecimal total = BigDecimal.ZERO;

                for (AddToCartServlet.CartItem ci : cart.values()) {
                    Product p = s.get(Product.class, ci.getProductId());
                    boolean ok = productDao.decrementStock(s, p.getId(), ci.getQuantity());
                    if (!ok) throw new RuntimeException("OUT_OF_STOCK:" + p.getId() + ":" + p.getName());

                    OrderItem oi = new OrderItem();
                    oi.setOrder(order);
                    oi.setProduct(p);
                    oi.setQuantity(ci.getQuantity());
                    oi.setUnitPrice(p.getPrice());
                    oi.setLineTotal(p.getPrice().multiply(new BigDecimal(ci.getQuantity())));
                    items.add(oi);
                    total = total.add(oi.getLineTotal());
                }

                order.setItems(items);
                order.setTotal(total);
                s.persist(order);
                return order.getId();
            });

            req.getSession().removeAttribute("cart");
            req.setAttribute("orderId", orderId);
            req.getRequestDispatcher("/WEB-INF/views/order_success.jsp").forward(req, resp);

        } catch (RuntimeException ex) {
            String msg = ex.getMessage() == null ? "" : ex.getMessage();
            if (msg.startsWith("OUT_OF_STOCK:")) {
                String[] parts = msg.split(":", 3);
                Long pid = parts.length >= 2 ? Long.valueOf(parts[1]) : null;
                String pname = parts.length >= 3 ? parts[2] : null;
                req.setAttribute("error", "Requested quantity exceeds available stock");
                req.setAttribute("oosProductId", pid);
                req.setAttribute("oosProductName", pname);
                req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
            } else {
                throw ex;
            }
        }
    }
}
