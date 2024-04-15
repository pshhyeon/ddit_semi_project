<%@page import="ddit.vo.FestivalVO"%>
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
<script src="/semi_project/js/weather.js" defer></script>

<!-- 카카오 맵 -->
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=[insert_your_key]"></script>
<!-- 스크립트 -->
<script src="/semi_project/js/script.js" defer></script>
<script src="/semi_project/js/detailFestival.js" defer></script>
<%
	String fesInfo = (String)request.getAttribute("detailFestival");
%>
<script>
	
	$(function() {
		$("#link-myPage").click(function(){
			if(user == null) {
				location.href = `${myPath}/user/loginForm.jsp`;
			} else if(user.user_admin_chk == "Y") {
				location.href = `${myPath}/user/adminPage.jsp`;
			} else {
				location.href = `${myPath}/user/myPage.jsp`;
			}
		})
		
		// myPath 전역
		myPath = "<%=request.getContextPath()%>"
		let thisFestival = <%=fesInfo %>;
		let user = <%=session.getAttribute("user")%>;
		
		let partyList = ""; // 소모임 리스트 넣을 변수
		// 사이트 접속하면 소모임 리스트 받아오기
		$.ajax({
			url : `${myPath}/partyList.do`
			, type : "GET"
			, success : function(res) {
				partyList = res;
				
				// 카카오 지도 ---------------------------------------------------------------------
				// 중심 변경
				map.panTo(new kakao.maps.LatLng(Number(thisFestival.latitude), Number(thisFestival.hardness)));
				
				let marker = new kakao.maps.Marker({
		          		  position: new kakao.maps.LatLng(Number(thisFestival.latitude), Number(thisFestival.hardness)), // 마커의 좌표
		          		  map: map, // 마커를 표시할 지도 객체
		          		});
					
					var content =
				        '<div class="wrap">' +
				        '    <div class="info">' +
				        '        <div class="title">' +
				        			thisFestival.festival_name	+
				        "        </div>" +
				        '        <div class="body">' +
 				        '            <div class="desc">' +
				        '                <div class="ellipsis">' + thisFestival.festival_content +'</div>' +
				        '                <div class="jibun ellipsis">' + thisFestival.festival_addr + '</div>' +
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
				// 카카오 지도 ---------------------------------------------------------------------
				
				let htmlCode = `<div class='container d-flex flex-column'>
					<h3 class="mt-1">축제 정보</h3><hr>
				      <table class="table table-bordered">
			        <tr>
			          <td>축제명</td>
			          <td>${thisFestival.festival_name}</td>
			          <td>주최기관</td>
			          <td>${thisFestival.festival_inst}</td>
			        </tr>
			        <tr>
			          <td>축제일시</td>
			          <td>${thisFestival.festival_start}</td>
			          <td>축제위치</td>
			          <td>${thisFestival.festival_location}</td>
			        </tr>
			        <tr>
			          <td>사이트</td>
			          <td>
			          	<a target='${thisFestival.festival_site == null ? "" : "_blank"}' href=${thisFestival.festival_site == null ? 'javascript:void(0)' : `${thisFestival.festival_site}`}>
			          		${thisFestival.festival_site == null ? "없음" : thisFestival.festival_site}
			          	</a>
			          </td>
			          <td>지번</td>
			          <td>${thisFestival.festival_addr}</td>
			        </tr>
			        <tr>
			          <td>소개</td>
			          <td colspan="3">
			          ${thisFestival.festival_content}
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
		    
		    let partyFlag = false;
		    // 현재 축제 번호와 일치하는 축제 번호를 가진 모임이 있을 때 리스트 출력
		    for (i = 0; i < partyList.length; i++) {
		    	console.log(partyList[i].festival_no);
		    	
		    	if(thisFestival.festival_no == partyList[i].festival_no) {
		    		partyFlag = true;
		    		htmlCode += `<tr>
		                <td>${partyList[i].party_no}</td>
		                <td class="partyList_name" pidx=${partyList[i].party_no}>${partyList[i].party_name}</td>
		                <td>5 / ${partyList[i].party_percount}</td>
		                <td>${partyList[i].party_delyn == "N" ? "모집중" : "모집마감"}</td>
		              </tr>`;
		        }
		    }
		    // 관련 소모임 없을 때 출력할 거
		    if(!partyFlag) {
		    	htmlCode += `
		    	<tr>
                <td class='text-center' colspan="4">관련 소모임이 없습니다.</td>
              </tr>`
		    }
		    
		    // 여기서 관리자 버튼 추가해야 함
		    if(user != null && user.user_admin_chk == "Y") {
	      			let adminBtn = `
	      				<button class="btn btn-danger" id="btn-updateFes">수정</button>
	      				<div style="width : 20px"></div>
	      				<button class="btn btn-danger" id="btn-deleteFes">삭제</button>
	      				<div style="width : 20px"></div>
	      				`
	      			$("#controller-div").prepend(adminBtn);
	      		} 
		    
		    // 소모임 등록 버튼 플래그
		    let addFlag = [];
		    
		    for(i = 0; i < partyList.length; i++) {
		    		if(user != null && user.user_admin_chk != 'Y' && 
		    				partyList[i].user_no == user.user_no && 
		    				partyList[i].festival_no == thisFestival.festival_no ) {
		    			addFlag.push(true);
		    			break;
		    	}
		    }
		    
		    if(user != null && user.user_admin_chk != 'Y' && !addFlag.includes(true)) {
		    	let adminBtn = `
      				<button class="btn btn-danger" id="btn-addParty">새 모임 등록</button>
      				<div style="width : 20px"></div>
      				`
      			$("#controller-div").prepend(adminBtn);
		    }
	      			
		    
		 	 	htmlCode += `</tbody></table>`
				
				$('#main-bot').append(htmlCode);
			}
			, dataType : "JSON"
		})
		
		// 축제 목록으로 돌아가기
		$("#btn-toFestivalList").click(function() {
			location.href = `${myPath}/festival/festivalMain.jsp`
		})
		
		// 해당 축제 삭제
		$(document).on("click","#btn-deleteFes",function() {
			$.ajax({
				url : `${myPath}/deleteFestival.do`
				, data : {"currentFesNo" : thisFestival.festival_no}
				, success : function() {
					alert(`${thisFestival.festival_name} 축제가 삭제되었습니다.`);
					location.href = `${myPath}/festival/festivalMain.jsp`;
				}
			})
		})
		
		$(document).on("click","#btn-updateFes",function() {
			console.log(thisFestival.festival_no);
			location.href = `${myPath}/festival/updateFestival.jsp?fesNo=${thisFestival.festival_no}`;
			/* $.ajax({
				url : `${myPath}/festival/updateFestival.jsp?fesNo=${thisFestival.festival_no}`
				, type : "GET"
				, success : function() {
					//alert("축제 수정 페이지로 이동합니다.");
					//location.href = `${myPath}/festival/updateFestival.do`;
				}
			}) */
		})
		
		// 모달 정보 가져오기
		console.log("@@@@아아아아악 ==> " + user);
		modal_login_chk = false;
		modal_party_no = "";
		modal_user_no = 0;
		modal_user_admin_chk = "N";
		modal_party_user_status = "";
        if(user != null){ 
        	modal_login_chk = true; // 로그인 체크
        	modal_user_no = user.user_no; // 유저번호 가져오기
        	modal_user_admin_chk = user.user_admin_chk; // 유저 admin값 가져오기
        } 

		// 소모임명 클릭
		$(document).on('click', '.partyList_name', function() {
			modal_party_no = $(this).attr('pidx');
	        console.log("@@ index.jsp @@ modal_login_chk ==> " + modal_login_chk);
	        console.log("@@ index.jsp @@ modal_party_no ==> " + modal_party_no);
	        console.log("@@ index.jsp @@ modal_user_no ==> " + modal_user_no);
	        console.log("@@ index.jsp @@ modal_user_admin_chk ==> " + modal_user_admin_chk);
	        userPartyChk();
	        
	    });
		
		// 모달 가입버튼 클릭
		$(document).on('click', '#modaljoinBtn', function() {
			modifyJoinBtn(); // 수정
		});
		
		// 모달 찜버튼 클릭
		$(document).on('click', '#modalBookmarkBtn', function() {
			modifyBookmarkBtn(); // 수정
		});
		
		// 소모임 등록 이벤트
		$(document).on('click', '#btn-addParty', function() {
				console.log("thisFestival.festival_no ==> " + thisFestival.festival_no);
				console.log("thisFestival.festival_name ==> " + thisFestival.festival_name);
				console.log("user.user_no ==> " + user.user_no);
				location.href = `${myPath}/party/registerParty.jsp?festival_no=${thisFestival.festival_no}&festival_name=${thisFestival.festival_name}`;
		});
		
		
	})
</script>
<style>
	#controller-div {
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
	<div id="controller-div"><button class="btn btn-danger" id="btn-toFestivalList">축제 목록으로</button></div>
	<div id="main-top">
			<div id="map"></div>
		</div>
		<div id="main-bot" class="container inner">
			
		</div>
	</main>
	
	
	<!-- detailFestival 소모임 모달 -->
    <!-- The Modal -->
	<div class="modal" id="partyInfoModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div id="party-detail-modal" class="modal-content">
	    
	    </div>
	  </div>
	</div>
	
	<footer id="fot">
		<jsp:include page="../jsp/footer.jsp" />
	</footer>
</body>
</html>
