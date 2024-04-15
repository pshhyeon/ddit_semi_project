<%@page import="java.util.List"%>
<%@page import="ddit.vo.NotificeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
h3{
  text-align: center;
}
</style>

</head>
<%
  List<NotificeVO> nboardList = (List<NotificeVO>)request.getAttribute("notiList");
%>
<body>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<script src="/semi_project/js/jquery.serializejson.min.js"></script>
<script src="/semi_project/js/weather.js" defer></script>
<link rel="stylesheet" href="../css/partyMainStyles.css">
<script>
	$(() => {
		$('#returnList').on('click', function() {
			window.history.back();
		})
	})
</script>
</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>
<!-- 여기 작성 -->
<div class="container mt-3">
  <h2>공지사항</h2>
  <br><br>
  
   <div class="container">
    <div class ="row">
    <form method="get" action="/semi_project/insertNoti.do">
    <h3>게시판 글작성</h3>
    <hr>
    
    <input placeholder="글 내용" type="text" class="txt" id="notiTitle" name="notiTitle" style="width: 100%" ><br><br>
     <textarea placeholder="글 내용" name="notiContent" maxlength="500" style="height:350px; width: 100%"></textarea>
     <br>
      <button id="returnList" type="button" class="btn btn-primary" style="background-color: #ed4c78; border: none; margin: 5px;">목록</button>
      <button id="writebtn" type="submit" class="btn btn-primary" style="background-color: #ed4c78; border: none; margin: 5px;">글쓰기</button>
   </form> 
    </div>
   
   </div> 
</div>
</main>
<footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>