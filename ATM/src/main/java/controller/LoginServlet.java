package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Step 1
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        //Step 2
        User user = User.checkLogin(username, password);
        //Step 3
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user_id", user.getId());
            session.setAttribute("username", user.getUsername());
            resp.sendRedirect("user");
        }else {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
