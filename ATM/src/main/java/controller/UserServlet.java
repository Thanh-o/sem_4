package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Account;

import java.io.IOException;

@WebServlet(name = "UserServlet", value = "/user")
public class UserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int userId = -1;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_id".equals(cookie.getName())) {
                    userId = Integer.parseInt(cookie.getValue());
                    break;
                }
            }
        }

        if (userId == -1) {
            response.sendRedirect("login.jsp");
            return;
        }

        Account accountModel = new Account();
        double balance = accountModel.getBalance(userId);

        request.setAttribute("balance", balance);
        request.getRequestDispatcher("user.jsp").forward(request, response);
    }
}
