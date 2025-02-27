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

        Integer senderId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_id".equals(cookie.getName())) {
                    senderId = Integer.parseInt(cookie.getValue());
                    break;
                }
            }
        }


        if (senderId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int recipientId = Integer.parseInt(request.getParameter("recipient"));
            double amount = Double.parseDouble(request.getParameter("amount"));

            Account accountDAO = new Account();
            boolean success = accountDAO.transfer(senderId, recipientId, amount);

            if (success) {
                request.setAttribute("message", "Transfer successful");
                response.sendRedirect("history");
            } else {
                request.setAttribute("error", "Transfer failed. Check recipient ID or balance.");
                request.getRequestDispatcher("transfer.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format");
            request.getRequestDispatcher("transfer.jsp").forward(request, response);
        }
    }
}
