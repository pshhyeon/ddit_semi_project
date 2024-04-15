<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
	
<script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<script src="/semi_project/js/jquery.serializejson.min.js"></script>

<!-- 카카오 맵 -->
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=dde7b3ab140fbaa2cba75ccfb885e2da"></script>
<!-- 스크립트 -->
<script src="/semi_project/js/script.js" defer></script>

<script>
	$(function() {
		let myPath = "<%=request.getContextPath()%>"
		let user = <%=session.getAttribute("user")%>;
		console.log(user);
		
		let selSidoVal; // 선택된 시도 값
		let selGugunVal; // 선택된 구군 값
		
		let currentListCnt = 1;
		
		let festivalList = ""; // 축제 리스트 넣을 변수
		let partyList = ""; // 소모임 리스트 넣을 변수
		
		// 페이지 상단으로 숨기기
		$('.page-top'). hide();
		
		// 사이트 접속하면 소모임 리스트 받아오기
		$.ajax({
			url : `${myPath}/partyList.do`
			, type : "GET"
			, success : function(res) {
				partyList = res;
				console.log(partyList);
			}
			, dataType : "JSON"
		})
		
		
		// 사이트 접속하면 축제 리스트 받아오기
		$.ajax({
			url : `${myPath}/festivalList.do`
			, type : "GET"
			, success : function(res) {
				festivalList = res;
				for(i = 0; i < festivalList.length; i++) {
					let marker = new kakao.maps.Marker({
		          		  position: new kakao.maps.LatLng(Number(res[i].latitude), Number(res[i].hardness)), // 마커의 좌표
		          		  map: map, // 마커를 표시할 지도 객체
		          		});
					
					var content =
				        '<div class="wrap">' +
				        '    <div class="info">' +
				        '        <div class="title">' +
				        	`<a href="${myPath}/detailFestival.do?fesNo=${festivalList[i].festival_no}">${festivalList[i].festival_name}</a>`	+
				        "        </div>" +
				        '        <div class="body">' +
				        '            <div class="desc">' +
				        '                <div class="ellipsis">' + festivalList[i].festival_content +'</div>' +
				        '                <div class="jibun ellipsis">' + festivalList[i].festival_addr + '</div>' +
				        "            </div>" +
				        "        </div>" +
				        "    </div>" +
				        "</div>";

				      // 마커 위에 커스텀오버레이를 표시합니다
				      // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
				      var overlay = new kakao.maps.CustomOverlay({
				        content: content,
				        map: map,
				        position: marker.getPosition(),
				      });

				      // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
				      kakao.maps.event.addListener(marker, "click", function () {
				        overlay.setMap(map);
				      });
				}
				let htmlCode = 
					`
					<table class="table" id="fesList">
	            <thead>
	              <tr>
	                <th>번호</th>
	                <th>축제명</th>
	                <th>장소</th>
	                <th>기관</th>
	              </tr>
	            </thead>`
	            
	            for (i = 0; i < 10; i++) {
	            	htmlCode += `<tbody><tr>
	                <td class="festival-no">${res[i].festival_no}</td>
	                <td class="festival-name cursor">${res[i].festival_name}</td>
	                <td>${res[i].festival_location}</td>
	                <td>${res[i].festival_inst}</td>
	              </tr>`;
	            	
	            }
	            
	          htmlCode += `</tbody></table>`
	          
	        	// admin이면 축제 등록 보이게
	      		if(user != null && user.user_admin_chk == "Y") {
	      			htmlCode += `
	      			<div id="add-festival-div">
	      				<button class="btn btn-danger" id="add-festival">축제 등록</button>
	      			</div>`;
	      		}
				
	        	 $("#main-bot").append(htmlCode);
	          	 map.panTo(new kakao.maps.LatLng(37.55199, 127.1015));
	          
	          $("#container-more-view").css("bottom","20px");
			}
			, dataType : "JSON"
		})
		
		// 로그인 돼있으면 마이페이지로 아니면 로그인폼으로
		$("#link-myPage").click(function(){
			if(user == null) {
				location.href = `${myPath}/user/loginForm.jsp`;
			} else if(user.user_admin_chk == "Y") {
				location.href = `${myPath}/user/adminPage.jsp`;
			} else {
				location.href = `${myPath}/user/myPage.jsp`;
			}
		})
		
		// 셀렉터 체인지 이벤트
		$("#search").change(function() {
			if($("#search").val() == "제목") {
				$("#sido").addClass("d-none");
				$("#gugun").addClass("d-none");
			} else {
				$("#sido").removeClass("d-none");
			}
		})
		
		$("#sido").change(function() {
			//selSidoIdx = $("#sido").prop('selectedIndex');
			selGugunVal =""; //  시도 변경시 전에 저장되어있던 구군 날리기 위함
			selSidoVal = $("#sido").val();
			console.log(selSidoVal)
			$("#gugun").removeClass("d-none");
			switch($("#sido").prop('selectedIndex')) {
			case 1:
				// 서울특별시
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>광진구</option>
				<option>강북구</option>
				<option>강남구</option>
				<option>관악구</option>
				<option>마포구</option>
				`
				)
				break;
			case 2:
				// 부산특별시
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>금정구</option>
				<option>사상구</option>
				<option>수영구</option>
				<option>서구</option>
				<option>동래구</option>
				<option>북구</option>
				`
				)
				break;
			case 3:
				// 대구광역시
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>북구</option>
				<option>서구</option>
				<option>달서구</option>
				<option>수성구</option>
				`
				)
				break;
			case 4:
				// 인천광역시
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>남동구</option>
				`
				)
				break;
			case 5:
				// 울산광역시
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>동구</option>
				<option>남구</option>
				<option>울주군</option>
				<option>북구</option>
				`
				)
				break;
			case 6:
				// 경기도
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>광주시</option>
				<option>이천시</option>
				<option>성남시</option>
				<option>연천군</option>
				<option>파주시</option>
				<option>화성시</option>
				<option>하남시</option>
				<option>수원시</option>
				<option>안성시</option>
				`       
				)
				break;
			case 7:
				// 충청남도
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>태안군</option>
				<option>논산시</option>
				<option>청양군</option>
				<option>보령시</option>
				<option>금산군</option>
				`
				)
				break;
			case 8:
				// 강원특별자치도
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>강릉시</option>
				<option>화천군</option>
				<option>철원군</option>
				<option>양구군</option>
				<option>춘천시</option>
				<option>정선군</option>
				`       
				)
				break;
			case 9:
				// 전북특별자치도
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>남원시</option>
				<option>익산시</option>
				<option>김제시</option>
				<option>임실군</option>
				`
				)
				break;
			case 10:
				// 전라남도
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>순천시</option>
				<option>진도군</option>
				<option>여수시</option>
				<option>신안군</option>
				<option>함평군</option>
				<option>보성군</option>
				<option>목포시</option>
				<option>장성군</option>
				<option>무안군</option>
				<option>담양군</option>
				`
				)
				break;
			case 11:
				// 경상북도
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>고령군</option>
				<option>청도군</option>
				<option>경산시</option>
				<option>안동시</option>
				<option>경주시</option>
				<option>김천시</option>
				`
				)
				break;
			case 12:
				// 경상남도
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>합천군</option>
				<option>거제시</option>
				<option>의령군</option>
				<option>산청군</option>
				<option>고성군</option>
				<option>거창군</option>
				`
				)
				break;
			case 13:
				// 세종특별자치시
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>어진동</option>
				`
				)
				break;
			case 14:
				// 제주특별자치도
				$("#gugun").html(
				`
				<option>모든 지역</option>
				<option>서귀포시</option>
				`
				)
				break;
			case 14:
				// 대전
				$("#gugun").html(
				`
				<option>모든 지역</option>
				`
				)
				break;
			default :
				$("#gugun").addClass("d-none");
				selSidoVal = "";
				break;
			}
		})
		
		$("#gugun").change(function() {
			//selGugunIdx = $("#gugun").prop('selectedIndex');
			selGugunVal = $("#gugun").val();
			console.log(selGugunVal);
		})
		
		
		
		$("#btn-search").click(function(){
			
			let searchText = $("#input-search").val()
			
			if($("#search").val() == "제목") {
				$.ajax({
					url : `${myPath}/searchFestivalName.do`
					, type : "GET"
					, data : {"fesName" : searchText}
					, success : function(searchRes) {
						console.log(searchRes);
						let htmlCode = 
							`
							<table class="table">
			            <thead>
			              <tr>
			                <th>번호</th>
			                <th>축제명</th>
			                <th>장소</th>
			                <th>기관</th>
			              </tr>
			            </thead><tbody>`
			            
			            let searchCnt = 0;
			            
			            for (i = 0; i < searchRes.length; i++) {
			            	if(searchRes[i].festival_delyn == "N") {
			            		htmlCode += `<tr>
					                <td class="festival-no">${searchRes[i].festival_no}</td>
					                <td class="festival-name cursor">${searchRes[i].festival_name}</td>
					                <td>${searchRes[i].festival_location}</td>
					                <td>${searchRes[i].festival_inst}</td>
					              </tr>`;	
			            		searchCnt++;
			            	}
			            }
			            
			            if(searchRes.length == 0 || searchCnt == 0) {
					    	htmlCode += `
					    	<tr>
			                <td class='text-center' colspan="4">관련 축제가 없습니다.</td>
			              </tr>`
			            }
			            
			          htmlCode += `</tbody></table>`
			          
			        	  $(".table").remove();
			        	 $("#main-bot").append(htmlCode);
					}
					, dataType : "JSON"
				})
			} else {
				let sido = selSidoVal;
				let gugun = selGugunVal;
				
				$.ajax({
					url : `${myPath}/searchFestivalLocation.do`
					, type : "GET"
					, data : {"fesLocation" : searchText
						, "sido" : sido
						, "gugun" : gugun}
					, success : function(searchRes) {
						console.log(searchRes);
						let htmlCode = 
							`
							<table class="table">
			            <thead>
			              <tr>
			                <th>번호</th>
			                <th>축제명</th>
			                <th>장소</th>
			                <th>기관</th>
			              </tr>
			            </thead><tbody>`
			            
			            let searchCnt = 0;
			            
			            for (i = 0; i < searchRes.length; i++) {
			            	if(searchRes[i].festival_delyn == "N") {
			            		htmlCode += `<tr>
				            		<td class="festival-no">${searchRes[i].festival_no}</td>
					                <td class="festival-name cursor">${searchRes[i].festival_name}</td>
				                <td>${searchRes[i].festival_location}</td>
				                <td>${searchRes[i].festival_inst}</td>
				              </tr>`;
			            		searchCnt++;
			            	}
			            	
			            }
			            
			            if(searchRes.length == 0 || searchCnt == 0) {
					    	htmlCode += `
					    	<tr>
			                <td class='text-center' colspan="4">관련 축제가 없습니다.</td>
			              </tr>`
			            }
			            
			          htmlCode += `</tbody></table>`
			          
			        	  $(".table").remove();
			        	 $("#main-bot").append(htmlCode);
					}
					, dataType : "JSON"
				})
				
			}
			pageTop();
			$(".page-top").hide();
			$(".more-view").hide();
		})
		
		
		// 페스티벌 디테일 정보
		$(document).on('click','.festival-name',function() {
			let thisFestivalNum = $(this).parent().find(".festival-no").text()
			// do로 보내기
			location.href = `${myPath}/detailFestival.do?fesNo=${thisFestivalNum}`;
		/* 	let sendData = {"fesNo" : thisFestivalNum}
			
			//location.href = `${myPath}/detailFestival.do?fesNo=${thisFestivalNum}`;
			$.ajax({
			url : `${myPath}/detailFestival.do`
			, type : "GET"
			, data : sendData
			, success : function(res) {
				map.panTo(new kakao.maps.LatLng(Number(res.latitude), Number(res.hardness)));
				$(window).scrollTop(0);
				$("#main-bot").hide();
				
				console.log(res);
				
				let htmlCode = `<div class='container d-flex flex-column'>
					<h3 class="mt-1">축제 정보</h3><hr>
				      <table class="table table-bordered">
			        <tr>
			          <td>축제명</td>
			          <td colspan="3">${res.festival_name}</td>
			        </tr>
			        <tr>
			          <td>축제일시</td>
			          <td>${res.festival_start}</td>
			          <td>축제위치</td>
			          <td>${res.festival_location}</td>
			        </tr>
			        <tr>
			          <td>주최기관</td>
			          <td>${res.festival_inst}</td>
			          <td>지번</td>
			          <td>${res.festival_addr}</td>
			        </tr>
			        <tr>
			          <td>소개</td>
			          <td colspan="3">
			          ${res.festival_content}
			          </td>
			        </tr>
			      </table>
			    `;
			    
			    
 			    htmlCode += 
				`<h3 class="mt-3">관련 모임 리스트</h3><hr>
				<table class="table">
            <thead>
              <tr>
                <th>번호</th>
                <th>축제명</th>
                <th>인원</th>
                <th>모집현황</th>
              </tr>
            </thead><tbody></div>`
            
            
            for (i = 0; i < partyList.length; i++) {
            	if(res.festival_no == partyList[i].festival_no) {
            		htmlCode += `<tr>
                        <td>${partyList[i].party_no}</td>
                        <td>${partyList[i].party_name}</td>
                        <td>5 / ${partyList[i].party_percount}</td>
                        <td>${partyList[i].party_delyn == "N" ? "모집중" : "모집마감"}</td>
                      </tr>`;
                }
            }
            
          htmlCode += `</tbody></table>`
				
				$('#main-container').append(htmlCode);
			} 
			, dataType : "JSON"
		}) */
		})
		
		// 상단으로 보내기
		let pageTop = function() {
			scrollTo(0, 0);
		}
		
        	  
		$('.page-top').click(function() {
			pageTop();
		})
		
		$('.more-view').click(function() {
			$('.page-top'). show();
			
			let htmlCode = `<tbody>`
			
			let listSizeFlag = parseInt(festivalList.length / currentListCnt);
			
			//console.log(parseInt(festivalList.length / currentListCnt));
			console.log(listSizeFlag);
			console.log(currentListCnt);
			
			if(currentListCnt == 17 && listSizeFlag == 10) {
				for (i = currentListCnt * 10; i < festivalList.length ; i++) {
	            	htmlCode += `<tr>
	                <td class="festival-no">${festivalList[i].festival_no}</td>
	                <td class="festival-name cursor">${festivalList[i].festival_name}</td>
	                <td>${festivalList[i].festival_location}</td>
	                <td>${festivalList[i].festival_inst}</td>
	              </tr></tbody>`;
	              
	              $(this).hide();
	            }
			} else {
				for (i = currentListCnt * 10; i < 10 * (currentListCnt + 1) ; i++) {
	            	htmlCode += `<tr>
	                <td class="festival-no">${festivalList[i].festival_no}</td>
	                <td class="festival-name cursor">${festivalList[i].festival_name}</td>
	                <td>${festivalList[i].festival_location}</td>
	                <td>${festivalList[i].festival_inst}</td>
	              </tr></tbody>`;
	            }
				currentListCnt++;
			}
			
				$("#fot").css("bottom","0");
        	  $("#fesList").append(htmlCode);
        	  
        	  $("#container-more-view").css("bottom","20px");
        	  
        	  // 아래로 보내기
        	  scrollTo(0, document.body.scrollHeight);
		})
		
		
		// 축제 등록
		$(document).on('click',"#add-festival",function() {
			location.href = `${myPath}/festival/addFestival.jsp`;
		})
		
	})
</script>
<style>
main {
	height: auto;
}

main #main-bot {
	height: auto;
}

#main-container {
	position: relative;
	height: auto;
}

footer {
	position: absolute;
	bottom: 0;
}

table {
	text-align: center;
}

tr th, tr td :first-child {
	width: 30px;
}

.more-view {
	cursor: pointer;
	position: relative;
}

.page-top {
	cursor: pointer;
}

#container-more-view {
	position: absolute;
	z-index: 999;
}

#fesList {
	position: relative;
}

#add-festival-div {
	position: fixed;
	display : flex;
	bottom: 30px;
	right: 100px;
	z-index: 999;
}
</style>
</head>
<body>
	
	<header id="nav">
		<jsp:include page="../jsp/nav.jsp" />
	</header>
	<main>
		<div id="main-top">
			<div id="map"></div>
		</div>
		<div id="main-container">

			<div id="main-bot" class="inner">
				<div class="container mt-2 mb-2">
					<div class="form-group d-flex d-flex-column">
						<select class="form-control" style="width: 150px;" id="search">
							<option value="제목">제목</option>
							<option value="지역">지역</option>
						</select> <select class="form-control d-none" style="width: 150px;"
							id="sido">
							<option>모든 시/도</option>
							<option>서울특별시</option>
							<option>부산광역시</option>
							<option>대구광역시</option>
							<option>인천광역시</option>
							<option>울산광역시</option>
							<option>경기도</option>
							<option>충청남도</option>
							<option>강원특별자치도</option>
							<option>전북특별자치도</option>
							<option>전라남도</option>
							<option>경상북도</option>
							<option>경상남도</option>
							<option>세종특별자치시</option>
							<option>제주특별자치도</option>
							<option>대전광역시</option>
						</select> <select class="form-control d-none" style="width: 150px;"
							id="gugun">
						</select> 
						<input type="text" class="form-control" id="input-search"
							placeholder="축제명을 입력해주세요." />
						<button type="button" id="btn-search" class="btn btn-primary"
							style="width: 100px;">검색</button>
					</div>
					<h3 class="mt-3">축제 리스트</h3>
					<hr>
				</div>

				<div id="container-more-view"
					class="inner d-flex justify-content-end align-itmes-center mt-5">
					<div class="page-top">페이지 상단으로</div>
					<div style="width : 50px"></div>
					<div class="more-view">더보기</div>
				</div>
			</div>
		</div>

	</main>
	<footer id="fot">
		<jsp:include page="../jsp/footer.jsp" />
	</footer>
</body>
</html>