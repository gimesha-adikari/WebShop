package com.gim.webapp.web;

import com.gim.webapp.dao.UserDao;
import com.gim.webapp.model.User;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("fullName"), email = req.getParameter("email"), password = req.getParameter("password");
        if (fullName == null || email == null || password == null || fullName.isEmpty() || email.isEmpty() || password.isEmpty()) {
            resp.sendRedirect("register.jsp?error=Missing+fields");
            return;
        }
        if (userDao.findByEmail(email) != null) {
            resp.sendRedirect("register.jsp?error=Email+already+used");
            return;
        }
        User u = new User();
        u.setFullName(fullName);
        u.setEmail(email);
        u.setPasswordHash(BCrypt.hashpw(password, BCrypt.gensalt()));
        userDao.save(u);
        HttpSession session = req.getSession(true);
        session.setAttribute("userId", u.getId());
        session.setAttribute("userName", u.getFullName());
        resp.sendRedirect("products");
    }
}
