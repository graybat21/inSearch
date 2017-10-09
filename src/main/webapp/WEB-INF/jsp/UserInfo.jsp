<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>회원 정보</title>
</head>
<body>
<table>
	<tr>
	<td><strong>${user.id }</strong></td>
	<td>${user.no }</td>
	<td>${user.pw}</td>
	<td>${user.email}</td>
	<td>${user.agerange }</td>
	<td>${user.gender}</td>
	<td>${user.emailflag}</td>
	</tr>
</table>
</body>
</html>