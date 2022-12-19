<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<header>
	<h1>공통헤더</h1>
	<sec:authorize access="isAuthenticated()">
		<a href="/customLogout">Logout</a>
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
		<a href="/customLogin">Login</a>
	</sec:authorize>
</header>
