package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Account;

import java.io.IOException;
import java.util.List;

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
        List<Account> accounts = accountModel.getAccountsByUserId(userId);

        int currentIndex = 0;
        String indexParam = request.getParameter("currentIndex");
        if (indexParam != null && !indexParam.isEmpty()) {
            currentIndex = Integer.parseInt(indexParam);
        }

        if (accounts.isEmpty()) {
            currentIndex = -1;
        } else if (currentIndex < 0 || currentIndex >= accounts.size()) {
            currentIndex = 0;
        }

        request.setAttribute("accounts", accounts);
        request.setAttribute("currentIndex", currentIndex);
        request.getRequestDispatcher("user.jsp").forward(request, response);
    }
}
