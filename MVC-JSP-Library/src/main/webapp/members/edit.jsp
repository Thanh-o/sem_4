<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Member</title>
</head>
<body>
<h1>Edit Member</h1>
<form action="${pageContext.request.contextPath}/members/edit" method="post">
    <input type="hidden" name="id" value="${member.id}">
    <div>
        <label>First Name:</label>
        <input type="text" name="firstName" value="${member.firstName}" required>
    </div>
    <div>
        <label>Last Name:</label>
        <input type="text" name="lastName" value="${member.lastName}" required>
    </div>
    <div>
        <label>Email:</label>
        <input type="email" name="email" value="${member.email}" required>
    </div>
    <button type="submit">Update</button>
    <a href="${pageContext.request.contextPath}/members">Cancel</a>
</form>
</body>
</html>