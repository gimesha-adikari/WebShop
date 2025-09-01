package com.gim.webapp.dao;

import com.gim.webapp.model.Product;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class ProductDao extends Dao {
    public long countByNameLike(String q) {
        return tx(s -> {
            Query<Long> cq = s.createQuery("select count(p.id) from Product p where lower(p.name) like :q", Long.class);
            cq.setParameter("q", "%" + q.toLowerCase() + "%");
            return cq.uniqueResult();
        });
    }

    public List<Product> searchByNameLike(String q, int offset, int limit) {
        return tx(s -> {
            Query<Product> query = s.createQuery("from Product p where lower(p.name) like :q order by p.id desc", Product.class);
            query.setParameter("q", "%" + q.toLowerCase() + "%");
            query.setFirstResult(offset);
            query.setMaxResults(limit);
            return query.getResultList();
        });
    }

    public Product findById(Long id) {
        return tx(s -> s.get(Product.class, id));
    }

    public Product save(Product p) {
        return tx(s -> {
            s.save(p);
            return p;
        });
    }

    public boolean decrementStock(Session s, Long productId, int qty) {
        int updated = s.createMutationQuery(
                        "update Product p set p.stock = p.stock - :qty where p.id = :id and p.stock >= :qty")
                .setParameter("qty", qty)
                .setParameter("id", productId)
                .executeUpdate();
        return updated == 1;
    }

    public boolean decrementStock(Long productId, int qty) {
        return tx(s -> decrementStock(s, productId, qty));
    }

    public Product get(Session s, Long id) {
        return s.get(Product.class, id);
    }
}
