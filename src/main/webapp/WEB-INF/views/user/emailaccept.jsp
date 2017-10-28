<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta  charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/instyle_css.css">
</head>
<body onload="logingo()">
	<div class="form">		
		<h3>이메일 인증이 완료 되었습니다.</h3>
		<h2>3초후 로그인화면으로 이동합니다.</h2>		
	</div>
<script>
function logingo(){
	setTimeout(function(){location.href="logingo.do"},3000);
}
</script>	
</body>
</html>