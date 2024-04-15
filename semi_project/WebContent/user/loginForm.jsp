<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page isELIgnored="true"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="../js/jquery-3.7.1.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script src="../js/weather.js.js" defer></script>

<script>
    $(function() {
		let myPath = "<%=request.getContextPath()%>"
		let user = <%=session.getAttribute("user")%>;
		console.log(user);
		
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
	})
</script>

<style>
label{
  display : inline-block;
  width : 80px;
  height : 30px;
}

main {
	height : 700px;
}

main > div {
	margin : 0 auto;
}
</style>
<script>
 mypath =  '<%= request.getContextPath()%>';
 console.log(mypath);
 
 $(function(){
	
	$('#login').on('click', function(){
		// 입력한 id와 pass를 가져온다.
		idValue = $('#id').val().trim();
		passValue = $('#pass').val().trim();
		$.ajax({
			url : `${mypath}/userLogin.do`,
			type : 'post',
			data : { 'id' : idValue, 'pass' : passValue },
			success : function(result) {
				if(result == null) {
					alert("아이디 혹은 비밀번호를 틀렸음");
				} else {
					if(result.user_delyn == "Y") {
						alert("탈퇴된 회원입니다.");
						return;
					}
					
					if(result.user_admin_chk == "Y") {
						alert("ADMIN으로 로그인합니다.");	
					} else {
						alert(result.user_id + "로 로그인합니다.");	
					}
					
					location.href = `${mypath}/index.jsp`;
				}
			},
			error : function(xhr) {
				alert('상태 : ' + xhr.status);
			}
			, dataType : 'json'
		}) // ajax()
		
	}) // /onclick()
	
	// 로그아웃
/* 	$('#logout').on('click', function(){
		$.ajax({
			url : `${mypath}/userLogout.do`,
			type : 'get',
			success : function(result) {
				//location.href = `${mypath}/start/index.jsp`;
			},
			error : function(xhr) {
				alert('상태 : ' + xhr.status);
			},
			dataType : 'html'
		}) // ajax()
		
	}) // /onclick() */
	
	//비밀번호찾기 클릭
	$('#findpass').on('click',function(){
		$('#pModal').modal('show');
	})

	//비밀번호찾기 창 안에서 확인 누르면
	$(document).on('click','#psend',function(){
		findPassId = $('#writer').val().trim();
		findPassMail = $('#mail').val().trim();
		$.ajax({
			url : `${mypath}/chkIdMail.do`,
			type : 'post',
			data : { "id" : findPassId , "email" : findPassMail },
			
			success : function(result){
				if(result.flag == "true"){
					sendMail(findPassId, findPassMail);
					$('#pform .txt').val("");
					$('#pModal').modal('hide');
				}else{
					alert("아이디 및 이메일이 일치하지 않습니다.");
				}
			},
			error : function(xhr){
				alert("상태상태 : "+xhr.status);
			},
			dataType : 'json'
		})	
	})
	//비밀번호 찾기 이메일 보내는 메소드
	sendMail = function(findPassId, findPassMail){
		console.log(findPassId, findPassMail);
		$.ajax({
			url : `${mypath}/findUserPass.do`,
			type : 'post',
			data : { "id" : findPassId , "email": findPassMail },
			success : function(result){
				if(result.flag == "true"){
					alert("회원님의 비밀번호가 이메일로 발송되었습니다.");
					
				}else{
					alert("비밀번호 이메일 발송 실패!!");
				}
					
			},
			error : function(xhr){
				alert("상태 : "+xhr.status);
			},
			dataType : 'json'
			
		})
	}
	
	/* 아이디 찾기 */
	$('#findid').on('click', function(){
		$('#findIdModal').modal('show');
	})
	
	$('#go').on('click', function(){
		let nameVal = $("#user_name").val().trim();
		let mailVal = $("#user_mail").val().trim();
		
		let sendData = 
			{
				"username" : nameVal,
				"usermail" : mailVal
			}
		
		$.ajax({
			url : "<%=request.getContextPath()%>/findId.do",
			type : 'get',
			data : sendData,
			success : function(res){
				if (res.flag == "") {
					alert("존재하지 않는 회원입니다.")
				} else {
					var modifiedId = res.flag.substring(0, res.flag.length - 2) + "***";
					alert(modifiedId);
				}
			},
			error : function(xhr){
				alert("오류" + xhr.status);
			},
			dataType : 'json'
		})
	})
	$('#userRegister').on('click', function() {
		location.href = `${mypath}/user/register.jsp`;
	})
	
 }) // /$(function()
 
 </script>
</head>
<body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
	<main class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">로그인</h3>
          </div>
          <div class="card-body">
            <form>
              <div class="mb-3">
                <label for="id" class="form-label">ID</label>
                <input type="text" class="form-control" id="id" name="id">
              </div>
              <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="pass" name="pass">
              </div>
              <!-- <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="remember-me">
                <label for="remember-me" class="form-check-label">로그인 기억하기</label>
              </div> -->
              <div class="div-btnGroup">
              	<button type="button" id="findid" class="btn btn-info">id찾기</button>
              	<button type="button" id="findpass" class="btn btn-success">비밀번호 찾기</button>
              	<button type="button" id="userRegister" class="btn btn-secondary">회원가입</button>
              	<button type="button" id="login" class="btn btn-primary">로그인</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </main>
  
  <!--  비번찾기 MODAL-->
<div class="modal" id="pModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">비밀번호 찾기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <form name ="pform" id="pform">
       		<label>ID : </label>
       		<input type="text" class="txt" id="writer" name ="writer"><br>
       		<label>메 일 : </label>
       		<input type="text" class="txt" id="mail" name ="mail"><br>
       		<br>
       		<input type="button" id="psend" value ="확인">
        </form>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
  
  <!--  아이디 찾기 MODAL-->
<div class="modal" id="findIdModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">아이디 찾기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <form name ="findIdform" id="findIdform">
       		<label>이름 : </label>
       		<input type="text" class="txt" id="user_name" name="user_name" required="required">
       		<br>
       		<label>메 일 : </label>
       		<input type="email" class="txt" id="user_mail" name="user_mail" required="required">
       		<br>
       		<br>
       		<input type="button" value="입력" id="go" name="입력">
        </form>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
  
  <footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
  
</body>
</html>