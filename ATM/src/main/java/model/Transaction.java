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
    private int accountId;
    private String type;
    private double amount;
    private Integer recipient;
    private Timestamp createdAt;

    public Transaction() {}

    public Transaction(int accountId, String type, double amount, Integer recipient, Timestamp createdAt) {
        this.accountId = accountId;
        this.type = type;
        this.amount = amount;
        this.recipient = recipient;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    // Sửa tên getter/setter từ getUserId/setUserId thành getAccountId/setAccountId cho đúng ngữ nghĩa
    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public Integer getRecipient() { return recipient; }
    public void setRecipient(Integer recipient) { this.recipient = recipient; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public List<Transaction> getTransactions(int accountId) {
        List<Transaction> transactions = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT id, account_id, type, amount, recipient, created_at " +
                             "FROM transactions WHERE account_id = ? ORDER BY created_at DESC")) {
            stmt.setInt(1, accountId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setId(rs.getInt("id"));
                transaction.setAccountId(rs.getInt("account_id"));
                transaction.setType(rs.getString("type"));
                transaction.setAmount(rs.getDouble("amount"));
                // Xử lý recipient có thể null
                int recipient = rs.getInt("recipient");
                transaction.setRecipient(rs.wasNull() ? null : recipient);
                transaction.setCreatedAt(rs.getTimestamp("created_at"));
                transactions.add(transaction);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return transactions;
    }
}