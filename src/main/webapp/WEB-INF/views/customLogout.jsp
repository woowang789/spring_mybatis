<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Custom Logout Page</h1>
<form method='post' action='/customLogout'>
	<div>
		<button>로그아웃</button>
	</div>
	<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }">
</form>

</body>
</html>