<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title><tiles:getAsString name="title" /></title>
<style>
#content {
	min-height: 1000px
}
</style>
</head>
<body>
	<tiles:insertAttribute name="header" />
	<div id="content">
	<tiles:insertAttribute name="content" />
	</div>
	<tiles:insertAttribute name="footer" />

</body>
</html>
