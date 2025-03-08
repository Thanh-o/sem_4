<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.fptaptech.demo2.model.Book, com.fptaptech.demo2.model.Transaction" %>
<%@ page import="com.fptaptech.demo2.Service.BookService, com.fptaptech.demo2.Service.TransactionService" %>
<%
    BookService bookService = new BookService();
    TransactionService transactionService = new TransactionService();

    List<Book> books = bookService.getAllBooks();
    List<Transaction> transactions = transactionService.getUserTransactions(-1);
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Management - Admin</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/YOUR-FONT-AWESOME-KEY.js" crossorigin="anonymous"></script>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #007bff;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --light-bg: #f6f9fc;
            --dark-bg: #2c3e50;
            --shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--light-bg);
            transition: background 0.3s ease;
        }

        body.dark-mode {
            background: var(--dark-bg);
            color: #ecf0f1;
        }

        .container {
            max-width: 1200px;
        }

        .custom-card {
            border-radius: 20px;
            box-shadow: var(--shadow);
            padding: 2rem;
            background: white;
            transition: all 0.3s ease;
            margin-bottom: 2rem;
        }

        .dark-mode .custom-card {
            background: #34495e;
        }


        .btn-custom {
            border-radius: 10px;
            padding: 0.5rem 1.5rem;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            transform: scale(1.1);
            box-shadow: var(--shadow);
        }

        .table {
            border-radius: 10px;
            overflow: hidden;
            background: white;
        }

        .dark-mode .table {
            background: #34495e;
        }

        .table thead {
            background: var(--primary-color);
            color: white;
        }

        .table tbody tr {
            transition: background 0.2s ease;
        }

        .table tbody tr:hover {
            background: #e9ecef;
        }

        .dark-mode .table tbody tr:hover {
            background: #3e5c76;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
        }

        .mode-toggle {
            cursor: pointer;
            font-size: 1.5rem;
        }

        .form-control {
            border-radius: 10px;
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <!-- HEADER -->
    <div class="header">
        <h2 class="text-primary">📚 Book Library</h2>
        <div class="d-flex align-items-center gap-3">
            <p class="mb-0">Welcome, <strong><%= (session.getAttribute("adminName") != null) ? session.getAttribute("adminName") : "Admin" %></strong></p>
            <span class="mode-toggle" onclick="toggleDarkMode()">🌙</span>
            <a href="logout" class="btn btn-danger btn-custom" onclick="return confirmLogout();">Logout</a>
            <script>
                function confirmLogout() {
                    return confirm("Are you sure you want to logout?");
                }
            </script>

        </div>
    </div>

    <!-- NOTIFICATION -->
    <% if (message != null) { %>
    <div class="alert <%= message.contains("failed") ? "alert-danger" : "alert-success" %> text-center animate__animated animate__fadeIn">
        <%= message %>
    </div>
    <% } %>

    <!-- ADD BOOK FORM -->
    <div class="custom-card">
        <h3 class="text-success"><i class="fas fa-plus-circle"></i> Add New Book</h3>
        <form action="addBook" method="post" class="row g-3">
            <div class="col-md-4">
                <input type="text" name="title" placeholder="Book Title" required class="form-control">
            </div>
            <div class="col-md-4">
                <input type="text" name="author" placeholder="Author" required class="form-control">
            </div>
            <div class="col-md-2">
                <input type="number" name="quantity" placeholder="Quantity" min="1" required class="form-control">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-success w-100 btn-custom" onclick="return confirm('Confirm???')"><i class="fas fa-check"></i> Add</button>
            </div>
        </form>
    </div>

    <!-- BOOK LIST -->
    <div class="custom-card">
        <h3 class="text-primary"><i class="fas fa-book-open"></i> Book List</h3>
        <% if (books.isEmpty()) { %>
        <p class="text-danger">⚠️ No books available in the system.</p>
        <% } else { %>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Quantity</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (Book book : books) { %>
                <tr>
                    <td><%= book.getId() %></td>
                    <td><%= book.getTitle() %></td>
                    <td><%= book.getAuthor() %></td>
                    <td><%= book.getQuantity() %></td>
                    <td class="<%= book.getStatus().equals("AVAILABLE") ? "text-success" : "text-danger" %>">
                        <%= book.getStatus().equals("AVAILABLE") ? "Available" : "Out of Stock" %>
                    </td>
                    <td>
                        <a href="editBook.jsp?id=<%= book.getId() %>" class="btn btn-warning btn-sm btn-custom">✏️</a>
                        <a href="deleteBook?id=<%= book.getId() %>" onclick="return confirm('Delete this book?');" class="btn btn-danger btn-sm btn-custom">🗑️</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>

    <!-- TRANSACTION HISTORY -->
    <div class="custom-card">
        <h3 class="text-warning"><i class="fas fa-history"></i> Borrow/Return History</h3>
        <% if (transactions == null || transactions.isEmpty()) { %>
        <p class="text-danger">⚠️ No transactions found.</p>
        <% } else { %>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Borrower</th>
                    <th>Book Title</th>
                    <th>Borrow Date</th>
                    <th>Due Date</th>
                    <th>Return Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (Transaction t : transactions) { %>
                <tr>
                    <td><%= t.getUserName() %></td>
                    <td><%= t.getBookTitle() %></td>
                    <td><%= t.getBorrowDate() %></td>
                    <td><%= t.getDueDate() != null ? t.getDueDate() : "None" %></td>
                    <td><%= t.getReturnDate() != null ? t.getReturnDate() : "Not Returned" %></td>
                    <td class="<%= "BORROWED".equals(t.getStatus()) ? "text-warning" : "text-success" %>">
                        <%= "BORROWED".equals(t.getStatus()) ? "Borrowed" : "Returned" %>
                    </td>
                    <td>
                        <form action="deleteTransaction" method="post" onsubmit="return confirm('Are you sure you want to delete this transaction?');" class="d-inline">
                            <input type="hidden" name="transactionId" value="<%= t.getId() %>">
                            <button type="submit" class="btn btn-danger btn-sm btn-custom">🗑️</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>
</div>

<!-- JavaScript for Dark Mode -->
<script>
    function toggleDarkMode() {
        document.body.classList.toggle('dark-mode');
        const icon = document.querySelector('.mode-toggle');
        icon.textContent = document.body.classList.contains('dark-mode') ? '☀️' : '🌙';
    }
</script>

</body>
</html>