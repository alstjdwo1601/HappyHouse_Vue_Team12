$(document).ready(function(){					
	$.get(root + "/map/sido"
		,function(data, status){
			$.each(data, function(index, vo) {
				$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
			});
		}
		, "json"
	);
	
	$("#btnSearchTypeDong").click(btnsearchbydong);
	$("#btnSearchTypeApt").click(btnsearchbyapt);
	
	$("#dongSearchBtn").click(searchaptbydong);
	$("#aptSearchBtn").click(searchaptbyapt);
	
	$(".accordion").on("click", "tr input:checkbox", checkUserHouseInfo);
	
});


//시에 따른 구군 받아오기
$(document).on("change", "#sido", function() {
	$.get(root + "/map/gugun"
			,{sido: $("#sido").val()}
			,function(data, status){
				$("#gugun").empty();
				$("#gugun").append('<option value="0">선택</option>');
				$.each(data, function(index, vo) {
					$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
				});
			}
			, "json"
	);
});

//구군에 따른 읍면동 받아오기
$(document).on("change", "#gugun", function() {
	$.get(root + "/map/dong"
			,{gugun: $("#gugun").val()}
			,function(data, status){
				$("#dong").empty();
				$("#dong").append('<option value="0">선택</option>');
				$.each(data, function(index, vo) {
					$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
				});
			}
			, "json"
	);
});


//함수 구현부
//아파트 이름 별 검색 창 show
function btnsearchbyapt(){
	$("#search-bar-by-dong").hide();
	$("#search-bar-by-apt").show();
};

//동 별 검색 창 show
function btnsearchbydong(){
	$("#search-bar-by-dong").show();
	$("#search-bar-by-apt").hide();
};

//동 기준 검색 결과 return
function searchaptbydong(){
	$.get(root + "/map/apt/dong"
			,{dong: $("#dong").val()}
			,function(data, status){
				aptListResult(data);
			}
			, "json"
	);
}

//아파트 이름 기준 검색 결과 return
function searchaptbyapt(){
	var aptname = $("#aptname").val();
	if(aptname == ""){
		alert("검색할 아파트 이름을 입력해주세요!");
		return;
	}
	$.get(root + "/map/apt/name"
			,{aptname: aptname}
			,function(data, status){
				aptListResult(data);
			}
			, "json"
	);
}

//return된 결과 table 세팅, 지도 세팅
function aptListResult(data){
	$(".accordion").empty();
	$.each(data, function(index, vo) {
		let str=`
		<div class="card">
		    <div class="card-header bg-secondary" id="heading${index}">
		      <h2 class="mb-0">
		        <button class="btn btn-link btn-block text-left text-white" type="button" data-toggle="collapse" data-target="#collapse${index}" aria-expanded="true" aria-controls="collapse${index}">
		          ${index+1}번 ${vo.aptName}
		        </button>
		      </h2>
		    </div>
			
		    <div id="collapse${index}" class="collapse" aria-labelledby="heading${index}" data-parent="#searchResult">
		      <div class="card-body">
		      	<table class="table mt-1">
		      		<tr align="right">
		      			<th></th>
		      			<td><input type="checkbox" value="${vo.aptCode}" onClick="checkUserHouseInfo(event)">관심지역 등록하기</td>
		      		</tr>
					<tr>
						<th>번호</th>
						<td>${vo.aptCode}</td>
					</tr>
					<tr>
						<th>아파트 이름</th>
						<td>${vo.aptName}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${vo.sidoName} ${vo.gugunName} ${vo.dongName} ${vo.jibun}</td>
					</tr>
					<tr>
						<th>건축연도</th>
						<td>${vo.buildYear}</td>
					</tr>
					<tr>
						<th>최근거래금액</th>
						<td>${vo.recentPrice}</td>
					</tr>
				</table>
		      </div>
		    </div>
		  </div>
		`;
		$(".accordion").append(str);
	});
	displayMarkers(data);
}


//각 아파트 별 상세 정보
function aptDetailSelect(){
	
}


function checkUserHouseInfo(event){
	console.log(event);

	if(!event.hasOwnProperty('originalEvent')) return;
	var selected = event.originalEvent.target.checked;
	var aptCode = event.originalEvent.target.value;
	
	console.log(aptCode);
	if(selected){
		$.ajax({
			url: '/user/add/'+aptCode,
			type: 'get',
			dataType: 'json'
		});
	}else{
		$.ajax({
			url: '/user/delete/house/'+aptCode,
			type: 'delete',
			dataType: 'json'
		});
	}
}