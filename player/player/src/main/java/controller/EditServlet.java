package controller;

import entity.Player;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/edit")
public class EditServlet extends HttpServlet {
    private Player playerModel;

    @Override
    public void init() throws ServletException {
        playerModel = new Player();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int playerId = Integer.parseInt(request.getParameter("playerId"));

            request.setAttribute("playerId", playerId);
            request.getRequestDispatcher("/edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int playerId = Integer.parseInt(request.getParameter("playerId"));
            String name = request.getParameter("name");
            String fullName = request.getParameter("fullName");
            int age = Integer.parseInt(request.getParameter("age"));
            int indexId = Integer.parseInt(request.getParameter("indexId"));
            float value = Float.parseFloat(request.getParameter("value"));

            boolean success = playerModel.editPlayer(playerId, name, fullName, age, indexId, value);

            if (success) {
                response.sendRedirect("player"); // Chuyển hướng đến danh sách sau khi chỉnh sửa
            } else {
                request.setAttribute("error", "Failed to update player");
                request.getRequestDispatcher("/edit.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format");
            request.getRequestDispatcher("/edit.jsp").forward(request, response);
        }
    }
}