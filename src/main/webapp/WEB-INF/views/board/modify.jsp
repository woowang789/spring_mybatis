<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../includes/import.jsp"%>
<meta charset="UTF-8">
<title>Modify Board</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	<h1>게시글 수정</h1>
	<form action="/board/modify" method="post">
		<div class="form-group">
			<label for="bno">Num</label> <input type="text" class="form-control"
				readonly="readonly" id="bno" name="bno"
				value="<c:out value="${board.bno }" />">
		</div>

		<div class="form-group">
			<label for="title">Title</label> <input type="text"
				class="form-control" id="title" name="title"
				value="<c:out value="${board.title }" />">
		</div>
		<div class="form-group">
			<label for="content">Content</label>
			<textarea class="form-control" id="content" name='content' rows="3"><c:out
					value="${board.content }" /></textarea>
		</div>
		<div class="form-group">
			<label for="writer">Writer</label> <input type="text"
				class="form-control" id="writer" name="writer"
				value="<c:out value="${board.writer }" />">
		</div>
		<div class="form-group">
			<label for="regDate">RegDate</label> <input type="text"
				readonly="readonly" class="form-control" id="regDate" name="regDate"
				value="<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regDate}"/>">
		</div>
		<div class="form-group">
			<label for="updateDate">UpdateDate</label> <input type="text"
				readonly="readonly" class="form-control" id="updateDate"
				name="updateDate"
				value="<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>">
		</div>

		<button data-oper="modify" type="submit" class="btn btn-default">Modify</button>
		<button data-oper="remove" type="submit" class="btn btn-default">Remove</button>
		<button data-oper="list" type="submit" class="btn btn-default">List</button>

		<input type="hidden" name="pageNum" readonly="readonly"
			value="<c:out value="${cri.pageNum }" />" /> 
			
		<input type="hidden"name="amount" readonly="readonly"
			value="<c:out value="${cri.amount }" />" />

	</form>

	<%@include file="../includes/footer.jsp"%>

	<script type="text/javascript">
		$(document).ready(
				function() {
					let formObj = $('form');

					$('button').click(
							function(e) {
								e.preventDefault();
								let oper = $(this).data('oper');
								console.log(oper);

								if (oper == 'remove') {
									formObj.attr('action', "/board/remove");
								} else if (oper == 'list') {
									formObj.attr("action", "/board/list").attr(
											"method", "get");
									let pageNumTag = $("input[name='pageNum']").clone();
									let amountTag = $("input[name='amount']").clone();
									
									formObj.empty();
									formObj.append(pageNumTag);
									formObj.append(amountTag);
									
								}
								formObj.submit();
							})
				})
	</script>
</body>
</html>