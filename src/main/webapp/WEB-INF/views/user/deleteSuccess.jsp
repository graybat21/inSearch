<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html class='no-js' lang='ko'>
<head>
<script type="text/javascript">
function deleteSuccess(){
	alert('정상적으로 탈퇴되었습니다.');
	location.href= "/login";
}
</script>
</head>
<body onload="deleteSuccess()">

</body>
</html>