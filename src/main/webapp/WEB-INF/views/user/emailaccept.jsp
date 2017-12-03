<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<body onload="logingo()">
	<div class="form">		
		<h3>이메일 인증이 완료되었습니다.</h3>
		<div id="num" ></div>		
	</div>
<script type="text/javascript">
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