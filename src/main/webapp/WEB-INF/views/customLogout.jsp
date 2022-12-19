<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="includes/import.jsp"%>
</head>
<body>
	<h1>Custom Logout Page</h1>
	<form method='post' action='/customLogout'>
		<div>
			<a href="index.html" class="btn btn-lg btn-success btn-block">Logout</a>
		</div>
		<input type='hidden' name="${_csrf.parameterName }"
			value="${_csrf.token }">
	</form>

	<script>
	$('.btn-success').click(function(e) {
		console.log('ttt');
		e.preventDefault();
		$('form').submit();
	})
	</script>
	<c:if test="${param.logout != null }">
		<script>
			$(document).ready(function() {
				alert("로그아웃 하였습니다.");
			})
		</script>
	</c:if>
</body>
</html>