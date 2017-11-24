<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
						<h3 class="box-title">FAQ 리스트</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<table class="table table-striped" id="board">
							<thead>
								<tr>
									<th style="width: 7%; text-align: center">글번호</th>
									<th style="width: 7%; text-align: center">분류</th>
									<th style="width: 45%; text-align: center">내용</th>
									<th style="width: 15%; text-align: center">action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${faqList }">
									<tr id="${item.bno }">
										<td style="text-align: center;">${item.bno }</td>
										<td style="text-align: center;">${item.category }</td>
										<td style="text-align: center;">	
											<a href="javascript:viewComment(${item.bno })">${item.content }</a>
										</td>
										<td style="text-align: center;">
											<button class="btn btn-warning" onClick="modifyFaq(${item.bno}, ${pageMaker.page})">수정</button>
											<button class="btn btn-danger" onClick="removeFaq(${item.bno}, ${pageMaker.page})">삭제</button>
										</td>
									</tr>
									<tr>
										<td id="comment_${item.bno }" colspan="4" style="display:none">
										${item.comment }
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
					<!-- /.box-body -->
					<!-- Paging -->
					<div class="box-footer clearfix">
						<div class="col-md-12">
							<a href="faqWrite.do">
								<button class="btn btn-primary pull-left">글쓰기</button>
							</a>
						</div>
						<div class="col-md-12">
							<ul class="pagination pull-right">
								<c:if test="${pageMaker.prev }">
									<c:if test="${searchKeyword != null }">
										<c:url var="faqListP" value="faq.do">
											<c:param name="page" value="${pageMaker.start - 1}" />
											<c:param name="o" value="${searchOption }"></c:param>
											<c:param name="k" value="${searchKeyword }"></c:param>
										</c:url>
									</c:if>
									<c:if test="${searchKeyword == null }">
										<c:url var="faqListP" value="faq.do">
											<c:param name="page" value="${pageMaker.start - 1}" />
										</c:url>
									</c:if>
									<li><a href="${faqListP }">이전</a></li>
								</c:if>
								<c:forEach begin="${pageMaker.start }"
									end="${pageMaker.end}" var="idx">
									<c:if test="${searchKeyword != null }">
										<c:url var="faqListP" value="faq.do">
											<c:param name="page" value="${idx}" />
											<c:param name="o" value="${searchOption }"></c:param>
											<c:param name="k" value="${searchKeyword }"></c:param>
										</c:url>
									</c:if>
									<c:if test="${searchKeyword == null }">
										<c:url var="faqListP" value="faq.do">
											<c:param name="page" value="${idx}" />
										</c:url>
									</c:if>
									<li
										class='<c:out value="${idx == pageMaker.page ? 'current' : ''}"/>'>
										<a href='${faqListP }'>${idx}</a>
									</li>

								</c:forEach>
								<c:if test="${pageMaker.next }">
									<c:if test="${searchKeyword != null }">
										<c:url var="faqListP" value="faq.do">
											<c:param name="page" value="${pageMaker.end + 1}" />
											<c:param name="o" value="${searchOption }"></c:param>
											<c:param name="k" value="${searchKeyword }"></c:param>
										</c:url>
									</c:if>
									<c:if test="${searchKeyword == null }">
										<c:url var="faqListP" value="faq.do">
											<c:param name="page" value="${pageMaker.end + 1}" />
										</c:url>
									</c:if>
									<li><a href="${faqListP }">다음</a></li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
				<!-- /.container -->
			</div>
		</div>
	</section>
	<!-- /.page -->
</div>
<!-- /.wrapper -->

<script type="text/javascript">
var header = $("meta[name='_csrf_header']").attr("content");
var token  = $("meta[name='_csrf']").attr("content");

var bno = '${faq.bno}';
var page = '${page}';

function viewComment(bno) {
	if($('#comment_'+bno).css("display") == "none"){
		$('#comment_'+bno).css("display","");
	}
	else{
		$('#comment_'+bno).css("display","none");
	}
	/* if($('#comment_'+bno).css("display") == "") */
}

function modifyFaq(bno, page) {
	window.location.href = "faqModify.do?bno=" + bno + "&page=" + page;
}
	
function removeFaq(bno, page) {

	var result = confirm("이 글을 삭제하시겠습니까?");
	
	if ( result )
	{
		$.ajax({
			type: 'post',
			url: 'faqDelete.do',
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
					window.location.href = "faq.do?page=" + page;
				}
			},
			error: function(request, status, error) {
			    alert("올바르지 않은 글 삭제입니다.");
			    window.location.href = "faq.do?page=" + page;
		    }
		});
	}
}
</script>