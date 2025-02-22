package controller;

import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ProductServlet", value = "/product")
public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Product> products = Product.getAllProducts();
            req.setAttribute("products", products);
            req.getRequestDispatcher("product.jsp").forward(req, resp);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                String name = req.getParameter("name");
                int price = Integer.parseInt(req.getParameter("price"));
                String description = req.getParameter("description");

                Product.addProduct(new Product(0, name, price, description));
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                int price = Integer.parseInt(req.getParameter("price"));
                String description = req.getParameter("description");

                Product.updateProduct(new Product(id, name, price, description));
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Product.deleteProduct(id);
            }
        } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        resp.sendRedirect("product.jsp");
    }
}
