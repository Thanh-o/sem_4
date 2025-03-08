<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New Loan</title>
</head>
<body>
<h2>Create New Loan</h2>
<form action="${pageContext.request.contextPath}/loans" method="post">
    <label>Book ID: <input type="number" name="bookId" required></label><br>
    <label>Member ID: <input type="number" name="memberId" required></label><br>
    <input type="submit" value="Create Loan">
</form>
<a href="${pageContext.request.contextPath}/loans">Back to Loan List</a>
</body>
</html>