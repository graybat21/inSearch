<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>공지사항</h1>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">공지사항 리스트</h3>
					</div>
					<!-- /.box-header -->
					
					<div class="box-body">
						<table id="example1" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th style="width: 10%; text-align: center">번호</th>
									<th style="width: 53%; text-align: center">제목</th>
									<th style="width: 10%; text-align: center">작성자</th>
									<th style="width: 20%; text-align: center">날짜</th>
									<th style="width: 7%; text-align: center">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${noticeList}">
									<c:url var="viewNotice" value="noticeView.do">
										<c:param name="bno" value="${item.bno}" />
										<c:param name="page" value="${pageMaker.page}" />
									</c:url>
									<tr>
										<td style="text-align: center;">${item.bno}</td>
										<td style="text-align: center;">
											<a href="${viewNotice}">${item.title}</a>
										</td>
										<td style="text-align: center;">관리자</td>
										<td style="text-align: center;">
											<fmt:formatDate value="${item.regdate}" pattern="yyyy-MM-dd HH:mm" />
										</td>
										<td style="text-align: center;">${item.viewcnt}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- /.box-body -->
					<!-- Paging -->
					<div class="box-footer clearfix">
						<div class="col-md-12">
							<a href="noticeWrite.do">
								<button class="btn btn-primary pull-left">글쓰기</button>
							</a>
						</div>
						<div class="col-md-12">
							<ul class="pagination pull-right">
								<c:if test="${pageMaker.prev}">
									<c:if test="${not empty param.o}">
										<c:url var="noticeListP" value="notice.do">
											<c:param name="page" value="${pageMaker.start - 1}" />
											<c:param name="o" value="${param.o}"></c:param>
											<c:param name="k" value="${param.k}"></c:param>
										</c:url>
									</c:if>
									<c:if test="${empty param.o}">
										<c:url var="noticeListP" value="notice.do">
											<c:param name="page" value="${pageMaker.start - 1}" />
										</c:url>
									</c:if>
									<li><a href="${noticeListP}">이전</a></li>
								</c:if>
								<c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="idx">
									<c:if test="${not empty param.o}">
										<c:url var="noticeListP" value="notice.do">
											<c:param name="page" value="${idx}" />
											<c:param name="o" value="${param.o}"></c:param>
											<c:param name="k" value="${param.k}"></c:param>
										</c:url>
									</c:if>
									<c:if test="${empty param.o}">
										<c:url var="noticeListP" value="notice.do">
											<c:param name="page" value="${idx}" />
										</c:url>
									</c:if>
									<li class='<c:out value="${idx == pageMaker.page ? 'current' : ''}"/>'>
										<a href='${noticeListP }'>${idx}</a>
									</li>
								</c:forEach>
								<c:if test="${pageMaker.next}">
									<c:if test="${not empty param.o}">
										<c:url var="noticeListP" value="notice.do">
											<c:param name="page" value="${pageMaker.end + 1}" />
											<c:param name="o" value="${param.o}"></c:param>
											<c:param name="k" value="${param.k}"></c:param>
										</c:url>
									</c:if>
									<c:if test="${empty param.o}">
										<c:url var="noticeListP" value="notice.do">
											<c:param name="page" value="${pageMaker.end + 1}" />
										</c:url>
									</c:if>
									<li><a href="${noticeListP}">다음</a></li>
								</c:if>
							</ul>
						</div>
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
