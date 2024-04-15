<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<script src="/semi_project/js/jquery.serializejson.min.js"></script>
<script src="/semi_project/js/weather.js" defer></script>

<script>
    $(function() {
		let myPath = "<%=request.getContextPath()%>"
		let user = <%=session.getAttribute("user")%>;
		console.log(user);
		
		// 로그인 돼있으면 마이페이지로 아니면 로그인폼으로
		$("#link-myPage").click(function(){
			if(user == null) {
				location.href = `${myPath}/user/loginForm.jsp`;
			} else {
				location.href = `${myPath}/user/myPage.jsp`;
			}
		})
	})
</script>
</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>
<!-- 여기 작성 -->
</main>
<footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>