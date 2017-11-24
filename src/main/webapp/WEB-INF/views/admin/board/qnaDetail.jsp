<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- Main content -->

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Q&amp;A</h1>
	</section>

	<section class="content">
		<div class="row">
			<!-- left column -->
			<div class="col-md-12">
			<!-- general form elements -->
				<div class="box box-primary">
					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputEmail1">제목</label>
							<input type="text" name="title" value="${qna.title}" class="form-control" readonly>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">작성일</label>
							<input type="text" name="regdate" value='<fmt:formatDate value="${qna.regdate}" 
								pattern="yyyy-MM-dd HH:mm" />' class="form-control" readonly>
						</div>						
						<div class="form-group">
							<label for="exampleInputEmail1">작성자</label>
							<input type="text" name="username" value="${qna.username}" class="form-control" readonly>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">분류</label>
							<input type="text" name="category" value="${qna.category}" class="form-control" readonly>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">내용</label>
							<div class="input-box" style="min-height: 100px; background-color: #ECF6CE; padding-top: 10px; padding-left: 10px; padding-right: 10px; padding-bottom: 10px;">
								${qna.content}
                        	</div>
						</div>
					</div>
					<!--  /.box-body -->
					
					<div class="box-footer">
						<button type="submit" class="btn btn-warning" id="answerBtn">답변하기</button>
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

var bno = '${qna.bno}';
var page = '${page}';

$(document).ready(function() {
	
	$("#answerBtn").on("click", function() {
		window.location.href = "qnaReply.do?parent=" + bno + "&page=" + page;
	});
	
	$("#removeBtn").on("click", function() {
		var result = confirm("이 글을 삭제하시겠습니까?");
		
		if ( result )
		{
			$.ajax({
				type: 'post',
				url: 'qnaDelete.do',
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
						window.location.href = "qna.do?page=" + page;
					}
				},
				error: function(request, status, error) {
				    alert("올바르지 않은 글 삭제입니다.");
				    window.location.href = "qna.do?page=" + page;
			    }
			});
		}
	});
	
	$("#goListBtn").on("click", function() {
		window.location.href = "qna.do?page=" + page;
	});
});
</script>