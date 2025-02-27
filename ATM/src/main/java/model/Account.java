package model;

import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Account {
    private int userId;
    private double balance;

    public Account() {}

    public Account(int userId, double balance) {
        this.userId = userId;
        this.balance = balance;
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public double getBalance() { return balance; }
    public void setBalance(double balance) { this.balance = balance; }

    public double getBalance(int userId) {
        double balance = 0;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT balance FROM accounts WHERE user_id = ?")) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                balance = rs.getDouble("balance");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return balance;
    }

    public boolean withdraw(int userId, double amount) {
        double balance = getBalance(userId);
        if (balance < amount) return false;

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);
            PreparedStatement stmt = conn.prepareStatement("UPDATE accounts SET balance = balance - ? WHERE user_id = ?");
            stmt.setDouble(1, amount);
            stmt.setInt(2, userId);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO transactions (user_id, type, amount) VALUES (?, 'WITHDRAW', ?)");
                insertStmt.setInt(1, userId);
                insertStmt.setDouble(2, amount);
                insertStmt.executeUpdate();
                conn.commit();
                return true;
            }
            conn.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean transfer(int senderId, int recipientId, double amount) {
        double senderBalance = getBalance(senderId);
        if (senderBalance < amount) return false;

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            PreparedStatement deductStmt = conn.prepareStatement("UPDATE accounts SET balance = balance - ? WHERE user_id = ?");
            deductStmt.setDouble(1, amount);
            deductStmt.setInt(2, senderId);
            int rows1 = deductStmt.executeUpdate();

            PreparedStatement addStmt = conn.prepareStatement("UPDATE accounts SET balance = balance + ? WHERE user_id = ?");
            addStmt.setDouble(1, amount);
            addStmt.setInt(2, recipientId);
            int rows2 = addStmt.executeUpdate();

            if (rows1 > 0 && rows2 > 0) {
                PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO transactions (user_id, type, amount, recipient) VALUES (?, 'TRANSFER', ?, ?)");
                insertStmt.setInt(1, senderId);
                insertStmt.setDouble(2, amount);
                insertStmt.setInt(3, recipientId);
                insertStmt.executeUpdate();

                conn.commit();
                return true;
            }
            conn.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
