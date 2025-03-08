<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Member</title>
</head>
<body>
<h1>Add New Member</h1>
<form action="${pageContext.request.contextPath}/members/add" method="post">
    <div>
        <label>First Name:</label>
        <input type="text" name="firstName" required>
    </div>
    <div>
        <label>Last Name:</label>
        <input type="text" name="lastName" required>
    </div>
    <div>
        <label>Email:</label>
        <input type="email" name="email" required>
    </div>
    <button type="submit">Save</button>
    <a href="${pageContext.request.contextPath}/members">Cancel</a>
</form>
</body>
</html>