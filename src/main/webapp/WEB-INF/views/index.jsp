<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>BackEnd Project</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="img/favicon.ico">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/main.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			UserLogin();
		});
		
		function UserLogin(){
			//서버로 ajax 요청 보내서 데이터 받아오기
			$('#btnLogin').on('click', function(){
				var id = $('#id').val();
				var password = $('#password').val();
				$.ajax({
					url: 'user/member/' + id + '/' + password,
					type: 'get',
					dataType: 'json', //서버가 보내주는 데이터 타입
					success: UserLoginResult
				});
			});
		}
		//서버에서 받은 결과를 테이블에 넣어 보여주는 함수
		function UserLoginResult(result){
			console.log(result);
			$('#index_user').hide();
			$('#no1').empty();
			$('#no1').val('로그아웃');
		}
		
		
	</script>
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
				<li class="nav-item">
					<a class="nav-link" href="/qna.html">QnA</a>
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
		<section id="index_section">
			<div class="card col-sm-12 mt-1" style="min-height: 850px;">
				<div class="card-body">
					<button id="btnSearchTypeDong" type="button" class="btn btn-dark">지역(동)별 거래 검색</button>
					<button id="btnSearchTypeApt" type="button" class="btn btn-dark">아파트 별 거래 검색</button>
					<hr>
					<div id="search-bar-by-dong">
						시도 : 
						<select id="sido">
							<option value="0">선택</option>
						</select>
						구군 : 
						<select id="gugun">
							<option value="0">선택</option>
						</select>
						읍면동 : 
						<select id="dong">
							<option value="0">선택</option>
						</select>
						<button type="button" id="dongSearchBtn">검색</button>
					</div>
					<div id="search-bar-by-apt" style="display: none;">
						
						아파트 이름 : 
						<input id="aptname" type="text" placeholder="아파트 이름을 입력하세요">
						<button type="button" id="aptSearchBtn">검색</button>
					</div>
					<hr>
				<div class="accordion" id="searchResult"></div>

				<div id="map" style="width:100%;height:500px;"></div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1f36115e847878579a1c20a59f5516e3&libraries=services"></script>
				<script type="text/javascript" src="js/map.js"></script>
				</div>
			</div>
		</section>
	</div>
</body>
</html>