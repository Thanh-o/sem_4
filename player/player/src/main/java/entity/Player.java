package entity;

import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Player {
    private int playerId;
    private String name;
    private String fullName;
    private int age;  // Changed back to int to match original functionality
    private int indexId;

    // Constructors
    public Player() {}

    public Player(String name, String fullName, int age, int indexId) {
        this.name = name;
        this.fullName = fullName;
        this.age = age;
        this.indexId = indexId;
    }

    // Getters and Setters
    public int getPlayerId() { return playerId; }
    public void setPlayerId(int playerId) { this.playerId = playerId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public int getIndexId() { return indexId; }
    public void setIndexId(int indexId) { this.indexId = indexId; }

    // Nested PlayerIndex class
    public static class PlayerIndex {
        private int id;
        private String playerName;
        private int age;
        private String indexName;
        private float value;

        public PlayerIndex(int id, String playerName, int age, String indexName, float value) {
            this.id = id;
            this.playerName = playerName;
            this.age = age;
            this.indexName = indexName;
            this.value = value;
        }

        // Getters
        public int getId() { return id; }
        public String getPlayerName() { return playerName; }
        public int getAge() { return age; }
        public String getIndexName() { return indexName; }
        public float getValue() { return value; }
    }

    // Get all players
    public List<PlayerIndex> getAll() {
        List<PlayerIndex> playerIndices = new ArrayList<>();
        String sql = "SELECT p.player_id, p.name AS player_name, p.age, i.name AS index_name, pi.value " +
                "FROM player p " +
                "LEFT JOIN player_index pi ON p.player_id = pi.player_id " +
                "LEFT JOIN indexer i ON pi.index_id = i.index_id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String ageStr = rs.getString("age");
                int age = 0;
                try {
                    age = ageStr != null ? Integer.parseInt(ageStr) : 0;
                } catch (NumberFormatException e) {
                    System.err.println("Invalid age format for player: " + rs.getString("player_name"));
                }

                PlayerIndex playerIndex = new PlayerIndex(
                        rs.getInt("player_id"),
                        rs.getString("player_name"),
                        age,
                        rs.getString("index_name"),
                        rs.getFloat("value")
                );
                playerIndices.add(playerIndex);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return playerIndices;
    }

    // Add a new player with their index
    public boolean add(String playerName, int age, String indexName, float value) {
        Connection conn = null;
        PreparedStatement stmtPlayer = null;
        PreparedStatement stmtPlayerIndex = null;
        PreparedStatement stmtIndexer = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Step 1: Insert into player table (set fullName same as name)
            String insertPlayerSQL = "INSERT INTO player (name, full_name, age) VALUES (?, ?, ?)";
            stmtPlayer = conn.prepareStatement(insertPlayerSQL, Statement.RETURN_GENERATED_KEYS);
            stmtPlayer.setString(1, playerName); // name
            stmtPlayer.setString(2, playerName); // full_name (same as name)
            stmtPlayer.setInt(3, age);
            int affectedRows = stmtPlayer.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating player failed, no rows affected.");
            }

            // Get the generated player_id
            generatedKeys = stmtPlayer.getGeneratedKeys();
            if (!generatedKeys.next()) {
                throw new SQLException("Creating player failed, no ID obtained.");
            }
            int playerId = generatedKeys.getInt(1);

            // Step 2: Check if indexName exists in indexer table, if not insert it
            int indexId;
            String selectIndexerSQL = "SELECT index_id FROM indexer WHERE name = ?";
            stmtIndexer = conn.prepareStatement(selectIndexerSQL);
            stmtIndexer.setString(1, indexName);
            ResultSet rsIndexer = stmtIndexer.executeQuery();

            if (rsIndexer.next()) {
                indexId = rsIndexer.getInt("index_id");
            } else {
                // Insert new indexName into indexer table
                String insertIndexerSQL = "INSERT INTO indexer (name) VALUES (?)";
                stmtIndexer = conn.prepareStatement(insertIndexerSQL, Statement.RETURN_GENERATED_KEYS);
                stmtIndexer.setString(1, indexName);
                stmtIndexer.executeUpdate();

                ResultSet indexerKeys = stmtIndexer.getGeneratedKeys();
                if (indexerKeys.next()) {
                    indexId = indexerKeys.getInt(1);
                } else {
                    throw new SQLException("Creating indexer failed, no ID obtained.");
                }
            }

            // Step 3: Insert into player_index table
            String insertPlayerIndexSQL = "INSERT INTO player_index (player_id, index_id, value) VALUES (?, ?, ?)";
            stmtPlayerIndex = conn.prepareStatement(insertPlayerIndexSQL);
            stmtPlayerIndex.setInt(1, playerId);
            stmtPlayerIndex.setInt(2, indexId);
            stmtPlayerIndex.setFloat(3, value);
            stmtPlayerIndex.executeUpdate();

            conn.commit(); // Commit transaction
            return true;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            // Close resources
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (stmtPlayer != null) stmtPlayer.close();
                if (stmtPlayerIndex != null) stmtPlayerIndex.close();
                if (stmtIndexer != null) stmtIndexer.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
  }