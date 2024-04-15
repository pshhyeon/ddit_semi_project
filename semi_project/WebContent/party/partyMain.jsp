<%@page import="ddit.vo.UserVO"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!-- 부트스트랩 -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- 제이쿼리 -->
    <script src="/semi_project/js/jquery-3.7.1.min.js"></script>
    <!-- 머테리얼 아이콘 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- 스타일 -->
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/partyMainStyles.css" />
    <!-- 날씨 스크립트 -->
    <script src="/semi_project/js/weather.js" defer></script>
	<!-- partyMain.js -->    
    <script src="/semi_project/js/partyMain.js"></script>
    
    <style>
    

    </style>
    
	<script>
		<%
			int userNo = 0;
			boolean adminChk = false;
			String userJsonStr = (String) session.getAttribute("user");
			// 세션에서 JSON 데이터를 문자열로 가져오기
			if(userJsonStr != null) {
				userJsonStr = (String) session.getAttribute("user");
				
				Gson gson = new Gson();
				UserVO user = gson.fromJson(userJsonStr, UserVO.class);
		
				// 필요한 속성에 접근하여 데이터를 가져옵니다.
				userNo = user.getUser_no();
				adminChk = "Y".equals(user.getUser_admin_chk()) ? true : false;
				System.out.println("@@party/partyMain.jsp@@user번호 정보@@@" + userNo);
			}
		%>
		
		myPath = '<%= request.getContextPath() %>';
		currentPage = 1;
		user_no = 0; // 유저 번호
		party_user_status = ""; // 파티에 대한 유저 상태   0:일반   1:가입대기   2:가입중  3:탈퇴   4:강퇴
		loginChk = function() {
			if (user_no == 0) {
				return false;
			} else {
				return true;
			}
		}
		
		$(function() {
			user = <%=userJsonStr%>;
			user_no =  <%=userNo%>;
			user_admin_chk = <%=adminChk%>;
			console.log("@@party/partyMain.jsp@@user_admin_chk ==> " + user_admin_chk);
			partyList();    	
			
			// 마이페이지 버튼 이벤트
			$("#link-myPage").click(function(){
				if(user == null) {
					location.href = `${myPath}/user/loginForm.jsp`;
				} else if(user.user_admin_chk == "Y") {
					location.href = `${myPath}/user/adminPage.jsp`;
				} else {
					location.href = `${myPath}/user/myPage.jsp`;
				}
			})
			
			$('#search').on('click', function() {
				  currentPage = 1;
				  partyList();
			 });
			
			// 페이지 버튼 클릭
			$(document).on('click', '.pnum', function() {
				currentPage = parseInt($(this).text());
				partyList();
			});
			
			// 다음 버튼 클릭
			$(document).on('click', '.next', function() {
				currentPage = parseInt($('.pnum').last().text()) + 1
				partyList();
			});
			
			// 리스트 선택 클릭
			$(document).on('click', '.listOne', function() {
				gthis = this;
				vId = $(this).attr('id');
				
				userPartyChk(loginChk());				
			})
			
			// 모달창 버튼 클릭
			// 유저 번호 ==> user_no
			// 파티 번호 ==> 
			// 찜 버튼 클릭
			$(document).on('click', '#modaljoinBtn', function() {
				// user_no 회원번호
				// party_user_status 파티에 대한 회원의 상태
				// let modal_party_no = vId 선택한 파티 번호
				modifyJoinBtn(); // 수정
			});
			
			$(document).on('click', '#modalBookmarkBtn', function() {
				// user_no 회원번호
				// party_user_status 파티에 대한 회원의 상태
				// let modal_party_no = vId 선택한 파티 번호
				modifyBookmarkBtn(); // 수정
			});
			
		});
	</script>
    
</head>
<body>

<header>
	<jsp:include page="/jsp/nav.jsp"/>
</header>
    
<main>
    
	<div class="container mt-3">
	  <h1>소모임</h1>
	  <p>다양한 유저들과 모임을 통해 축제를 즐겨보세요 :)</p>
	<div id="search" class="d-flex flex-row">
	  <select id="stype" class="form-select-sm" 
	  			style="width: 200px; text-align: center; border-color : #ed4c78; border-radius: 0.375rem;">
	    <option value="" selected>검색유형선택</option>
	    <option value="title">제목</option>
	    <option value="hashtag">해시태그</option>
	  </select>
	  <div style="width : 50px"></div>
	  <input type="text" id="sword" class="form-control" style="border-color: #ed4c78"/>
	  <div style="width : 50px"></div>
	  <input type="button" id="search" class="btn btn-primary" value="검색" style="border: none; background-color: #ed4c78;"/>
	</div>
	            
	<table class="table table-hover mt-5">
	  <thead>
	    <tr>
	      <th>번호</th>
	      <th>모임명</th>
	      <th>지역명</th>
	      <th>모집인원</th>
	      <th>모집상태</th>
	   </tr>
	  </thead>
	  <tbody id="partyListBody">
	  
	  </tbody>
	</table>
	<div class="d-flex justify-content-center">
		<div id="pageNav" class=""></div>
	</div>
	
	</div>
    
    <!-- The Modal -->
	<div class="modal" id="partyInfoModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div id="party-detail-modal" class="modal-content">
	    
	    </div>
	  </div>
	</div>
	    
    
    
</main>
    
<footer>
	<jsp:include page="/jsp/footer.jsp"/>
</footer>

</body>
</html>