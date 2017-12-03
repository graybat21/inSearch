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
		<h1>추가된 장소 상세정보 / 한줄평</h1>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						<label>
			              	장소 : ${storeVo.name}
		              	</label><br>
		              	<label>
			              	주소 : ${storeVo.address}
		              	</label><br>
		              	<label>
			              	별점 평균 : ${avgStar}
		              	</label><br>
						
						<select id="searchType" name="searchType">
							<option value="comment" 
								<c:out value="${searchType eq 'comment' ? 'selected' : ''}"/>>
							내용</option>
							<option value="email" 
								<c:out value="${searchType eq 'email' ? 'selected' : ''}"/>>
							이메일</option>
						</select>
						<input type="text" id="k" name="k" value="${searchKeyword}">
						<input type="button" id="searchBtn" value="검색">
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<table id="example1" class="table table-bordered table-hover" style="table-layout:fixed;">
							<thead>
								<tr>
									<th width="70%">comment</th>
									<th width="15%">E-mail</th>
									<th width="15%">코멘트 삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${commentList}" varStatus="status">
									<tr>
										<td style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden">${list.comment}</td>
										<td style="text-align:center;white-space: nowrap;text-overflow: ellipsis;overflow: hidden">${list.email}</td>
										<td style="text-align: center;"><button type="button" class="btn btn-info btn-sm" onclick="deleteComment('${list.no}')">삭제</button></td> 
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
									<c:url var="storeDetailP" value="${store_no}">
										<c:param name="page" value="${pageMaker.start - 1}" />
										<c:param name="q" value="${param.q}" />
									</c:url>
								</c:if>
								<c:if test="${ empty param.q }">
									<c:url var="storeDetailP" value="${store_no}">
										<c:param name="page" value="${pageMaker.start - 1}" />
									</c:url>
								</c:if>
								<li><a href="${storeDetailP }">이전</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.start }"
								end="${pageMaker.end}" var="idx">
								<c:if test="${ not empty param.q }">
									<c:url var="storeDetailP" value="${store_no}">
										<c:param name="page" value="${idx}" />
										<c:param name="q" value="${param.q}" />
									</c:url>
								</c:if>
								<c:if test="${ empty param.q }">
									<c:url var="storeDetailP" value="${store_no}">
										<c:param name="page" value="${idx}" />
									</c:url>
								</c:if>
								<li class='<c:out value="${idx == pageMaker.page ? 'current' : ''}"/>'>
									<a href='${storeDetailP}'>${idx}</a>
								</li>
								
							</c:forEach>
							<c:if test="${pageMaker.next }">
								<c:if test="${ not empty param.q }">
									<c:url var="storeDetailP" value="${store_no}">
										<c:param name="page" value="${pageMaker.end + 1}" />
										<c:param name="q" value="${param.q}" />
									</c:url>
								</c:if>
								<c:if test="${ empty param.q }">
									<c:url var="storeDetailP" value="${store_no}">
										<c:param name="page" value="${pageMaker.end + 1}" />
									</c:url>
								</c:if>
								<li><a href="${storeDetailP}">다음</a></li>
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

var store_no = ${store_no};
//var query = ${param.q};
//var page = ${param.page};

$(document).ready(function() {
	
	$("#k").keyup(function(event) {
	    if ( event.keyCode === 13 ) {
	        $("#searchBtn").click();
	    }
	});
	
	$('#searchBtn').on("click", function(event) {
		if ( $('#k').val() == '' ) {
			alert("검색어를 입력하세요.");
			return;	
		}

		self.location = store_no + "?q=type%3D" + $('#searchType').val() + ",keyword%3D" + $('#k').val();
	});	
});

function deleteComment(no) {
	var result = confirm("선택한 한줄평을 삭제하시겠습니까?");
	
	if ( result ) {
		$.ajax({
			type: 'post',
			url: '/admin/deleteComment',
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
		    },
			headers: {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType: "text",
			data: JSON.stringify({no: no}),
			success: function(result) {
				console.log("result: " + result);
				
				if ( result == 'SUCCESS' ) {
					alert("삭제되었습니다.");
					window.location.reload();
				}
			},
			error: function(request, status, error) {
			    alert("한줄평 삭제에 실패했습니다.");
			    window.location.reload();
		    }
		});
	}
}

</script>
