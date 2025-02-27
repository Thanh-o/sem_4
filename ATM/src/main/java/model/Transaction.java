package model;

import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Transaction {
    private int id;
    private int userId;
    private String type;
    private double amount;
    private Integer recipient;
    private Timestamp createdAt;

    public Transaction() {}

    public Transaction(int userId, String type, double amount, Integer recipient, Timestamp createdAt) {
        this.userId = userId;
        this.type = type;
        this.amount = amount;
        this.recipient = recipient;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public Integer getRecipient() { return recipient; }
    public void setRecipient(Integer recipient) { this.recipient = recipient; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public List<Transaction> getTransactions(int userId) {
        List<Transaction> transactions = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM transactions WHERE user_id = ? ORDER BY created_at DESC")) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                transactions.add(new Transaction(
                        rs.getInt("user_id"),
                        rs.getString("type"),
                        rs.getDouble("amount"),
                        rs.getInt("recipient"),
                        rs.getTimestamp("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return transactions;
    }
}
