package controller;

import entity.Player;
import entity.Player.PlayerIndex;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PlayerServlet", urlPatterns = {"/player"})
public class PlayerServlet extends HttpServlet {
    private Player playerModel;

    @Override
    public void init() throws ServletException {
        playerModel = new Player();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch all player-index data
        List<PlayerIndex> playerIndices = playerModel.getAll();
        request.setAttribute("playerIndices", playerIndices);

        // Forward to JSP
        request.getRequestDispatcher("player.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters from the request
        String playerName = request.getParameter("playerName");
        String ageStr = request.getParameter("playerAge");
        String indexName = request.getParameter("indexName");
        String valueStr = request.getParameter("value");

        // Validate and parse the input
        try {
            int age = Integer.parseInt(ageStr);
            float value = Float.parseFloat(valueStr);

            // Validate input (basic validation)
            if (playerName == null || playerName.trim().isEmpty() ||
                    indexName == null || indexName.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Player name and index name cannot be empty.");
                // Re-fetch the list and forward back to the JSP with an error
                List<PlayerIndex> playerIndices = playerModel.getAll();
                request.setAttribute("playerIndices", playerIndices);
                request.getRequestDispatcher("player.jsp").forward(request, response);
                return;
            }

            // Call the add method from the Player model
            boolean success = playerModel.add(playerName, age, indexName, value);

            if (success) {
                // On success, redirect to the same servlet to refresh the page (GET request)
                response.sendRedirect(request.getContextPath() + "/player");
            } else {
                // On failure, set an error message and forward back to the JSP
                request.setAttribute("errorMessage", "Failed to add player. Please try again.");
                List<PlayerIndex> playerIndices = playerModel.getAll();
                request.setAttribute("playerIndices", playerIndices);
                request.getRequestDispatcher("player.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            // Handle invalid number format for age or value
            request.setAttribute("errorMessage", "Invalid age or value format. Please enter numeric values.");
            List<PlayerIndex> playerIndices = playerModel.getAll();
            request.setAttribute("playerIndices", playerIndices);
            request.getRequestDispatcher("player.jsp").forward(request, response);
        }
    }
}