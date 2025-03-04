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
        String senderAccountIdStr = request.getParameter("senderAccountId");

        try {
            int senderAccountId = Integer.parseInt(senderAccountIdStr);
            double amount = Double.parseDouble(request.getParameter("amount"));

            Account account = new Account();
            boolean success = account.withdraw(senderAccountId, amount);

            if (success) {
                request.getSession().setAttribute("message", "Withdrawal successful");
                response.sendRedirect("history?accountId=" + senderAccountId);
            } else {
                request.getSession().setAttribute("error", "Insufficient funds");
                response.sendRedirect("withdraw.jsp?accountId=" + senderAccountId);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid input format");
            response.sendRedirect("withdraw.jsp?accountId=" + senderAccountIdStr);
        }
    }

}
