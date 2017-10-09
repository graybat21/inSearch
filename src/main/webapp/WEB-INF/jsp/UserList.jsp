<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>회원 목록</title>
</head>
<body>
<table>
	<c:forEach var="list" items="${userList}" varStatus="status">
	<tr>
	<td><strong>${list.id }</strong></td>
	<td>${list.no }</td>
	<td>${list.pw}</td>
	<td>${list.email}</td>
	<td>${list.agerange }</td>
	<td>${list.gender}</td>
	<td>${list.emailflag}</td>
	</tr>
	</c:forEach>
</table>
</body>
</html>