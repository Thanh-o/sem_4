//package org.example.mvcjsplibrary.servlet;
//
//import jakarta.inject.Inject;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.example.mvcjsplibrary.bean.LoanBean;
//import org.example.mvcjsplibrary.entity.Loan;
//
//import java.io.IOException;
//import java.text.SimpleDateFormat;
//import java.util.Date;
//
//@WebServlet("/loans/*")
//public class LoanServlet extends HttpServlet {
//    @Inject
//    private LoanBean loanBean;
//
//    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//        String action = req.getPathInfo();
//
//        if (action == null || action.equals("/")) {
//            req.setAttribute("loans", loanBean.getLoans());
//            req.getRequestDispatcher("/loans/list.jsp").forward(req, resp);
//        } else if (action.equals("/borrow")) {
//            loanBean.setCurrentLoan(new Loan());
//            req.setAttribute("loan", loanBean.getCurrentLoan());
//            req.setAttribute("books", loanBean.getAvailableBooks());
//            req.setAttribute("members", loanBean.getMembers());
//            req.getRequestDispatcher("/loans/borrow.jsp").forward(req, resp);
//        } else if (action.equals("/return")) {
//            Long id = Long.parseLong(req.getParameter("id"));
//            loanBean.prepareEdit(id);
//            req.setAttribute("loan", loanBean.getCurrentLoan());
//            req.getRequestDispatcher("/loans/return.jsp").forward(req, resp);
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//        String action = req.getPathInfo();
//
//        if (action.equals("/borrow")) {
//            Loan loan = loanBean.getCurrentLoan();
//            loan.setBook(loanBean.getAvailableBooks().stream()
//                    .filter(b -> b.getId().equals(Long.parseLong(req.getParameter("bookId"))))
//                    .findFirst().orElse(null));
//            loan.setMember(loanBean.getMembers().stream()
//                    .filter(m -> m.getId().equals(Long.parseLong(req.getParameter("memberId"))))
//                    .findFirst().orElse(null));
//            loan.setBorrowDate(new Date());
//            try {
//                loan.setDueDate(dateFormat.parse(req.getParameter("dueDate")));
//            } catch (Exception e) {
//                loan.setDueDate(null);
//            }
//
//            loanBean.save();
//            resp.sendRedirect(req.getContextPath() + "/loans");
//        } else if (action.equals("/return")) {
//            Loan loan = loanBean.getCurrentLoan();
//            loan.setReturnDate(new Date());
//
//            loanBean.update();
//            resp.sendRedirect(req.getContextPath() + "/loans");
//        }
//    }
//}