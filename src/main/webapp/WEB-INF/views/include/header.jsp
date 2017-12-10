<%@ page pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="_csrf_header" content="X-CSRF-TOKEN" />
<meta name="${_csrf.parameterName}" content="${_csrf.token}" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>   

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/views/include/include-header.jspf" %>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
</style>
<c:if test="${ email != null }">
<div class="header" style="width:100%;">
	<h4>insearch</h4>
	<div class="header_info">
		<b style='text-decoration:underline;'>${email_info}</b>
		<a id="header_login" href="/logout">log-out</a>
		<a id="header_login" href="/update">info-change</a>
	
	</div>
</div>
</c:if>