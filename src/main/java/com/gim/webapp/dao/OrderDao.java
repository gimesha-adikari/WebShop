package com.gim.webapp.dao;

import com.gim.webapp.model.Order;
import com.gim.webapp.model.OrderItem;

public class OrderDao extends Dao {
    public Order save(Order order) {
        return tx(s -> {
            s.save(order);
            for (OrderItem it : order.getItems()) s.save(it);
            return order;
        });
    }
}
