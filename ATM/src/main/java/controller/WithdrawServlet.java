package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Account;

import java.io.IOException;

@WebServlet("/withdraw")
public class WithdrawServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer userId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_id".equals(cookie.getName())) {
                    userId = Integer.parseInt(cookie.getValue());
                    break;
                }
            }
        }

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            double amount = Double.parseDouble(request.getParameter("amount"));

            Account account = new Account();
            boolean success = account.withdraw(userId, amount);

            if (success) {
                request.getSession().setAttribute("message", "Withdrawal successful");
                response.sendRedirect("history");
            } else {
                request.getSession().setAttribute("error", "Insufficient funds");
                request.getRequestDispatcher("withdraw.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid amount format");
            request.getRequestDispatcher("withdraw.jsp").forward(request, response);
        }
    }
}
