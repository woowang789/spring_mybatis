<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../includes/import.jsp"%>
<meta charset="UTF-8">
<title>List Page</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">#번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">수정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="board">
				<tr>
					<td><c:out value="${board.bno }" /></td>
					<td><a class="move" href="<c:out value="${board.bno }"/>">
							<c:out value="${board.title }" />
					</a></td>
					<td><c:out value="${board.writer }" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.regDate }" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.updateDate }" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<nav aria-label="Page navigation example">
		<ul class="pagination">
			<c:if test="${pageMaker.prev }">
				<li class="page-item paginate_button"><a class="page-link"
					href="${pageMaker.startPage-1 }">Previous</a></li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }">
				<li
					class='page-item paginate_button ${pageMaker.cri.pageNum == num? "active" : "" }'><a
					class="page-link" href="${num }">${num }</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<li class="page-item paginate_button"><a class="page-link"
					href="${pageMaker.endPage+1 }">Next</a></li>
			</c:if>
		</ul>
	</nav>
	<%@include file="../includes/footer.jsp"%>

	<form id="actionForm" action="/board/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" />
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
	</form>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							let result = '<c:out value="${result}"/>'

							checkModal(result);

							history.replaceState({}, null, null);

							function checkModal(result) {
								if (result = '' || history.state) {
									return;
								}
								if (parseInt(result) > 0) {
									$(".modal-body").html(
											"게시글" + parserInt(result)
													+ "번이 등록되었습니다.");
								}
								$("#myModal").modal("show");
							}
							$("#regBtn").click(function() {
								self.location = "/board/register"
							})

							let actionForm = $("#actionForm")
							$(".paginate_button a").click(
									function(e) {
										e.preventDefault();
										console.log('click');
										actionForm
												.find("input[name='pageNum']")
												.val($(this).attr("href"));
										actionForm.submit();
									});

							$('.move')
									.click(
											function(e) {
												e.preventDefault();
												actionForm
														.append("<input type='hidden' name='bno' value='"
																+ $(this).attr(
																		'href')
																+ "'>");
												actionForm.attr("action",
														"/board/get");
												actionForm.submit();
											})
						})
	</script>
</body>
</html>