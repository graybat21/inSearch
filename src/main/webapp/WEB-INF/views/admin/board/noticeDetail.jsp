<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- Main content -->

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>공지사항</h1>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputEmail1">제목</label>
							<input type="text" name="title" value="${notice.title}" class="form-control" readonly>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">작성일</label>
							<input type="text" name="regdate" value='<fmt:formatDate value="${notice.regdate}" 
								pattern="yyyy-MM-dd HH:mm" />' class="form-control" readonly>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">내용</label>
							<div class="input-box" style="min-height: 100px; background-color: #ECF6CE; padding-top: 10px; padding-left: 10px; padding-right: 10px; padding-bottom: 10px;">
								${notice.content}
                        	</div>
						</div>
					</div>
					
					<div class="box-footer">
						<button type="submit" class="btn btn-warning" id="modifyBtn">수정</button>
						<button type="submit" class="btn btn-danger" id="removeBtn">삭제</button>
						<button type="submit" class="btn btn-primary" id="goListBtn">글 목록으로</button>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<script type="text/javascript">
var header = $("meta[name='_csrf_header']").attr("content");
var token  = $("meta[name='_csrf']").attr("content");

var bno = '${notice.bno}';
var page = '${page}';

$(document).ready(function() {
	
	$("#modifyBtn").on("click", function() {
		window.location.href = "noticeModify.do?bno=" + bno + "&page=" + page;
	});
	
	$("#removeBtn").on("click", function() {
		var result = confirm("이 글을 삭제하시겠습니까?");
		
		if ( result )
		{
			$.ajax({
				type: 'post',
				url: 'noticeDelete.do',
				beforeSend: function(xhr){
					xhr.setRequestHeader(header, token);
			    },
				headers: {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType: "text",
				data: JSON.stringify({bno: bno}),
				success: function(result) {
					console.log("result: " + result);
					
					if ( result == 'SUCCESS' ) {
						window.location.href = "notice.do?page=" + page;
					}
				},
				error: function(request, status, error) {
				    alert("올바르지 않은 글 삭제입니다.");
				    window.location.href = "notice.do?page=" + page;
			    }
			});
		}
	});
	
	$("#goListBtn").on("click", function() {
		window.location.href = "notice.do?page=" + page;
	});
});
</script>