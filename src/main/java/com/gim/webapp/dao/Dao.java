package com.gim.webapp.dao;

import com.gim.webapp.config.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.function.Function;

public class Dao {
    public <T> T tx(Function<Session, T> work) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = s.beginTransaction();
            T r = work.apply(s);
            tx.commit();
            return r;
        } catch (RuntimeException e) {
            if (tx != null) {
                try { tx.rollback(); } catch (RuntimeException ignored) {}
            }
            throw e;
        } finally {
            try { s.close(); } catch (RuntimeException ignored) {}
        }
    }
}
