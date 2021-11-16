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
					<a class="nav-link" href="/profile">Profile</a>
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
	        <form action="/profileModifyProcess" id="signup-form" method="post">
	          <h1>회원 정보 수정</h1>
	          <hr />
	          <div class="form-group">
	            <label for="id">아이디</label>
	            <input type="hidden" name="id" id="id" value="${member.id}"/>
	            <p id="info-id">${member.id}</p>
	          </div>
	          <div class="form-group">
	            <label for="password">비밀번호</label>
	            <input type="password" class="form-control required" id="password" name="password" value="${member.password}"/>
	          </div>
	          <div class="form-group">
	            <label for="name">이름</label>
	            <input type="text" class="form-control required" id="name" name="name" value="${member.name}"/>
	          </div>
	          <div class="form-group">
	            <label for="address">주소</label>
	            <input type="text" class="form-control required" id="address" name="address" value="${member.address}" />
	          </div>
	          <div class="form-group">
	            <label for="tel">전화번호</label>
	            <input type="text" class="form-control required" id="phone" name="phone" value="${member.phone}" />
	          </div>
	          <div class="form-group mt-2">
	            <button class="btn btn-primary btn-lg btn-block" type="submit" id="signupBtn">
	              	수정 완료
	            </button>
	          </div>
	        </form>
	      </div>
	      <div class="col-lg-2"></div>
	    </div>
	    </div>
</body>
</html>