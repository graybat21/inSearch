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
	
	$("#notice_form").submit();
}

function resetCkEditor(){
	CKEDITOR.instances.editor1.setData('');
}
</script>
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>공지사항게시판</h1>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">공지사항 작성</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<form id="notice_form" method="post">	
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />				
								<table class="table table-bordered">
									<tbody>
										<tr>
											<th>제목:</th>
											<td><input type="text" placeholder="제목을 입력하세요. " id="title"
												name="title" class="form-control" value="${notice.title}" /></td>
										</tr>
										<tr>
											<th>내용:</th>
											<td>
												<textarea id="editor1" name="content" rows="10" cols="80" class="form-control">${notice.content}</textarea>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<input type="button" value="등록" onclick="sendData()" class="pull-right" /> 
												<input type="reset" value="리셋" onclick="resetCkEditor()" class="pull-left" /> 
												<input type="button" value="글 목록으로" class="pull-right" onclick="location.href='notice.do'" /> 
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
