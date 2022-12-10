<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../includes/import.jsp"%>
<meta charset="UTF-8">
<title>Regist Board</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	<h1>게시글 등록</h1>
	<form action="/board/register" method="post">
		<div class="form-group">
			<label for="title">Title</label> <input type="text"
				class="form-control" id="title" name="title">
		</div>
		<div class="form-group">
			<label for="content">Content</label>
			<textarea class="form-control" id="content" name='content' rows="3"></textarea>
		</div>
		<div class="form-group">
			<label for="writer">Writer</label> <input type="text"
				class="form-control" id="writer" name="writer">
		</div>

		<button type="submit" class="btn btn-default">Submit</button>
		<button type="submit" class="btn btn-default">Reset</button>

	</form>

	<%@include file="../includes/footer.jsp"%>
</body>
</html>