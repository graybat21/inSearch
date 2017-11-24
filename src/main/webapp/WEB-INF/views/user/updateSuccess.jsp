<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html class='no-js' lang='ko'>
<head>
<script type="text/javascript">
function updateSuccess(){
	alert('회원정보가 성공적으로 변경되었습니다. 다시 로그인해주세요.');
	location.href= "/login";
}
</script>
</head>
<body onload="updateSuccess()">

</body>
</html>