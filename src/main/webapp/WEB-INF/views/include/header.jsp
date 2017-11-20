<%@ page pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="_csrf_header" content="X-CSRF-TOKEN" />
<meta name="${_csrf.parameterName}" content="${_csrf.token}" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>   

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/views/include/include-header.jspf" %>
<div class="field-wrap" style="width:100%;">
	<c:if test="${ email != null }">
		로그인 유저: ${email}&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="/logout">로그아웃</a>
	</c:if>
</div>
