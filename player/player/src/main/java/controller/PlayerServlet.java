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
        List<PlayerIndex> playerIndices = playerModel.getAllPlayerIndices();
        request.setAttribute("playerIndices", playerIndices);

        // Forward to JSP
        request.getRequestDispatcher("player.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle form submission to add a new player-index entry
        String playerName = request.getParameter("playerName");
        int age = Integer.parseInt(request.getParameter("playerAge"));
        String indexName = request.getParameter("indexName");
        float value = Float.parseFloat(request.getParameter("value"));

        // Add the player-index entry
        playerModel.addPlayerIndex(playerName, age, indexName, value);

        // Redirect back to the player page to refresh the list
        response.sendRedirect("player");
    }
}