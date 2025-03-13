<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Player Information</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0 300px 50px 300px;

        }

        h1 {
            text-align: center;
            color: #e59c1f;
            font-size: 40px;
            margin-bottom: 20px;
        }

        .form-container {
            background: white;
            padding: 15px;

            border-radius: 5px;
            margin-bottom: 20px;
            position: relative; /* Để định vị nút Add */
            min-height: 120px; /* Đảm bảo form có đủ chiều cao để chứa các trường và nút */
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2 cột cho các trường nhập liệu */
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-container label {
            color: #333;
            margin-bottom: 5px;
        }

        .form-container input[type="text"],
        .form-container input[type="number"],
        .form-container select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form-container button {
            padding: 5px 30px;
            background-color: #d2691e;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 20px;

        }

        .form-container .submit{
            display: flex;
            justify-content: flex-end;
        }

        .form-container button:hover {
            background-color: #b3591a;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            background-color: white;
            border-radius: 5px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: center;

        }

        th {
            background-color: #d2691e;
            color: white;

        }

        .action-icons a,
        .action-icons button {
            margin-right: 10px;
            text-decoration: none;
            color: #007bff;
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            font-size: 16px;
        }

        .footer {

            background-color: #d2691e;
            color: white;
            padding: 10px;
            margin-top: 20px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;

        }
    </style>
</head>
<body>
<h1>Player Information</h1>

<!-- Form thêm Player -->
<form action="player" method="post" class="form-container">
    <div class="form-grid">
        <div class="form-group">
            <label>Player name</label>
            <input type="text" name="name" placeholder="Player name" required>
        </div>
        <div class="form-group">
            <label>Player age</label>
            <input type="number" name="age" placeholder="Player age" required>
        </div>
        <div class="form-group">
            <label>Index name</label>
            <select name="indexId" required>
                <option value="">Index name</option>
                <option value="1">speed</option>
                <option value="2">strength</option>
                <option value="3">accuracy</option>
            </select>
        </div>
        <div class="form-group" style="width: 50%">
            <label>Value</label>
            <select name="value" required>
                <option value="">Value</option>
                <option value="90">90</option>
                <option value="1">1</option>
            </select>
        </div>
    </div>
    <div class="submit"><button type="submit">Add</button></div>
</form>

<table>
    <thead>
    <tr>
        <th>Id</th>
        <th>Player name</th>
        <th>Player age</th>
        <th>Index name</th>
        <th>Value</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${playerIndices}" var="player" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>${player.playerName}</td>
            <td>${player.age}</td>
            <td>${player.indexName}</td>
            <td><fmt:formatNumber value="${player.value}" pattern="#"/></td>
            <td class="action-icons">
                <a href="${pageContext.request.contextPath}/edit?playerId=${player.id}">
                    <button class="edit-btn"><i class="fas fa-edit"></i></button>
                </a>
                <form action="${pageContext.request.contextPath}/delete" method="post" style="display: inline;">
                    <input type="hidden" name="playerId" value="${player.id}">
                    <button type="submit" class="delete-btn"><i class="fas fa-trash-alt"></i></button>
                </form>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty playerIndices}">
        <tr>
            <td colspan="6">No players found</td>
        </tr>
    </c:if>
    </tbody>
</table>

<div class="footer">
    Số 8, Tôn Thất Thuyết, Cầu Giấy, Hà Nội
</div>
</body>
</html>