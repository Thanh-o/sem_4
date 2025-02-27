package controller;

import model.Transaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        Transaction transactionDAO = new Transaction();
        List<Transaction> transactions = transactionDAO.getTransactions(userId);

        request.setAttribute("transactions", transactions);
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}
