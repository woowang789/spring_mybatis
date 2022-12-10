<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../includes/import.jsp"%>
<style>
span {
	display: inline-block;
	width: 100px;
	font-weight: bold;
	width: 100px;
}
</style>
<meta charset="UTF-8">
<title>Get Page</title>
</head>
<body>

	<%@include file="../includes/header.jsp"%>

	<div>
		<span>Num</span>
		<c:out value="${board.bno }" />
	</div>
	<div>
		<span>Title</span>
		<c:out value="${board.title }" />
	</div>
	<div>
		<span>Content</span>
		<c:out value="${board.content }" />
	</div>
	<div>
		<span>Writer</span>
		<c:out value="${board.writer }" />
	</div>
	<div>
		<span>RegDate</span>
		<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate }" />
	</div>
	<div>
		<span>UpdateDate</span>
		<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }" />
	</div>

	<button data-oper="modify" type="submit" class="btn btn-default">Modify</button>
	<button data-oper="list" type="submit" class="btn btn-default">List</button>

	<form id="operForm" action="/board/modify" method="get">
		<input type="hidden" id="bno" name="bno" readonly="readonly" value="<c:out value="${board.bno }" />" /> 
			<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum }" />" /> 
			<input type="hidden" name="amount"  value="<c:out value="${cri.amount }" />" />
			<input type="hidden" name="keyword"  value="<c:out value="${cri.keyword }" />" />
			<input type="hidden" name="type"  value="<c:out value="${cri.type }" />" />
	</form>


	<%@include file="../includes/footer.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			let operForm = $("#operForm");

			$('button[data-oper="modify"]').click(function(e) {
				operForm.attr("action", "/board/modify").submit();

			});
			$('button[data-oper="list"]').click(function(e) {
				operForm.find("#bno").remove();
				operForm.attr("action", "/board/list");
				operForm.submit();
			});

		})
	</script>
</body>
</html>