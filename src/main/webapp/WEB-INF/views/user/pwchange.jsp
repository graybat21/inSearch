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
	<h3>��й�ȣ ����</h3>
	Password Input <input type='password' name='pw'><br>
	Password Check <input type='password' name='pw2'><br>
	<button type='button' onclick='pwCheck()'>Password Change</button>
</form>
<script>
function pwCheck(){
	var pw=document.pwChange.pw.value;
	var pw2=document.pwChange.pw2.value;
	
	if(pw.length<6){
		alert('�����ȣ�� �ּ� 6�ڸ� �̻� �Է��ؾ��մϴ�.');	
	}else if(pw!=pw2){
		alert('��й�ȣ�� �ٸ��� �ԷµǾ����ϴ�.');
	}else{
		alert('��й�ȣ ������ �Ϸ� �Ǿ����ϴ�.');
		document.pwChange.submit();
	}
}
</script>

</body>
</html>