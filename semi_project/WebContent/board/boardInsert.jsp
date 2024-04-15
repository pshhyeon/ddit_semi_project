<%@page import="ddit.vo.UserVO"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.con{
	text-align: center;
}
#userid{
	display : none;
}
</style>
</head>
<body>
 <script src="../js/jquery-3.7.1.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script src="../js/weather.js" defer></script>


<script>
    $(function() {
    	<%
        int userNo = 0;
        String userJsonStr = (String) session.getAttribute("user");
        // 세션에서 JSON 데이터를 문자열로 가져오기
        if(userJsonStr != null) {
           userJsonStr = (String) session.getAttribute("user");
           
           Gson gson = new Gson();
           UserVO user = gson.fromJson(userJsonStr, UserVO.class);
     
           // 필요한 속성에 접근하여 데이터를 가져옵니다.
           userNo = user.getUser_no();
           System.out.println("@@@@@user번호 정보@@@@@" + userNo);
        }
     %>
     $('#submitBtn').prop('disabled', true);
     	
		let mypath = "<%=request.getContextPath()%>"
		
		
		$("#link-myPage").click(function() {
			if (user == null) {
				location.href = `${mypath}/user/loginForm.jsp`;
			} else if (user.user_admin_chk == "Y") {
				location.href = `${mypath}/user/adminPage.jsp`;
			} else {
				location.href = `${mypath}/user/myPage.jsp`;
			}
		})
		
		
		
		
		let a = function() {
			location.reload();
		}
		
		
		 $('#boardTitle').on('keyup', function() {
	            checkInputs();
	        });
		 
		 $('#boardContent').on('keyup', function() {
	            checkInputs();
	        });
		
		function checkInputs() {
			
            let title = $('#boardTitle').val();
            let content = $('#boardContent').val();

            // 제목과 내용 모두에 값이 있을 때 버튼을 활성화
            if (((title != '') && (content != ''))) {
                $('#submitBtn').prop('disabled', false);
            } else {
                $('#submitBtn').prop('disabled', true);
            }
        }
		
		
	})
</script>
</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>
<div class="container mt-3">
  <h2 class='con'>자유게시판</h2>
  <p class='con'>여러분들이 자유롭게 의견을 나누고 소통할 수 있는 공간입니다.</p>  
  <br><br>
  
   <div class="container">
    <div class ="row">
	    <form method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/boardInsert.do">
	    <h3>새 게시물 작성</h3>
	    <hr>
	    
	    <input placeholder="제목 내용" type="text" class="txt" id="boardTitle" name="boardTitle" style="width: 100%" ><br><br>
	     
	     <input type="file" class="file" name="file" id="file"><br><br>
	     <textarea placeholder="글 내용" id="boardContent" name="boardContent" maxlength="500" style="height:350px; width: 100%"></textarea>
	     <br>
	     <div style="text-align: right">
	     	 <input type="submit" onsubmit="a()" id="submitBtn" class="btn btn-light pull-right" value="작성">
	     </div>
	     <div id="userid" style="display : none;">
	     	<input type="text" value="<%=userNo %>" name="user">
	     </div>
	   </form> 
    </div>
   
   </div>  
</div>
</main>
<footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>