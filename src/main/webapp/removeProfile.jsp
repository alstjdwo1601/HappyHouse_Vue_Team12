<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="img/favicon.ico">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
		<div class="container">
			<div class="jumbotron text-center mb-1">
			<h4>행복한 우리 집</h4>
		</div>
		<!-- nav start -->
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark rounded">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="/">Home</a>
				</li>
				<c:if test="${empty member}">
					<li class="nav-item">
						<a class="nav-link" href="/signup.jsp">Sign up</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/login.jsp">Login</a>
					</li>
				</c:if>
				<c:if test="${!empty member}">
					<li class="nav-item">
						<a class="nav-link" href="/profile.jsp">Profile</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/logout">Logout</a>
					</li>
				</c:if>
			</ul>
		</nav>
		<div class="row">
			<div class="col-lg-2"></div>
			<div class="col-lg-8 p-5 m-3">
				<h1>정말로 회원 탈퇴 하시겠습니까?</h1>
				<hr>
				<div class="row">
					<div class="col">
						<button class="btn btn-success btn-lg btn-block"
							type="button" id="modifyBtn"
							onclick="location.href='/'"> 돌아가기 </button>
					</div>
					<div class="col">
						<button class="btn btn-outline-danger btn-lg btn-block" type="button"
							id="deleteBtn"
							onclick="location.href='/removeProfileProcess?id=${member.id}'">회원
							탈퇴</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-2"></div>
	</div>
</body>
</html>