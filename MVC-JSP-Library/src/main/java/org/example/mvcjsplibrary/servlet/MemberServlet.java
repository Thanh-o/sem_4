package org.example.mvcjsplibrary.servlet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.mvcjsplibrary.dao.MemberDAO;
import org.example.mvcjsplibrary.entity.Member;

import java.io.IOException;

@WebServlet("/members/*")
public class MemberServlet extends HttpServlet {
    private MemberDAO memberDAO;

    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAO();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getPathInfo();

        if (action == null || action.equals("/")) {
            req.setAttribute("members", memberDAO.findAll());
            req.getRequestDispatcher("/members/list.jsp").forward(req, resp);
        } else if (action.equals("/add")) {

            req.getRequestDispatcher("/members/add.jsp").forward(req, resp);
        } else if (action.equals("/edit")) {
            Long id = Long.parseLong(req.getParameter("id"));
            req.setAttribute("member", memberDAO.findById(id));
            req.getRequestDispatcher("/members/edit.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getPathInfo();

        if (action.equals("/add")) {
            Member member = new Member();
            member.setFirstName(req.getParameter("firstName"));
            member.setLastName(req.getParameter("lastName"));
            member.setEmail(req.getParameter("email"));

            memberDAO.save(member);
            resp.sendRedirect(req.getContextPath() + "/members");
        } else if (action.equals("/edit")) {
            Long id = Long.parseLong(req.getParameter("id"));
            Member member = memberDAO.findById(id);
            member.setFirstName(req.getParameter("firstName"));
            member.setLastName(req.getParameter("lastName"));
            member.setEmail(req.getParameter("email"));

            memberDAO.update(member);
            resp.sendRedirect(req.getContextPath() + "/members");
        }
    }
}