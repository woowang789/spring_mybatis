<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="includes/import.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Custom Login Page</h1>
<h2><c:out value="${error }"/></h2>
<h2><c:out value="${logout }"/></h2>
<form method='post' action='/login' role="form">
	<div>
		<input type='text' name='username' placeholder="userid">
	</div>
	<div>
		<input type='password' name='password' placeholder="pwssword" >
	</div>
	<div>
		<input type='checkbox' name='remember-me'> RememberMe
	</div>
	<div>
		<a href="index.html" class="btn btn-lg btn-success btn-block">Login</a>
	</div>
	<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }">
</form>

<script>
	$(".btn-success").click(function(e){
		e.preventDefault();
		$("form").submit();
		
	})
</script>

</body>
</html>