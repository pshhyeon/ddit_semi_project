<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!-- 제이쿼리 -->
    <script src="../js/jquery-3.7.1.min.js"></script>
 	<!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- 머테리얼 아이콘 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- 스타일 -->
    <link rel="stylesheet" href="../css/styles.css" />
    <!-- 날씨 스크립트 -->
    <script src="../js/weather.js" defer></script>
    
    <script>
    <%
		request.setCharacterEncoding("utf-8");
		String userJsonStr = "";
		if(session.getAttribute("user") != null || userJsonStr.equals("")){
			userJsonStr = (String) session.getAttribute("user");
		}
    	int partyNo = Integer.parseInt(request.getParameter("selectedPartyNo")); 
    %>
    partyNo = <%= partyNo%>;
	myPath = "<%= request.getContextPath() %>";
	
	console.log("partyNo ==> " + partyNo);
	console.log("myPath ==> " + myPath);
	var user = <%=userJsonStr%>;
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
		});
		
		$('.nav-link').click(function(event) {
//             event.preventDefault(); // 기본 동작(페이지 이동) 방지
            // 활성 탭 설정
            $('.nav-link').removeClass('active'); // 모든 nav-link 클래스에서 active 클래스 제거
            $(this).addClass('active'); // 현재 클릭된 nav-link에 active 클래스 추가
            
            var changePage = $(this).attr('changePage'); // changePage 속성값 가져오기
            $('iframe').attr('src', changePage); // iframe의 src 속성 변경
        });
		
		// 부모 창에서 이동을 처리하는 함수
		function navigateParentToURL() {
		    location.href = '/semi_project/index.jsp';
		}

		// 메시지 수신을 위한 리스너 등록
		window.addEventListener('message', function(event) {
		    // iframe으로부터의 메시지를 감지하여 이동을 처리
		    if (event.data === 'navigateParentToURL') {
		        navigateParentToURL(); // 부모 창 이동
		    }
		}, false);
		
    });	
	</script>
	
</head>
<body>

<header>
	<jsp:include page="/jsp/nav.jsp"/>
</header>
    
<main>
    <div class="container mt-3">
    
        <!-- 네브 탭 가운데 정렬 -->
        <ul class="nav nav-tabs d-flex justify-content-center">
            <li class="nav-item text-center" style="width : 33%">
                <a changePage='/semi_project/party/partyDetailMain.jsp?selectedPartyNo=<%=partyNo%>' class="nav-link active" href="#">Main</a>
            </li>
            <li class="nav-item text-center" style="width : 33%">
                <a changePage='/semi_project/party/partyPhoto.jsp?selectedPartyNo=<%=partyNo%>' class="nav-link" href="#">Photo</a>
            </li>
            <li class="nav-item text-center" style="width : 33%">
                <a changePage='/semi_project/party/partyDetailBoard.jsp?selectedPartyNo=<%=partyNo%>' class="nav-link" href="#">Noti</a>
            </li>
        </ul>
        <!-- /네브 탭 가운데 정렬 -->
        
        <div class="iframe-container" style="overflow: hidden;">
            <iframe src="/semi_project/party/partyDetailMain.jsp?selectedPartyNo=<%=partyNo%>" class="iframe-content" 
                    width="100%" height="900px" style="overflow: hidden;"></iframe>
        </div>
    </div>
</main>


<footer>
	<jsp:include page="/jsp/footer.jsp"/>
</footer>

</body>
	
</html>