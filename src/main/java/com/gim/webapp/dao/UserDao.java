package com.gim.webapp.dao;

import com.gim.webapp.model.User;
import org.hibernate.query.Query;

public class UserDao extends Dao {
    public User findByEmail(String email) {
        return tx(s -> {
            Query<User> q = s.createQuery("from User where email=:email", User.class);
            q.setParameter("email", email);
            return q.uniqueResult();
        });
    }

    public User save(User u) {
        return tx(s -> {
            s.save(u);
            return u;
        });
    }
}
