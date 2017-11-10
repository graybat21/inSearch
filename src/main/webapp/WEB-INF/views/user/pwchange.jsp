<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form name='pwChange' method='post' action='pwChange'>
	<input type='hidden' name='${_csrf.parameterName}'	value='${_csrf.token}'> 	
	<h3>비밀번호 변경</h3>
	Password Input <input type='password' name='pw'><br>
	Password Check <input type='password' name='pw2'><br>
	<button type='button' onclick='pwCheck()'>Password Change</button>
</form>
<script>
function pwCheck(){
	var pw=document.pwChange.pw.value;
	var pw2=document.pwChange.pw2.value;
	
	if(pw.length<6){
		alert('비밀전호를 최소 6자리 이상 입력해야합니다.');	
	}else if(pw!=pw2){
		alert('비밀번호가 다르게 입력되었습니다.');
	}else{
		alert('비밀번호 변경이 완료 되었습니다.');
		document.pwChange.submit();
	}
}
</script>

</body>
</html>