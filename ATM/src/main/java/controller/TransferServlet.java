package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Account;

import java.io.IOException;

@WebServlet("/transfer")
public class TransferServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy senderAccountId từ form thay vì từ cookie user_id
        String senderAccountIdStr = request.getParameter("senderAccountId");
        if (senderAccountIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int senderAccountId = Integer.parseInt(senderAccountIdStr);
            int recipientAccountId = Integer.parseInt(request.getParameter("recipientAccountId"));
            double amount = Double.parseDouble(request.getParameter("amount"));

            Account accountDAO = new Account();
            boolean success = accountDAO.transfer(senderAccountId, recipientAccountId, amount);

            if (success) {
                request.getSession().setAttribute("message", "Transfer successful");
                response.sendRedirect("history?accountId=" + senderAccountId); // Truyền accountId về history
            } else {
                request.getSession().setAttribute("error", "Transfer failed. Check recipient account ID or balance.");
                response.sendRedirect("transfer.jsp?accountId=" + senderAccountId); // Quay lại với accountId
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid input format");
            response.sendRedirect("transfer.jsp?accountId=" + senderAccountIdStr); // Quay lại với accountId
        }
    }
}