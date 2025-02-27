package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;


import java.io.IOException;

@WebServlet("/withdraw")
public class WithdrawServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Account account = new Account();
        boolean success = account.withdraw(userId, amount);

        if (success) {
            session.setAttribute("message", "Withdrawal successful");
            response.sendRedirect("history");

        } else {
            session.setAttribute("error", "Insufficient funds");
            response.sendRedirect("withdraw.jsp");

        }
    }
}
