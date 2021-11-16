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
	<script type="text/javascript">
		$(document).ready(function(){
			houseinfoResult();
			$("#info-house-tbody").on("click", "button", checkButtonAction);
		});
		
		function checkButtonAction(event){
			var action = event.target.name;
			if(action == "delete"){
				deleteUserHouse(event);
			}else{
				setStart(event);
			}
		}
		
		function houseinfoList(data){
			console.log(data);
			$("#info-house-tbody").empty();
			$.each(data, function(index, vo) {
				$('<tr>')
				.append($('<td>').text(vo.aptName))
				.append($('<td>').text(vo.sidoName+" "+vo.gugunName+" "+vo.dongName+" "+vo.jibun))
				.append($('<td>').text(vo.recentPrice))
				.append($('<td>').append($('<button class="btn btn-outline-primary btn-sm" type="button">삭제</button>').val(vo.aptCode)))
				.append($('<td>').append($('<button id="setStart" class="btn btn-outline-primary btn-sm" type="button">출발지 설정</button>').val(index)))
				.appendTo("#info-house-tbody");
			});
		}
		
		function houseinfoResult(){
			$.ajax({
				url: '/user/'+ "${member.id}",
				type: 'get',
				dataType: 'json',
				success: function(result){
					houseinfoList(result);
				}			
			});
		}
		
		function setStart(event){
			let start = event.target.value;
			$.ajax({
				url: '/user/'+ "${member.id}",
				type: 'get',
				dataType: 'json',
				success: function(result){
					gethousedistance(result, start);
				}			
			});
		}
		function gethousedistance(result, start){
            var length = result.length;
            var distance = new Array(length);
            
            for(var i=0; i<length; i++){
                distance[i] = new Array(length);
            }
            
            for(var i=0; i<length; i++){
                for(var j=0; j<length; j++){
                    if(i==j) distance[i][j] = 0;
                    else distance[i][j] = getDistance(result[i].lat, result[i].lng, result[j].lat, result[j].lng);
                }
            }
            console.log(distance);
            
            var d = new Array(length);
			var v = new Array(length);
			var ix = new Array(length);
			
            for(var i = 0; i < length; i++){
            	d[i] = distance[start][i];
            }
            v[start] = true;
            ix[0] = parseInt(start);
            
            console.log(v);
            for(var i = 1; i < length; i++){
            	var min = 10000000;
             	var idx = 0;
             	for(var k = 0; k < length; k++){
             		if(d[k] < min && v[k] != true){
             			min = d[k];
             			idx = k;
             		}
             	}
             	v[idx] = true;
             	for(var j = 0; j < length; j++){
             		if(v[j] != true){
             			if(d[idx] + distance[idx][j] < d[j]){
             				d[j] = d[idx] + distance[idx][j];
             			}
             		}
             	}
             	ix[i] = idx;
            }
            
            $("#info-distance").empty();
            $('<tr>').append($('<td>').text("출발지 : "+result[ix[0]].aptName)).appendTo("#info-distance");
            for(var i = 1; i < length-1; i++){
            	$('<tr>')
                .append($('<td>').text("경유지 : "+result[ix[i]].aptName))
                .append($('<td>').text("거리 : "+d[ix[i]]+"km"))
                .appendTo("#info-distance");
            }
            $('<tr>').append($('<td>').text("도착지 : "+result[ix[length-1]].aptName)).append($('<td>').text("거리 : "+d[ix[length-1]]+"km")).appendTo("#info-distance");
        }

        function getDistance(x1, y1, x2, y2){
            var lat1 = degreesToRadians(x1);
            var lng1 = degreesToRadians(y1);
            var lat2 = degreesToRadians(x2);
            var lng2 = degreesToRadians(y2);
            
            var Radius = 6371; //지구의 반경(km)
            var distance = Math.acos(Math.sin(lat1) * Math.sin(lat2) + 
                            Math.cos(lat1) * Math.cos(lat2) *
                            Math.cos(lng1 - lng2)) * Radius;
            return distance;
        }
        
        function degreesToRadians(degrees) {
            radians = (degrees * Math.PI)/180;
            return radians;
        }
		
		function deleteUserHouse(event){
			console.log(event);
			var houseCode = event.target.value;
			$.ajax({
				url: '/user/delete/house/'+houseCode,
				type: 'delete',
				dataType: 'json',
				success: houseinfoList
			});
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
	        <form action="" id="signup-form" method="post">
						<h1>회원 정보</h1>
						<hr />
						<div class="form-group">
							<label for="id">아이디</label>
							<p id="info-id">${member.id}</p>
						</div>
						<div class="form-group">
							<label for="password">비밀번호</label>
							<p id="info-password">*****</p>
						</div>
						<div class="form-group">
							<label for="name">이름</label>
							<p id="info-name">${member.name}</p>
						</div>
						<div class="form-group">
							<label for="address">주소</label>
							<p id="info-address">${member.address}</p>
						</div>
						<div class="form-group">
							<label for="tel">전화번호</label>
							<p id="info-tel">${member.phone}</p>
						</div>
						<div>
							<label for="userHouseInfoList">관심 아파트 목록</label>
							<div id="userHouseInfoResult">
								<table id="info-house" class="table mt-1">
									<thead>
										<tr>
											<th>아파트 이름</th>
											<th>주소</th>
											<th>최근거래금액</th>
											<th></th>
										</tr>
									</thead>
									<tbody id="info-house-tbody">
									</tbody>
								</table>
							</div>
						</div>
							
						<div class="row form-group mt-2">
                            <button class="btn btn-outline-primary btn-lg btn-block"
                                type="button" id="getDistanceBtn">출발지로부터의 최단 거리 구하기</button>
                            <div id="distanceResult">
                                <table class="table mt-1">
                                    <tbody id="info-distance">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
						<div class="row form-group">
							<div class="col">
								<button class="btn btn-outline-warning btn-lg btn-block"
									type="button" id="modifyBtn" onclick="location.href='/profileModify.jsp'">정보 수정</button>
							</div>
							<div class="col">
								<button class="btn btn-outline-danger btn-lg btn-block"
									type="button" id="deleteBtn" onclick="location.href='/removeProfile.jsp'">회원 탈퇴</button>
							</div>
						</div>
						<div class="form-group mt-2">
							<button class="btn btn-success btn-lg btn-block" type="button"
								id="checkBtn" onclick="location.href='/'">확인 완료</button>
						</div>
					</form>
	      </div>
	      <div class="col-lg-2"></div>
	    </div>
	    </div>
</body>
</html>