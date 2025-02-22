package model;

import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private int price;
    private String description;

    public Product() {}

    public Product(int id, String name, int price, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public static boolean addProduct(Product product) throws SQLException, ClassNotFoundException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO products (name, price, description) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, product.getName());
        pstmt.setInt(2, product.getPrice());
        pstmt.setString(3, product.getDescription());
        boolean result = pstmt.executeUpdate() > 0;
        DBUtil.close(conn, pstmt, null);
        return result;
    }

    public static List<Product> getAllProducts() throws SQLException, ClassNotFoundException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM products";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        List<Product> productList = new ArrayList<>();
        while (rs.next()) {
            productList.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("price"),
                    rs.getString("description")
            ));
        }
        DBUtil.close(conn, stmt, rs);
        return productList;
    }

    public static boolean updateProduct(Product product) throws SQLException, ClassNotFoundException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE products SET name = ?, price = ?, description = ? WHERE id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, product.getName());
        pstmt.setInt(2, product.getPrice());
        pstmt.setString(3, product.getDescription());
        pstmt.setInt(4, product.getId());
        boolean result = pstmt.executeUpdate() > 0;
        DBUtil.close(conn, pstmt, null);
        return result;
    }

    public static boolean deleteProduct(int id) throws SQLException, ClassNotFoundException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM products WHERE id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        boolean result = pstmt.executeUpdate() > 0;
        DBUtil.close(conn, pstmt, null);
        return result;
    }
}
