<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-header.jspf" %>
<body onload="logingo()">
<div class="form">		
<h1>Insearch..</h1>
</div>	
<script type="text/javascript">
function logingo(){
	setTimeout(function() {
		location.href = "login"
	}, 3000);
}
</script>
