<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body onload="logingo()">
	<div class="form">		
		<h3>정상적인 경로로 접속하지 않았습니다.</h3>
		<div id="num" ></div>	
	</div>
<script>
var secondnum=3;
var secondcheck=0;
function logingo(){	
	if(secondcheck<3){		
		document.getElementById("num").innerHTML=secondnum+"초후 로그인화면으로 이동합니다.";
		secondnum--;
		secondcheck++;
		setTimeout('logingo()',1000);
	}
	setTimeout(function(){location.href="login.do"},3000);
}
</script>	
</body>
</html>