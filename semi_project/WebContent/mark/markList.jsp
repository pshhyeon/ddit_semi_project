<%@page import="ddit.vo.ZzimVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script src="../js/weather.js" defer></script>
<link rel="stylesheet" href="../css/partyMainStyles.css">
<script src="../js/markList.js"></script>
<style>
    .mt-3{
       text-align: center;
    }
    
    .notiTitle {
  cursor: pointer; /* 마우스 커서를 손모양으로 변경 */
  transition: font-size 0.3s ease; /* 글씨 크기 변화 애니메이션 */
}
</style>
</head>
<body>

<script>
	myPath = "<%=request.getContextPath()%>";
    $(function() {
    	
		let user = <%=session.getAttribute("user")%>;
		console.log("user", user);
		console.log("userNO", user.user_no)
		
		// 로그인 돼있으면 마이페이지로 아니면 로그인폼으로
		$("#link-myPage").click(function(){
			if(user == null) {
				location.href = `${myPath}/user/loginForm.jsp`;
			} else {
				location.href = `${myPath}/user/myPage.jsp`;
			}
		})
		
		$.ajax({
			url : `${myPath}/markList.do`,
			data : {"userno" : user.user_no },
			type : 'post',
			success : function(res){
				console.log(res);
				code = `<table class="table table-hover">
				   <thead>
				    <tr>
				     <th>번호</th>
				     <th>모임명</th>
				     <th>관련축제</th>
				     <th>모임 생성일</th>
				    </tr>
				   </thead>
				   <tbody>`
				   
				   $.each(res, function(i,v) {
					   code += `
					   <tr>
					   <td>${i+1}</td>
					   <td id=${v.party_no} class='partyn'>${v.party_name}</td>
					   <td>${v.festival_name}</td>
					   <td>${v.party_date}</td>
					   </tr>
					   `
				   })
				   code += `</tbody>
				            </table>`
				            
				    $("#markList").html(code);       
			},
			error : function(xhr){
				alert(xhr.status);
			},
			dataType : 'json'
		});
		
		// modal_login_chk > boolean
		// modal_party_user_status > int
		// modal_party_no > int
		// modal_user_no > int
		modal_login_chk = false;
		if (user != null) {
			modal_login_chk = true;
		}
		modal_user_admin_chk = user.user_admin_chk;
		modal_party_user_status = 0; // 1 ~ 5
		modal_party_no = 0;
		modal_user_no = user.user_no;
		
		$(document).on('click', '.partyn', function() {
			modal_party_no = $(this).attr('id');
			console.log('modal_login_chk ==> ' + modal_login_chk);
			console.log('modal_party_user_status ==> ' + modal_party_user_status);
			console.log('modal_party_no ==> ' + modal_party_no);
			console.log('modal_user_no ==> ' + modal_user_no);
// 			getPartyDetail(modal_party_no);
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
		
		
		$('#partyInfoModal').on('hidden.bs.modal', function (e) {
			location.reload();
		});
		
	});// /$(function)
</script>
</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>
<!-- 여기 작성 -->
 
<div class="container mt-3"> 
<h2>찜 리스트</h2>
<br><br>
<div id="markList">
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
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>