<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html class='no-js' lang='ko'>
<head>
<script type="text/javascript">
function noMatch(){
	alert('가입한 이메일이 아닙니다. 확인 후 다시 입력해주세요.');
	location.href= "/login";
}
</script>
</head>
<body onload="noMatch()">

</body>
</html>