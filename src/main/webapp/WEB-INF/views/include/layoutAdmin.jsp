<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<c:set var="myContextPath" value="${pageContext.request.contextPath}"/>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- jQuery 2.2.3 -->
<script src="${myContextPath}/resources/admin/js/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="${myContextPath}/resources/admin/css/bootstrap.min.css">
<!-- DateRangePicker CSS -->
<link rel="stylesheet" href="${myContextPath}/resources/admin/css/daterangepicker.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${myContextPath}/resources/admin/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
     folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="${myContextPath}/resources/admin/css/_all-skins.min.css">
<!-- FastClick -->
<script src="${myContextPath}/resources/admin/js/fastclick.js"></script>
<script src="${myContextPath}/resources/admin/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="${myContextPath}/resources/admin/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${myContextPath}/resources/admin/js/demo.js"></script>

<!-- Select2 -->
<script src="${myContextPath}/resources/admin/js/select2.full.min.js"></script>
<!-- InputMask -->
<script src="${myContextPath}/resources/admin/js/jquery.inputmask.js"></script>
<script src="${myContextPath}/resources/admin/js/jquery.inputmask.date.extensions.js"></script>
<script src="${myContextPath}/resources/admin/js/jquery.inputmask.extensions.js"></script>
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="${myContextPath}/resources/admin/js/daterangepicker.js"></script>
<!-- bootstrap datepicker -->
<script src="${myContextPath}/resources/admin/js/bootstrap-datepicker.js"></script>
<!-- bootstrap color picker -->
<script src="${myContextPath}/resources/admin/js/bootstrap-colorpicker.min.js"></script>
<!-- bootstrap time picker -->
<script src="${myContextPath}/resources/admin/js/bootstrap-timepicker.min.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="${myContextPath}/resources/admin/js/jquery.slimscroll.min.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${myContextPath}/resources/admin/js/icheck.min.js"></script>

<title><tiles:getAsString name="title" /></title>

</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
	<tiles:insertAttribute name="header" />
	<tiles:insertAttribute name="sidebar" />
	<tiles:insertAttribute name="content" />
	<tiles:insertAttribute name="footer" />
	</div>
</body>
</html>
