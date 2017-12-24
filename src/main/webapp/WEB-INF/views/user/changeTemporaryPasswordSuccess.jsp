<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html class='no-js' lang='ko'>
<head>
<script type="text/javascript">
function updateTemporaryPWSuccess(){
	alert('임시 비밀번호로 변경되었습니다. 이메일을 통해 임시 비밀번호를 확인해주세요.');
	location.href= "/login";
}
</script>
</head>
<body onload="updateTemporaryPWSuccess()">

</body>
</html>