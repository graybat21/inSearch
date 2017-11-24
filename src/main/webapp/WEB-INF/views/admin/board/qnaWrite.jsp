<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>
<script type="text/javascript">
	$(function() {
		CKEDITOR.replace('editor1');
	});

	function sendData() {
		if (!document.getElementById("title").value) {
			alert("제목을 입력하세요.");
			return false;
		}
		if (!CKEDITOR.instances.editor1.getData()) {
			alert("내용을 입력하세요.");
			return false;
		}
		
		$("#qna_form").submit();
	}
	
	function resetCkEditor(){
		CKEDITOR.instances.editor1.setData('');
	}
</script>
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Q&amp;A 답변하기</h1>
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
					
				</div>
			</div>
		</div>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">답변하기</h3>
					</div>
					<!-- /.box-header -->
					
					<div class="box-body">
						<form id="qna_form" method="post" action="qnaReply.do">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" name="category" value="${qna.category}">
							<input type="hidden" name="family" value="${qna.family}">
							<input type="hidden" name="parent" value="${qna.bno}">
							<input type="hidden" name="bno" value="${qna.bno}">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목:</th>
										<td><input type="text" placeholder="질문을 입력하세요. " id="title"
											name="title" class="form-control" value="[답변] ${qna.title}"/></td>
									</tr>
									<tr>
										<th>답변:</th>
										<td><textarea id="editor1"
												name="content" rows="10" cols="80" class="form-control"></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<input type="button" value="등록" onclick="sendData()" class="pull-right" /> 
											<input type="reset" value="리셋" onclick="resetCkEditor()" class="pull-left" /> 
											<input type="button" value="글 목록으로" class="pull-right" onclick="location.href='qna.do'" />
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
