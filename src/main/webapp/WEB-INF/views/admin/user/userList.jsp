<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="/resources/admin/js/commonBoard.js"></script>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>회원 리스트</h1>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						Email&nbsp;:&nbsp; 
						<input type="text" id="k" name="k" value="${searchEmailKeyword}">
						<input type="button" id="searchBtn" value="검색">
						
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<table id="example1" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>email</th>
									<th>agerange</th>
									<th>auth</th>
									<th>gender</th>
									<th>create_time</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${userList}" varStatus="status">
									<tr>
										<td>${list.email}</td>
										<td>${list.agerange}대</td>
										<td>${ ( list.emailflag == 'y' ) ? 'Yes' : 'No' }</td>
										<td>${ ( list.gender == 1 ) ? 'Man' : 'Woman' }</td>
										<td><fmt:formatDate value="${list.createdate}" pattern="yyyy-MM-dd HH:mm" /></td>
										<td><input type="button" value="탈 퇴" onclick="deleteUser('${list.email}')"></td> 
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
									<c:url var="userListP" value="userList">
										<c:param name="page" value="${pageMaker.start - 1}" />
										<c:param name="q" value="${param.q}" />
									</c:url>
								</c:if>
								<c:if test="${ empty param.q }">
									<c:url var="userListP" value="userList">
										<c:param name="page" value="${pageMaker.start - 1}" />
									</c:url>
								</c:if>
								<li><a href="${userListP }">이전</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.start }"
								end="${pageMaker.end}" var="idx">
								<c:if test="${ not empty param.q }">
									<c:url var="userListP" value="userList">
										<c:param name="page" value="${idx}" />
										<c:param name="q" value="${param.q}" />
									</c:url>
								</c:if>
								<c:if test="${ empty param.q }">
									<c:url var="userListP" value="userList">
										<c:param name="page" value="${idx}" />
									</c:url>
								</c:if>
								<li class='<c:out value="${idx == pageMaker.page ? 'current' : ''}"/>'>
									<a href='${userListP}'>${idx}</a>
								</li>
								
							</c:forEach>
							<c:if test="${pageMaker.next }">
								<c:if test="${ not empty param.q }">
									<c:url var="userListP" value="userList">
										<c:param name="page" value="${pageMaker.end + 1}" />
										<c:param name="q" value="${param.q}" />
									</c:url>
								</c:if>
								<c:if test="${ empty param.q }">
									<c:url var="userListP" value="userList">
										<c:param name="page" value="${pageMaker.end + 1}" />
									</c:url>
								</c:if>
								<li><a href="${userListP}">다음</a></li>
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

		self.location = "userList" + "?q=email%3D" + $('#k').val();
	});	
});

function deleteUser(email) {
	var result = confirm(email + "을 탈퇴시키겠습니까?");
	
	if ( result ) {
		$.ajax({
			type: 'post',
			url: 'deleteUser',
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
		    },
			headers: {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType: "text",
			data: JSON.stringify({email: email}),
			success: function(result) {
				console.log("result: " + result);
				
				if ( result == 'SUCCESS' ) {
					alert(email + "이 탈퇴되었습니다.");
					window.location.href = "userList";
				}
			},
			error: function(request, status, error) {
			    alert("회원 탈퇴에 실패했습니다.");
			    window.location.href = "userList";
		    }
		});
	}
}
</script>
