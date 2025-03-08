<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sách</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<h2>Danh Sách Sách</h2>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên Sách</th>
        <th>Tác Giả</th>
    </tr>
    </thead>
    <tbody id="book-list">
    <!-- Dữ liệu sẽ được thêm vào đây bằng jQuery -->
    </tbody>
</table>

<script>
    $(document).ready(function () {
        $.ajax({
            url: "/books", // Kiểm tra đúng đường dẫn
            type: "GET",
            dataType: "json",
            success: function (data) {
                let rows = "";
                data.forEach(book => {
                    rows += `<tr>
                                <td>${book.id}</td>
                                <td>${book.title}</td>
                                <td>${book.author}</td>
                            </tr>`;
                });
                $("#book-list").html(rows);
            },
            error: function (xhr, status, error) {
                console.log("Lỗi AJAX:", error); // Debug lỗi
                alert("Không thể tải danh sách sách!");
            }
        });
    });
</script>

</body>
</html>
