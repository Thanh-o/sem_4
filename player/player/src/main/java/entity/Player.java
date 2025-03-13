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
    public List<Player> getAllPlayers() {
        List<Player> players = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT player_id, name, full_name, age, index_id FROM player")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Player player = new Player();
                player.setPlayerId(rs.getInt("player_id"));
                player.setName(rs.getString("name"));
                player.setFullName(rs.getString("full_name"));
                player.setAge(rs.getInt("age"));
                player.setIndexId(rs.getInt("index_id"));
                players.add(player);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return players;
    }

    // Get all player-index combinations
    public List<PlayerIndex> getAllPlayerIndices() {
        List<PlayerIndex> playerIndices = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT pi.id, p.name AS player_name, p.age, i.name AS index_name, pi.value " +
                             "FROM player p " +
                             "JOIN player_index pi ON p.player_id = pi.player_id " +
                             "JOIN indexer i ON pi.index_id = i.index_id")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                playerIndices.add(new PlayerIndex(
                        rs.getInt("id"),
                        rs.getString("player_name"),
                        rs.getInt("age"),
                        rs.getString("index_name"),
                        rs.getFloat("value")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return playerIndices;
    }

    // Save new player
    public void save() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO player (name, full_name, age, index_id) VALUES (?, ?, ?, ?)",
                     Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, this.name);
            stmt.setString(2, this.fullName);
            stmt.setInt(3, this.age);
            stmt.setInt(4, this.indexId);
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    this.playerId = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Add player-index entry
    public void addPlayerIndex(String playerName, int age, String indexName, float value) {
        try (Connection conn = DBUtil.getConnection()) {
            // Check if player exists, if not, insert
            String playerSql = "SELECT player_id FROM player WHERE name = ? AND age = ?";
            PreparedStatement playerStmt = conn.prepareStatement(playerSql);
            playerStmt.setString(1, playerName);
            playerStmt.setInt(2, age);
            ResultSet playerRs = playerStmt.executeQuery();
            int playerId;

            if (playerRs.next()) {
                playerId = playerRs.getInt("player_id");
            } else {
                String insertPlayerSql = "INSERT INTO player (name, full_name, age, index_id) VALUES (?, ?, ?, ?)";
                PreparedStatement insertPlayerStmt = conn.prepareStatement(insertPlayerSql, Statement.RETURN_GENERATED_KEYS);
                insertPlayerStmt.setString(1, playerName);
                insertPlayerStmt.setString(2, playerName);
                insertPlayerStmt.setInt(3, age);
                insertPlayerStmt.setInt(4, getIndexId(conn, indexName));
                insertPlayerStmt.executeUpdate();

                ResultSet generatedKeys = insertPlayerStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    playerId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Failed to insert player");
                }
            }

            String insertIndexSql = "INSERT INTO player_index (player_id, index_id, value) VALUES (?, ?, ?)";
            PreparedStatement insertIndexStmt = conn.prepareStatement(insertIndexSql);
            insertIndexStmt.setInt(1, playerId);
            insertIndexStmt.setInt(2, getIndexId(conn, indexName));
            insertIndexStmt.setFloat(3, value);
            insertIndexStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Update player
    public void update() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE player SET name = ?, full_name = ?, age = ?, index_id = ? WHERE player_id = ?")) {
            stmt.setString(1, this.name);
            stmt.setString(2, this.fullName);
            stmt.setInt(3, this.age);
            stmt.setInt(4, this.indexId);
            stmt.setInt(5, this.playerId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Delete player
    public void delete() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "DELETE FROM player WHERE player_id = ?")) {
            stmt.setInt(1, this.playerId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Find player by ID
    public static Player findById(int playerId) {
        Player player = null;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT player_id, name, full_name, age, index_id FROM player WHERE player_id = ?")) {
            stmt.setInt(1, playerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                player = new Player();
                player.setPlayerId(rs.getInt("player_id"));
                player.setName(rs.getString("name"));
                player.setFullName(rs.getString("full_name"));
                player.setAge(rs.getInt("age"));
                player.setIndexId(rs.getInt("index_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return player;
    }

    // Helper method to get index ID
    private int getIndexId(Connection conn, String indexName) throws SQLException {
        String sql = "SELECT index_id FROM indexer WHERE name = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, indexName);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("index_id");
        }
        throw new SQLException("Index not found: " + indexName);
    }
}