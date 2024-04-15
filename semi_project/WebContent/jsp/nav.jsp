<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<!-- 머테리얼 아이콘 -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<!-- 스타일 -->
<link rel="stylesheet" href="/semi_project/css/styles.css" />
<!-- 스크립트 -->
<script src="/semi_project/js/weather.js" defer></script>
<script>
	$(function() {
		let user = <%=session.getAttribute("user")%>;
		
		if (user == null) {
		    $("#mypage").text("account_circle");
		  } else {
		    $("#mypage").text("how_to_reg");
		  }
		
		// 축제 게시판 이동
		$('#festivalBoard').on('click', function() {
			location.href = '<%=request.getContextPath()%>/festival/festivalMain.jsp';
		});
		
		// 소모임 게시판 이동
		$('#partyBoard').on('click', function() {
			location.href = '<%=request.getContextPath()%>/party/partyMain.jsp';
		});
		
		// 자유 게시판 이동
		$('#freeBoard').on('click', function() {
			location.href = '<%=request.getContextPath()%>/board/freeBoard.jsp';
		});
		
		// 공지사항 게시판 이동
		$('#notiBoard').on('click', function() {
			location.href = '<%=request.getContextPath()%>/board/announcement.jsp';
		});
		
		// 1:1문의 게시판 이동
		$('#requestBoard').on('click', function() {
			location.href = '<%=request.getContextPath()%>/request/requestMain.jsp';
		});
		
		
	})

</script>

<header>
	<div class="toggle-btn" onclick="sideBarShow()">
		<span class="material-symbols-outlined" style="font-size: 40px">menu</span>
	</div>
	<div id="sidebar" class="container">
		<ul>
			<li id="festivalBoard">축제 게시판</li>
			<li id="partyBoard">소모임 게시판</li>
			<li id="freeBoard">자유 게시판</li>
			<li id="notiBoard">공지사항</li>
			<li id="requestBoard">1:1문의</li>
		</ul>
	</div>
	<div class="inner">
		<a href="<%=request.getContextPath()%>/index.jsp">
		<div id="logo" class="cursor"></div></a>

		<div id="weather-mypage">
			<div class="part"></div>
			<img id="weatherIcon" src="" />
			<div id="weather">
				<span></span> <span></span>
			</div>
			<div class="part"></div>
			<a id="link-myPage"> <span
				class="material-symbols-outlined cursor" id="mypage"
				style="font-size: 40px"> account_circle </span></a>
		</div>
	</div>
</header>
