package model;

import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Account {
    private int id;
    private int userId;
    private double balance;

    public Account() {}

    public Account(int userId, double balance) {
        this.userId = userId;
        this.balance = balance;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public double getBalance() { return balance; }
    public void setBalance(double balance) { this.balance = balance; }

    public List<Account> getAccountsByUserId(int userId) {
        List<Account> accounts = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT id, user_id, balance FROM accounts WHERE user_id = ?")) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Account account = new Account();
                account.setId(rs.getInt("id"));
                account.setUserId(rs.getInt("user_id"));
                account.setBalance(rs.getDouble("balance"));
                accounts.add(account);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accounts;
    }

    public Account getAccountById(int accountId) {
        Account account = null;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT id, user_id, balance FROM accounts WHERE id = ?")) {
            stmt.setInt(1, accountId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                account = new Account();
                account.setId(rs.getInt("id"));
                account.setUserId(rs.getInt("user_id"));
                account.setBalance(rs.getDouble("balance"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return account;
    }

    public boolean withdraw(int accountId, double amount) {
        Account account = getAccountById(accountId);
        if (account == null || account.getBalance() < amount) return false;

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);
            PreparedStatement stmt = conn.prepareStatement("UPDATE accounts SET balance = balance - ? WHERE id = ?");
            stmt.setDouble(1, amount);
            stmt.setInt(2, accountId);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO transactions (account_id, type, amount) VALUES (?, 'WITHDRAW', ?)");
                insertStmt.setInt(1, accountId);
                insertStmt.setDouble(2, amount);
                insertStmt.executeUpdate();
                conn.commit();

                account.setBalance(account.getBalance() - amount);
                return true;
            }
            conn.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean transfer(int senderAccountId, int recipientAccountId, double amount) {
        Account senderAccount = getAccountById(senderAccountId);
        Account recipientAccount = getAccountById(recipientAccountId);

        if (senderAccount == null || recipientAccount == null || senderAccount.getBalance() < amount) return false;

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            PreparedStatement deductStmt = conn.prepareStatement("UPDATE accounts SET balance = balance - ? WHERE id = ?");
            deductStmt.setDouble(1, amount);
            deductStmt.setInt(2, senderAccountId);
            int rows1 = deductStmt.executeUpdate();

            PreparedStatement addStmt = conn.prepareStatement("UPDATE accounts SET balance = balance + ? WHERE id = ?");
            addStmt.setDouble(1, amount);
            addStmt.setInt(2, recipientAccountId);
            int rows2 = addStmt.executeUpdate();

            if (rows1 > 0 && rows2 > 0) {
                PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO transactions (account_id, type, amount, recipient) VALUES (?, 'TRANSFER', ?, ?)");
                insertStmt.setInt(1, senderAccountId);
                insertStmt.setDouble(2, amount);
                insertStmt.setInt(3, recipientAccountId);
                insertStmt.executeUpdate();

                conn.commit();

                senderAccount.setBalance(senderAccount.getBalance() - amount);
                recipientAccount.setBalance(recipientAccount.getBalance() + amount);
                return true;
            }
            conn.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}