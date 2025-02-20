<%--
  Created by IntelliJ IDEA.
  User: Nguyen Trung Thanh
  Date: 13/02/2025
  Time: 11:40 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Form</title>
</head>
<body>
<h1>Login</h1>
<form action="login" method="post">
    Username: <input type="text" name="username">
    Password: <input type="password" name="password">
    <input type="submit" value="login">
</form>
<p style="color: red;">${error}</p>

</body>
</html>
