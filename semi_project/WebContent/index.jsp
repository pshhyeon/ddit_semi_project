<%@page import="ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true"%>
<html lang="en">

	

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <!-- 부트스트랩 -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- 제이쿼리 -->
    <script
      src="https://code.jquery.com/jquery-3.7.1.min.js"
      integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
      crossorigin="anonymous"
    ></script>
    <!-- 머테리얼 아이콘 -->
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
    <!-- 스타일 -->
    <link rel="stylesheet" href="./css/styles.css" />
    <!-- 모달 스타일 -->
    <link rel="stylesheet" href="./css/partyMainStyles.css" />
    <!-- 카카오 맵 -->
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=dde7b3ab140fbaa2cba75ccfb885e2da"></script>
    <!-- 스크립트 -->
    <script src="./js/script.js" defer></script>
    <!-- 날씨 스크립트 -->
    <script src="./js/weather.js" defer></script>
    <!-- index js -->
    <script src="./js/index.js"></script>
    
    <!-- 내부 스크립트 -->
    <script>
	$(function() {
		
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
		
		// myPath 전역 변수로 변경
		myPath = "<%=request.getContextPath()%>"
		let user = <%=session.getAttribute("user")%>;
		
		
		let partyList = "";
		let festivalList = "";
		
		$(document).on('click','.festival-name', function() {
			let thisFestivalNum = $(this).parent().find(".festival-no").text()
			// do로 보내기
			location.href = `${myPath}/detailFestival.do?fesNo=${thisFestivalNum}`;
		})
		
		// 사이트 접속하면 축제 리스트 받아오기
		$.ajax({
			url : `${myPath}/festivalList.do`
			, type : "GET"
			, async : false
			, success : function(res) {
				festivalList = res;
				
				for(i = 0; i < festivalList.length; i++) {
					let marker = new kakao.maps.Marker({
		          		  position: new kakao.maps.LatLng(Number(res[i].latitude),  Number(res[i].hardness)), // 마커의 좌표
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

		          		// 마커 위에 표시할 인포윈도우를 생성한다
		          		/* let infowindow = new kakao.maps.InfoWindow({
		          		  content: `<div style="padding:5px;">${res[i].festival_content}</div>`, // 인포윈도우에 표시할 내용
		          		});
		          		infowindow.open(map, marker);	 */
				}
				
				let htmlCode = `
					<thead>
		              <tr>
		                <th>번호</th>
		                <th>축제명</th>
		                <th>장소</th>
		                <th>기관</th>
		              </tr>
		            </thead>
				`
				for (i = 0; i < 5; i++) {
	            	htmlCode += `<tbody><tr>
	                <td class="festival-no">${res[i].festival_no}</td>
	                <td class="festival-name cursor">${res[i].festival_name}</td>
	                <td>${res[i].festival_location}</td>
	                <td>${res[i].festival_inst}</td>
	              </tr></tbody>`;
	            	
	            }
				$("#fesList").append(htmlCode);
				map.panTo(new kakao.maps.LatLng(Number(festivalList[0].latitude), Number(festivalList[0].hardness)));
			}
			, dataType : "JSON"
		})
		
		$.ajax({
			url : `${myPath}/partyList.do`
			, type : "GET"
			, success : function(res) {
				partyList = res;
				
				let htmlCode = `
					<thead>
						<tr>
		                <th>번호</th>
		                <th>축제명</th>
		                <th>인원</th>
		                <th>모집현황</th>
		              </tr>
		            </thead>`
		            
		            for(i = 0; i < 5; i ++) {
		            	htmlCode += `<tbody><tr>
	                        <td>${partyList[i].party_no}</td>
	                        <td class="partyList_name" pidx=${partyList[i].party_no}>${partyList[i].party_name}</td>
	                        <td>5 / ${partyList[i].party_percount}</td>
	                        <td>${partyList[i].party_delyn == "N" ? "모집중" : "모집마감"}</td>
	                      </tr></tbody>`;
		            }
		            $("#partyList").append(htmlCode);
		            
			}
			, dataType : "JSON"
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
		
		/* const scrollHeight = $("header").height() + $("footer").height() + $("main").height();
		console.log($("header").height())
		console.log($("main").height())
		console.log($("footer").height())
		$("#sidebar").css("height",scrollHeight + 229); */
	})
</script>
    
  </head>
  <body>
    
    <header>
    	<jsp:include page="/jsp/nav.jsp"/>
    </header>
    
    <main>
      <div class="inner">
        <div id="main-top"><div id="map"></div></div>
        <div id="main-bot">
          <div id="more-view">
            <div class="part">
              <h2 class="text-primary">축제</h2>
            </div>
            <a href="<%=request.getContextPath()%>/festival/festivalMain.jsp" class="blockquote-footer cursor">더 보기</a>
          </div>
          <hr>
          <table class="table" id="fesList">
            
          </table>
          <div id="main-bot-part"></div>
          <!-- 축제 게시판 -->
          <div id="more-view">
            <div class="part">
              <h2 class="text-primary">소모임</h2>
            </div>
            <a href="<%=request.getContextPath()%>/party/partyMain.jsp" class="blockquote-footer cursor">더 보기</a>
          </div>
          <hr>
          <table class="table" id="partyList">
            
          </table>
          <!-- 모임 게시판 -->
        </div>
      </div>
    </main>

	<!-- index 소모임 모달 -->
    <!-- The Modal -->
	<div class="modal" id="partyInfoModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div id="party-detail-modal" class="modal-content">
	    
	    </div>
	  </div>
	</div>
    
    <footer>
    	<jsp:include page="/jsp/footer.jsp"/>
    </footer>
  </body>
</html>
