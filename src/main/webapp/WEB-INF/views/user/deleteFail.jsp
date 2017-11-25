<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html class='no-js' lang='ko'>
<head>
<script type="text/javascript">
function deleteFail(){
	alert('비밀번호를 다시 확인하세요.');
	location.href= "/update";
}
</script>
</head>
<body onload="deleteFail()">

</body>
</html>