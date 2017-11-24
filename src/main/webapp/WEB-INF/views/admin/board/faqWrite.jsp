<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>
<script type="text/javascript">
	$(function() {
		CKEDITOR.replace('editor1');
	});

	function sendData() {
		if (!document.getElementById("content").value) {
			alert("질문을 입력하세요.");
			return false;
		}
		else if (!CKEDITOR.instances.editor1.getData()) {
			alert("답변을 입력하세요.");
			return false;
		}
		
		$("#faq_form").submit();
	}
	
	function resetCkEditor(){
		CKEDITOR.instances.editor1.setData('');
	}
</script>
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>FAQ</h1>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">FAQ 작성</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<form id="faq_form" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>질문:</th>
										<td><input type="text" placeholder="질문을 입력하세요." id="content"
											name="content" class="form-control" value="${faq.content}"/></td>
									</tr>
									<tr>
										<th>분류:</th>
										<td>
											<select id="category" name="category">
												<option value="회원정보관련">회원정보관련</option>
												<option value="상품환불관련">상품환불관련</option>
												<option value="배송관련">배송관련</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>답변:</th>
										<td>
											<textarea id="editor1" name="comment" rows="10" cols="80" class="form-control">${faq.comment}</textarea>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<input type="button" value="등록" onclick="sendData()" class="pull-right" />
											<input type="reset" value="리셋" onclick="resetCkEditor()" class="pull-left" />
											<input type="button" value="글 목록으로" onclick="location.href='faq.do'" class="pull-right" />
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
