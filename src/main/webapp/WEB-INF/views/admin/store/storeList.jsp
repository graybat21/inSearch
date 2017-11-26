<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/resources/admin/js/commonBoard.js"></script>
<style type="text/css">
th {
	text-align: center;
}
</style>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>추가된 장소 리스트</h1>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						Store Name&nbsp;:&nbsp; 
						<input type="text" id="k" name="k" value="${searchStoreKeyword}">
						<input type="button" id="searchBtn" value="검색">
						
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<table id="example1" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th width="30%">store</th>
									<th width="60%">address</th>
									<th width="10%">코멘트 조회</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${storeList}" varStatus="status">
									<tr>
										<td>${list.name}</td>
										<td>${list.address}</td>
										<td style="text-align:center"><a href="comments/store_no/${list.no}" class="btn btn-info btn-sm" role="button" target="_blank">조회</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- /.box-body -->
					<!-- 페이징 -->
					<div class="box-footer clearfix">
						<ul class="pagination pagination-sm no-margin pull-right">
							<c:if test="${pageMaker.prev}">
								<c:if test="${ not empty param.q }">
									<c:url var="storeListP" value="storeList">
										<c:param name="page" value="${pageMaker.start - 1}" />
										<c:param name="q" value="${param.q}" />
									</c:url>
								</c:if>
								<c:if test="${ empty param.q }">
									<c:url var="storeListP" value="storeList">
										<c:param name="page" value="${pageMaker.start - 1}" />
									</c:url>
								</c:if>
								<li><a href="${storeListP }">이전</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.start }"
								end="${pageMaker.end}" var="idx">
								<c:if test="${ not empty param.q }">
									<c:url var="storeListP" value="storeList">
										<c:param name="page" value="${idx}" />
										<c:param name="q" value="${param.q}" />
									</c:url>
								</c:if>
								<c:if test="${ empty param.q }">
									<c:url var="storeListP" value="storeList">
										<c:param name="page" value="${idx}" />
									</c:url>
								</c:if>
								<li class='<c:out value="${idx == pageMaker.page ? 'current' : ''}"/>'>
									<a href='${storeListP}'>${idx}</a>
								</li>
								
							</c:forEach>
							<c:if test="${pageMaker.next }">
								<c:if test="${ not empty param.q }">
									<c:url var="storeListP" value="storeList">
										<c:param name="page" value="${pageMaker.end + 1}" />
										<c:param name="q" value="${param.q}" />
									</c:url>
								</c:if>
								<c:if test="${ empty param.q }">
									<c:url var="storeListP" value="storeList">
										<c:param name="page" value="${pageMaker.end + 1}" />
									</c:url>
								</c:if>
								<li><a href="${storeListP}">다음</a></li>
							</c:if>
						</ul>
					</div>
				</div>
				<!-- /.box -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->

	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<script type="text/javascript">
var header = $("meta[name='_csrf_header']").attr("content");
var token  = $("meta[name='_csrf']").attr("content");

$(document).ready(function() {
	$('#searchBtn').on("click", function(event) {
		if ( $('#k').val() == '' ) {
			alert("검색어를 입력하세요.");
			return;	
		}

		self.location = "storeList" + "?q=name%3D" + $('#k').val();
	});	
});
</script>
