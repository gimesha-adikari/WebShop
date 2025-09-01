package com.gim.webapp.web;

import com.gim.webapp.dao.UserDao;
import com.gim.webapp.model.User;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email"), password = req.getParameter("password");
        User user = userDao.findByEmail(email);
        if (user != null && BCrypt.checkpw(password, user.getPasswordHash())) {
            HttpSession session = req.getSession(true);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getFullName());
            resp.sendRedirect("products");
        } else {
            resp.sendRedirect("login.jsp?error=Invalid+credentials");
        }
    }
}
