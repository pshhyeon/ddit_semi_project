<%@page import="ddit.vo.UserVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="ddit.vo.NotificeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/semi_project/js/jquery.serializejson.min.js"></script>
<script src="/semi_project/js/weather.js" defer></script>

<%

 NotificeVO vo = (NotificeVO)request.getAttribute("vo");
 
%>

<style>
.con{
	text-align : center; 
}

#btncon{
	text-align : right;
}

#btncon input[type=button]{
    color : white;
}


</style>
</head>
<body>

<script>
$(function(){
	let myPath = "<%=request.getContextPath()%>"
	let user = <%=session.getAttribute("user")%>;
	console.log(user);
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
 	let userAdminChk = <%=userNo%>;
	if(userAdminChk == 27){
		$("#modi").show();
		
		$("#del").show();
	}	
 
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
	
    $('#del').click(function() {
        if(confirm('정말로 삭제하시겠습니까?')) {
            var notiNo = '<%=vo.getNotifice_no()%>';  // 공지사항 번호를 가져옵니다.
            location.href = `${myPath}/notiDelete.do?notiNo=${notiNo}`; // 서블릿으로 삭제 요청을 보냅니다.
        }
    });
	
	 $('#rev').click(function() {
				
	          // 뒤로가기
	          location.href="/semi_project/board/announcement.jsp";
	        
	    });
	 
	 // 수정
	 $(document).on('click', '#modi',function(){
		 vparents = $(this).parents('.container');
			vtitle = $(vparents).find('.qtitle').text().trim();
			vcontent = $(vparents).find('.qcontent').text().trim();
			vcontent = vcontent.replaceAll(/<br>/g,"\n");
			
			$('.modi1').show();
			$('.modi2').hide();
			
			$('#titlecode').val(vtitle);
			$('#contentcode').val(vcontent);
			
			
			console.log(vtitle, vcontent);
			
			$('#modi').hide();
			$('#del').hide();
			$('#modisend').show();
	 })
	 
	 //수정 확인
	 $(document).on('click','#modisend',function(){
		modititle = $('#titlecode').val();
		modicontent = $('#contentcode').val();
		modinotiNo = <%=vo.getNotifice_no()%>;
		
		$.ajax({
			url : `${myPath}/updateNoti.do`,
			type : 'get',
			data : {"title" : modititle , "content" : modicontent, "notiNo" : modinotiNo},
			success : function(res){
				alert("수정이 완료되었습니다.");
				location.href = `${myPath}/board/announcement.jsp`;
			},
			error : function(xhr){
				alert("실패 : "+xhr.status);
			},
			dataType : 'json'
		})
		
	})
})

</script>
</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>
<div class ="container mt-3">
	  <h2 class="con">공지사항</h2>
  <p class="con"></p>     
	
 <table class="table table-bordered">
    <thead>
      <tr>
        <th class="table-light">제목</th>
        
        <th colspan="3" class="qtitle">
        <input type='text' id='titlecode'  class='modi1' style='display: none; size : 100px;'>
        <span class='modi2'><%=vo.getNotifice_title() %></span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
       <td class="table-light">작성일</td>
        <td colspan=""><%=vo.getNotifice_date() %></td>
       <td class="table-light">작성 번호</td>
        <td colspan="" class="notiNo"><%=vo.getNotifice_no() %></td>
      </tr>
      <tr>
        <td class="table-light">조회수</td>
        <td colspan="3"><%=vo.getNotifice_count() %></td>
      </tr>
      <tr>
      <!-- 내용 줄바꿈 -->
      
        <td colspan="4" class="qcontent">
        <textarea rows="10" cols="100" id="contentcode" class="modi1" style="display :none;"></textarea>
        <span class="modi2"><%=vo.getNotifice_content().replace("\n", "<br>") %></span></td>
      </tr>
    </tbody>
  </table>	
  <div id="btncon">
    <input type="button" class="btn btn-light" id="modisend" value="확인" style="display : none; background-color: #ed4c78"">
  	<input type="button" class="btn btn-light" id="rev" value="목록으로 돌아가기"  style=" background-color: #ed4c78">
  	<input type="button" class="btn btn-light" id="modi" value="수정" style="display : none; background-color: #ed4c78"">
  	<input type="button" class="btn btn-light" id="del" value="삭제" style="display : none; background-color: #ed4c78" >
  </div>
  <br><br>
</div>
</main>
<footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>