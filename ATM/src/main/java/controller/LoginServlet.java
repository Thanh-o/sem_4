package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import util.JwtUtil;

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
            String token = JwtUtil.generateToken(username);
            Cookie jwtCookie = new Cookie("jwt_token", token);
            jwtCookie.setHttpOnly(true);
            jwtCookie.setMaxAge(60 * 60 * 24);
            jwtCookie.setPath("/");
            resp.addCookie(jwtCookie);

            Cookie userIdCookie = new Cookie("user_id", String.valueOf(user.getId()));
            userIdCookie.setMaxAge(60 * 60 * 24);
            userIdCookie.setPath("/");
            resp.addCookie(userIdCookie);

            resp.sendRedirect("user");

        }else {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
