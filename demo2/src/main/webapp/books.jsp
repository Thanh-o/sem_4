<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.fptaptech.demo2.model.Book, com.fptaptech.demo2.model.Transaction" %>
<%@ page import="com.fptaptech.demo2.Service.BookService, com.fptaptech.demo2.Service.TransactionService" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionUser = request.getSession();
    String username = (String) sessionUser.getAttribute("username");
    int userId = (sessionUser.getAttribute("userId") != null) ? (int) sessionUser.getAttribute("userId") : -1;

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    BookService bookService = new BookService();
    TransactionService transactionService = new TransactionService();

    List<Book> books = bookService.getAllBooks();
    List<Transaction> transactions = transactionService.getUserTransactions(userId);
    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📚 Library System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #e0eafc, #cfdef3);
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1300px;
            padding: 30px;
            margin: 0 auto;
        }
        .header {
            background: #ffffff;
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .header h2 {
            margin: 0;
            font-size: 1.8rem;
            color: #1e3a8a;
        }
        .card {
            border: none;
            border-radius: 20px;
            background: #ffffff;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
        }

        .card-body {
            padding: 30px;
        }
        .table {
            background: #f9fafb;
            border-radius: 12px;
            overflow: hidden;
            border-collapse: separate;
            border-spacing: 0;
        }
        .table th {
            background: #1e3a8a;
            color: white;
            font-weight: 600;
            padding: 15px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .table td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #e5e7eb;
        }
        .table tr:last-child td {
            border-bottom: none;
        }
        .btn-custom {
            padding: 10px 25px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: scale(1.08);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        .btn-borrow {
            background: #3b82f6;
            border: none;
        }
        .btn-return {
            background: #10b981;
            border: none;
        }
        .btn-logout {
            background: #ef4444;
            border: none;
            border-radius: 50px;
            padding: 10px 25px;
        }
        .alert {
            border-radius: 12px;
            padding: 15px 20px;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        h2, h3 {
            font-weight: 700;
            color: #1e3a8a;
            margin-bottom: 20px;
        }
        .badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .icon {
            margin-right: 8px;
        }
        /* Dark Mode Toggle */
        .dark-mode-toggle {
            cursor: pointer;
            font-size: 1.2rem;
            color: #1e3a8a;
        }
        .dark-mode body {
            background: linear-gradient(135deg, #1e3a8a, #111827);
            color: #e5e7eb;
        }
        .dark-mode .header,
        .dark-mode .card {
            background: #1f2937;
            color: #e5e7eb;
        }
        .dark-mode .table {
            background: #374151;
        }
        .dark-mode .table th {
            background: #111827;
        }
        .dark-mode .table td {
            border-bottom: 1px solid #4b5563;
        }
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            .header {
                flex-direction: column;
                text-align: center;
                gap: 10px;
            }
            .table {
                font-size: 0.9rem;
            }
            .btn-custom {
                padding: 8px 15px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Header -->
    <div class="header d-flex justify-content-between align-items-center">
        <h2><i class="fas fa-book-open text-primary"></i> Library System</h2>
        <div>
            <span class="me-3">Welcome, <strong><%= username %></strong></span>
            <a href="logout" class="btn btn-logout text-white"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
        <script>
            localStorage.removeItem("jwt_token");
        </script>
    </div>

    <!-- Message -->
    <% if (message != null) { %>
    <div class="alert <%= message.contains("failed") ? "alert-danger" : "alert-success" %>">
        <i class="fas <%= message.contains("failed") ? "fa-exclamation-triangle" : "fa-check-circle" %>"></i> <%= message %>
    </div>
    <% } %>

    <!-- Book List -->
    <div class="card mb-4">
        <div class="card-body">
            <h3 class="mb-4"><i class="fas fa-book"></i> Book List</h3>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Book book : books) { %>
                    <tr>
                        <td><%= book.getTitle() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td><%= book.getQuantity() %></td>
                        <td>
                            <span class="badge <%= "AVAILABLE".equals(book.getStatus()) ? "bg-success" : "bg-danger" %>">
                                <%= book.getStatus().equals("AVAILABLE") ? "Available" : "Out of stock" %>
                            </span>
                        </td>
                        <td>
                            <% if ("AVAILABLE".equals(book.getStatus())) { %>
                            <form action="borrow" method="post">
                                <input type="hidden" name="userId" value="<%= userId %>">
                                <input type="hidden" name="bookId" value="<%= book.getId() %>">
                                <button type="submit" class="btn btn-custom btn-borrow text-white">
                                    <i class="fas fa-book"></i> Borrow
                                </button>
                            </form>
                            <% } else { %>
                            <span class="text-danger"><i class="fas fa-times"></i> Out of stock</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Borrowing History -->
    <div class="card">
        <div class="card-body">
            <h3 class="mb-4"><i class="fas fa-history"></i> My Borrowing/Return History</h3>
            <% if (transactions.isEmpty()) { %>
            <div class="alert alert-warning"><i class="fas fa-exclamation-triangle"></i> You have not borrowed any books.</div>
            <% } else { %>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Book Title</th>
                        <th>Borrow Date</th>
                        <th>Due Date</th>
                        <th>Return Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Transaction t : transactions) { %>
                    <tr>
                        <td><%= t.getBookTitle() %></td>
                        <td><%= t.getBorrowDate() != null ? t.getBorrowDate() : "N/A" %></td>
                        <td><%= t.getDueDate() != null ? t.getDueDate() : "N/A" %></td>
                        <td><%= t.getReturnDate() != null ? t.getReturnDate() : "Not returned" %></td>
                        <td>
                            <span class="badge <%= "BORROWED".equals(t.getStatus()) ? "bg-warning" : "bg-success" %>">
                                <%= "BORROWED".equals(t.getStatus()) ? "Borrowed" : "Returned" %>
                            </span>
                        </td>
                        <td>
                            <% if ("BORROWED".equals(t.getStatus())) { %>
                            <form action="return" method="post">
                                <input type="hidden" name="transactionId" value="<%= t.getId() %>">
                                <input type="hidden" name="bookId" value="<%= t.getBookId() %>">
                                <button type="submit" class="btn btn-custom btn-return text-white">
                                    <i class="fas fa-undo"></i> Return
                                </button>
                            </form>
                            <% } else { %>
                            <span class="text-success"><i class="fas fa-check-circle"></i> Returned</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Confirm logout
        document.querySelector(".btn-logout").addEventListener("click", function (event) {
            event.preventDefault();
            if (confirm("Are you sure you want to logout?")) {
                window.location.href = "logout";
            }
        });

        // Confirm borrow
        document.querySelectorAll("form[action='borrow']").forEach(form => {
            form.addEventListener("submit", function (event) {
                event.preventDefault();
                if (confirm("Do you want to borrow this book?")) {
                    this.submit();
                }
            });
        });

        // Confirm return
        document.querySelectorAll("form[action='return']").forEach(form => {
            form.addEventListener("submit", function (event) {
                event.preventDefault();
                if (confirm("Do you want to return this book?")) {
                    this.submit();
                }
            });
        });
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>