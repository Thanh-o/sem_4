<%--
  Created by IntelliJ IDEA.
  User: godwu
  Date: 3/8/2025
  Time: 9:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="addBook" method="post">
    <input type="text" name="title" placeholder="Book Title" required>
    <input type="text" name="author" placeholder="Author" required>
    <button type="submit">Add Book</button>
</form>

</body>
</html>
