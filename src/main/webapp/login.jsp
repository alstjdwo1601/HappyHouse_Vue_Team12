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
	      <div class="col-lg-8 p-5 m-3" style="background: white; border-radius: 16px">
	        <form action="/loginProcess" id="signup-form" method="post">
	          <h1>로그인</h1>
	          <hr />
	          <div class="form-group">
	            <label for="id">아이디</label>
	            <input type="text" class="form-control required" id="id" name="id"/>
	          </div>
	          <div class="form-group">
	            <label for="password">비밀번호</label>
	            <input type="password" class="form-control required" id="password" name="password"/>
	          </div>
	            <button class="btn btn-primary btn-lg btn-block" type="submit" id="signupBtn">
	              	로그인
	            </button>
	            </form>
	          </div>
	      </div>
	      <div class="col-lg-2"></div>
	 </div>
</body>
</html>