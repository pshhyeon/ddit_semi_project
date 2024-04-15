<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bootstrap sign up</title>
<!-- 제이쿼리 -->
<script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<script src="/semi_project/js/jquery.serializejson.min.js"></script>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- 머테리얼 아이콘 -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<!-- 스타일 -->
<link rel="stylesheet" href="../css/styles.css" />

<!-- 우편번호 api js -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/semi_project/js/addrSearch.js"></script>

<style>
input[type=text], input[type=password], input[type=date]{
	width: 350px;
}

#add1, #add2{
	width: 550px;
}
</style>

<script>
const myPath = '<%=request.getContextPath()%>';
$(() => {
	let user = <%=session.getAttribute("user")%>;
	let idCheckResult = false;
	let nicknameCheckResult =false;
	
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
	
	checkInput = function(){
		// 아이디 입력 체크
        let idValid = idReg.test(idValue);
        // 비밀번호 입력 체크
        let passValid = passReg.test(passValue);
        // 비밀번호 확인 체크
        let passChkValid = passOkValue === passValue;
        // 이름 입력 체크
        let nameValid = nameReg.test(nameValue);
        // 전화번호 입력 체크
        let hpValid = phoneReg.test(hpValue);
        // 이메일 입력 체크
        let emailValid = mailReg.test(mailValue);
        // 아이디 중복검사 했는지 여부
        
        // 닉네임 중복검사 했는지 여부

        // 모든 필수 입력 필드가 유효한지 확인
        let allFieldsValid = idValid && passValid && passChkValid && nameValid && hpValid && emailValid && idCheckResult && nicknameCheckResult;

        // 가입 버튼 상태 업데이트
        $('#join').prop('disabled', !allFieldsValid);
		
	}
	
	$('#join').prop('disabled', true);
	// 이름 데이터 형식 체크
	$('#name').on('keyup', function() {
		// 입력한 이름
		nameValue = $(this).val().trim();
		nameReg = /^[가-힣]{2,10}$/; // 2자리 ~ 10자리
		
		if (nameReg.test(nameValue)) {
			$(this).css('border', '2px solid blue');
		} else {
			$(this).css('border', '2px solid red');
		}
		checkInput();
		
	});
	
	// 전화번호 데이터 형식 체크 - hpValue
	$('#hp').on('keyup', function() {
		hpValue = $(this).val().trim();
	    phoneReg = /^\d{3}-\d{3,4}-\d{4}$/; // 3자리, 3or4자리, 4자리
	    
	    if (phoneReg.test(hpValue)) {
	        $(this).css('border', '2px solid blue');
	    } else {
	        $(this).css('border', '2px solid red');
	    }
	   
	    if (hpValue.length == 3) {
	        $(this).val(hpValue + "-");
	    }
	    
	    if (hpValue.length == 8) {
	        $(this).val(hpValue + "-");
	    }
	    checkInput();
	    
	});
	
	// 비밀번호 데이터 형식 체크 - passValue
	$('#pass').on('keyup', function() {
	    passValue = $(this).val().trim();
	    passReg = /^(?=.*[a-zA-Z0-9!@#$%^&*()_+\\[\];:\\,./<>?`~|-]).{8,}$/; // ',",{,}를 제외한 특수문자, 영문대소문자, 숫자 포함 8자리 이상
	    
	    if (passReg.test(passValue)) {
	        $(this).css('border', '2px solid blue');
	    } else {
	        $(this).css('border', '2px solid red');
	    }
	    checkInput();
	});
	
	$('#passChk').on('keyup', function() {
		passOkValue = $(this).val().trim();
		if(passOkValue == passValue){
	        $(this).css('border', '2px solid blue');
		} else {
	        $(this).css('border', '2px solid red');
		}
		checkInput();
	});
	
	// 이메일 데이터 형식 체크 - mailValue
	$('#email').on('keyup', function() {
	    mailValue = $(this).val().trim();
	    mailReg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/; 
	    // 영문 대소문자, 숫자, 밑줄(_), 점(.), 하이픈(-)을 포함 한번이상 사용 @
	    // 영문 대소문자, 숫자, 점(.), 하이픈(-)을 포함 한번이상 사용
	    if (mailReg.test(mailValue)) {
	        $(this).css('border', '2px solid blue');
	    } else {
	        $(this).css('border', '2px solid red');
	    }
	    checkInput();
	});
	
	// 전송하기 - 이벤트
	$('#join').on('click', function() {
		fdata = $('#registerForm').serialize();
		console.log(fdata);
		
		$.ajax({
			url : `${myPath}/userRegister.do`,
			type : 'post',
			data : fdata,
			success : res => {
				if (res.flag == "true") {
					alert("회원가입이 완료되었습니다");
					location.href = `${myPath}/index.jsp`;
				}
			},
			error : xhr => {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		})
		
	})
	
	// 아이디 입력 - 정규식 체크 - 데이터형식 >> 중복검사 버튼 활성화
	$('#id').on('keyup', function() {
		idValue = $(this).val().trim();
		// 영문자로 시작, 4~10자리
		idReg = /^[a-zA-Z][a-zA-Z0-9]{3,9}$/
		
		if (idReg.test(idValue)) { // idgreg와 idValue비교 후 bool반환
			// 중복검사 버튼을 사용가능 하도록 활성화
			$(this).css('border', '2px solid blue');
			$('#idcheckBut').prop('disabled', false);
		} else {
			$(this).css('border', '2px solid red');
			// 중복검사 버튼을 사용불가능하도록 비활성화
			$('#idcheckBut').prop('disabled', true);
		}
		
		
	});
	
	// id 중복검사
	$('#idcheckBut').on('click', () => {
		$.ajax({
			url : `${myPath}/chkIdDuplication.do`,
			type : "get",
			data : { "id" : idValue },
			success : res => {
// 				alert("성공")
				if(res.flag == 'false'){
					$('#checkId').text('사용 가능').css('color', 'blue');
					idCheckResult =true;
				} else {
					$('#checkId').text('사용 불가능').css('color', 'red');
					idCheckResult =false;
				}
				checkInput();
			},
			error : xhr => {
				alert("상태 : " + xhr.status)
			},
			dataType : 'json'
		});
		
		
	}); // /click
	
	// id 중복검사
	$('#nicknameCheckBut').on('click', () => {
		nicknameValue = $('#nickname').val().trim();
		$.ajax({
			url : `${myPath}/chkNicknameDuplication.do`,
			type : "get",
			data : { "nickname" : nicknameValue },
			success : res => {
				if(res.flag == 'false'){
					$('#checkNickname').text('사용 가능').css('color', 'blue');
					nicknameCheckResult = true;
				} else {
					$('#checkNickname').text('사용 불가능').css('color', 'red');
					nicknameCheckResult = false;
				}
				checkInput();
			},
			error : xhr => {
				alert("상태 : " + xhr.status)
			},
			dataType : 'json'
		});
	}); // /click
	

	
	
});

</script>

</head>
<body>

<header>
	<jsp:include page="/jsp/nav.jsp"/>
</header>

	<div class="container mt-3 d-flex flex-column justify-content-around align-items-center mb-3">
	  <h2>sign up</h2>
	  <form id="registerForm">
	  
	    <div class="mb-2 mt-2">
	      <label for="id">아이디:</label>
	      <div class="d-flex flex-row">
		      <input type="text" class="form-control" id="id" name="user_id">
		      <button type="button" disabled="disabled" id="idcheckBut" class="btn btn-outline-primary btn-sm">중복검사</button>
	      </div>
	      <span id="checkId"></span> <!-- 사용 가능/불가능 -->
	    </div>
	    
	    <div class="mb-2 mt-2">
	      <label for="pass">비밀번호:</label>
	      <input type="password" class="form-control" id="pass" name="user_pass">
	    </div>
	    
	    <div class="mb-2 mt-2">
	      <label for="passChk">비밀번호 확인:</label>
	      <input type="password" class="form-control" id="passChk" name="user_passChk">
	    </div>
	  
	    <div class="mb-2 mt-2">
	      <label for="name">이름:</label>
	      <input type="text" class="form-control" id="name" name="user_name">
	    </div>
	  
	    <div class="mb-2 mt-2">
	      <label for="nickname">닉네임:</label>
	       <div class="d-flex flex-row">
		      <input type="text" class="form-control" id="nickname" name="user_nickname">
		      <button type="button" id="nicknameCheckBut" class="btn btn-outline-primary btn-sm">중복검사</button>
	      </div>
	      <span id="checkNickname"></span> <!-- 사용 가능/불가능 -->
	    </div>
	  
	    <div class="mb-2 mt-2">
	      <label for="hp">전화번호:</label>
	      <input type="text" class="form-control" id="hp" name="user_hp">
	    </div>
	  
	    <div class="mb-2 mt-2">
	      <label for="email">이메일:</label>
	      <input type="email" class="form-control" id="email" name="user_mail">
	    </div>

	    <div class="mb-2 mt-2">
	      <label for="bir">생년월일:</label>
	      <input type="date" class="form-control" id="bir" name="user_bir">
	    </div>
	    
	   <div class="mb-2 mt-2" id="postcode_search">
	   	    <label for="id">우편번호:</label>
      		<div class="d-flex flex-row">
      			<input type="text" class="form-control" id="address" placeholder="주소" name="user_addr" readonly />
      			<button type="button" class="btn btn-outline-primary btn-sm" id="postcode_search_button">주소검색</button>
      		</div>
<!--       		<input type="text" class="form-control" id="postcode" placeholder="우편 번호" readonly /> -->
      		<div id="postcode_list"></div>
    	</div>




	    <button type="button" id=join class="btn btn-outline-success btn-lg">가입하기</button> <br>
	  </form>
	  <!-- <form> -->
	</div>
	<!-- <div class="container mt-3"> -->
		<footer>
	<jsp:include page="/jsp/footer.jsp"/>
</footer>
</body>


<!-- date오늘 이후 선택 불가 스크립트 -->
<script>
	document.addEventListener("DOMContentLoaded", function() {
	    var today = new Date().toISOString().split('T')[0]; // 오늘 날짜를 ISO 형식(YYYY-MM-DD)으로 가져옴
	    document.getElementById("bir").max = today; // 오늘 날짜를 max 속성에 설정
	});
</script>

</html>