<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page isELIgnored="true" %>
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
    <script src="../js/jquery-3.7.1.min.js"></script>
    <!-- 머테리얼 아이콘 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- 스타일 -->
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/partyMainStyles.css" />
    <script type="text/javascript">
    const myPath = '<%=request.getContextPath()%>';
    </script>
    <!-- 주소 js -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <!-- 날씨 스크립트 -->
    <script src="../js/weather.js" defer></script>
    
    <!-- ================이채민======================= -->
    <script src="../js/markList.js"></script>
    <!-- ================이채민======================= -->
    
<script>

let user = <%=session.getAttribute("user")%>;
$(function() {
	let partyList = "";
	let festivalList = "";
	let partyUserList = "";
	let memberCnt = "";
	
	$(".nameSpan").text(user.user_name);	
	
	const h1 = document.querySelector(".h1-name");
	
	// 검색 버튼 찾아옴
  	// 우편번호 검색창 생성하는 함수, daum.Postcode클래스 사용
  	const daumPostcode = new daum.Postcode({
		// 검색 창에서 특정 주소를 선택했을 때 발생하는 이벤트
    	oncomplete: function (data) {
			// 받아온 data객체에서 필요한 값을 가져옴
	        const address = data.address;
//	        const zonecode = data.zonecode;

   	    	// html요소에 값을 담아줌 input이니까 value로
        	document.getElementById("address").value = address;
//        	document.getElementById("postcode").value = zonecode;
    	},
 	});

  	// 버튼 클릭시 위에서 생성한 우편번호 검색창을 오픈
	$(document).on('click',"#postcode_search_button", function() {
		daumPostcode.open();
	})
	
	// 로드시 환영??메세지
	$(() => {
        $(h1).css("top", "0");
        $(h1).css("transform", "scale(1)");
        $(h1).css("opacity", "1");
      });
	
	$('#logout').on('click', function() {
		location.href = `<%=request.getContextPath()%>/logout.do`
	})
	
	// 정보수정 - 취소버튼 눌렀을 때
	$(document).on('click','#cancel',function() {
		$("#input-pass").val("");
		$("#modify").toggleClass("d-none");
		$("#addFestivalForm").hide();
		scrollTo(0, 0);
	})
	
	// 정보수정 - 탈퇴
	$(document).on('click','#secede',function() {
		let prom = prompt("탈퇴하려면 비밀번호를 입력해주세요.")
		
		if(prom == user.user_pass) {
			
			for(i = 0; i < partyList.length; i++) {
				if(user.user_no == partyList[i].user_no) {
					alert("모임장은 탈퇴할 수 없습니다.");
					return;
				}
			}
			
			$.ajax({
				url : `${myPath}/resignUser.do`
				, type : "GET"
				, data : {"userNo" : user.user_no}
				, success : function(res) {
					alert("탈퇴 성공. 메인페이지로 이동합니다.")
					location.href = `${myPath}/index.jsp`;
				}
			})
			
		} else {
			alert("비밀번호가 틀렸습니다.")
		}
		
	})
	
	// 사이트 접속하면 소모임 리스트 받아오기
		$.ajax({
			url : `${myPath}/partyList.do`
			, type : "GET"
			, success : function(res) {
				partyList = res;
			}
			, dataType : "JSON"
		})
		
		// 축제명때문에 축제 리스트
		$.ajax({
			url : `${myPath}/festivalList.do`
			, type : "GET"
			, success : function(res) {
				festivalList = res;
			}
			, dataType : "JSON"
		})
	
		$.ajax({
			url : `${myPath}/countPartyUserFromPartyNo.do`
			, type : "GET"
			, success : function(res) {
				memberCnt = res;
			}
			, dataType : "JSON"
		})
	
	$(document).on('click',"#btn-passChk",function() {
		$("#modify").toggleClass("d-none");
		
		if($("#input-pass").val() == user.user_pass) {
			
			let htmlCode = 
				`
				
				<form id="addFestivalForm" method="POST" action="${myPath}/userModify.do" enctype="multipart/form-data" class="mt-3 mb-3" style="width : 50%">
				<div class="mb-2 mt-2">
			      <label for="id">아이디:</label>
			      <div class="d-flex flex-row">
				      <input type="text" class="form-control" id="id" name="user_id" value="${user.user_id}" Readonly>
				      <input type="text" class="form-control d-none" id="user_no" value="${user.user_no}" name="user_no" Readonly>
			      </div>
			    </div>
			    <div class="mb-2 mt-2">
			      <label for="pass">비밀번호:</label>
			      <input type="password" class="form-control" id="pass" name="user_pass" required>
			    </div>
			    
			    <div class="mb-2 mt-2">
			      <label for="passChk">비밀번호 확인:</label>
			      <input type="password" class="form-control" id="passChk" name="user_passChk" required>
			    </div>
			  
			    <div class="mb-2 mt-2">
			      <label for="name">이름:</label>
			      <input type="text" class="form-control" id="name" name="user_name"  value="${user.user_name}" required>
			    </div>
			  
			    <div class="mb-2 mt-2">
			      <label for="nickname">닉네임:</label>
			       <div class="d-flex flex-row">
				      <input type="text" class="form-control" id="nickname" name="user_nickname"  value="${user.user_nickname}" required>
				      <button type="button" id="nicknameCheckBut" class="btn btn-outline-primary btn-sm">중복검사</button>
			      </div>
			      <span id="checkNickname"></span> <!-- 사용 가능/불가능 -->
			    </div>
			  
			    <div class="mb-2 mt-2">
			      <label for="hp">전화번호:</label>
			      <input type="text" class="form-control" id="hp" name="user_hp"  value="${user.user_hp}" required>
			    </div>
			  
			    <div class="mb-2 mt-2">
			      <label for="email">이메일:</label>
			      <input type="email" class="form-control" id="email" name="user_mail"  value="${user.user_mail}" required>
			    </div>

			    <div class="mb-2 mt-2">
			      <label for="bir">생년월일:</label>
			      <input type="date" class="form-control" id="bir" name="user_bir"  value="${user.user_bir.substr(0,10)}" required>
			    </div>
			    
			    <div class="mb-2 mt-2">
			      <label for="inst">자기소개:</label>
			      <input type="text" class="form-control" id="inst" name="user_in"  value="${user.user_in == null ? "" : user.user_in}">
			    </div>
			    
			   <div class="mb-2 mt-2" id="postcode_search">
			   	    <label for="id">우편번호:</label>
		      		<div class="d-flex flex-row">
		      			<input type="text" class="form-control" id="address" placeholder="주소" name="user_addr" readonly value="${user.user_addr}" required/>
		      			<button type="button" class="btn btn-outline-primary btn-sm" id="postcode_search_button">주소검색</button>
		      		</div>
		<!--       		<input type="text" class="form-control" id="postcode" placeholder="우편 번호" readonly /> -->
		      		<div id="postcode_list"></div>
		    	</div>
		    	
		    	<div class="mb-2 mt-2">
			      <label for="psa">프로필사진:</label>
			      <input type="file" class="form-control" id="psa" name="user_profile_name"  value="${user.user_profile_name == null ? "" : user.user_profile_name}">
			    </div>
			  
			
			<button type="button" id="cancel" class="btn btn-outline-danger btn-lg">취소</button>
			<button type="submit" id="submitBtn"class="btn btn-outline-danger btn-lg">수정</button>
			<button type="button" id="secede" class="btn btn-outline-danger btn-lg">탈퇴</button>
	  </form>
				`
			
				
				
				
			$("#addFestivalForm").show();
			$("#updateForm").html(htmlCode);
			// 이거 갈아껴 줄거임
			
			//모두 차있으면~
			$('#submitBtn').prop('disabled', true);	
// 			$('input').on('input',function(){
// 				allFieldsFilled = true;
// 			    $('input[required]').each(function() {
// 			        if ($(this).val() === '') {
// 			            allFieldsFilled = false;
// 			            return false; // 하나의 필드라도 비어있다면 반복문을 종료
// 			        }
// 			    });
			    
// 			    if (allFieldsFilled) {
// 			        $('#submitBtn').prop('disabled', false);
// 			    } else {
// 			        $('#submitBtn').prop('disabled', true);
// 			    }
// 			})
			
			
		} else {
			$("#modify").toggleClass("d-none");
			alert("비밀번호를 다시 확인해주세요.");
		}
	})
	
	// 유효성체크 ---------------------------------------------------------------------------------------------
	
	// 이름 데이터 형식 체크
	$(document).on('keyup','#name',function() {
		// 입력한 이름
		nameValue = $(this).val().trim();
		nameReg = /^[가-힣]{2,10}$/; // 2자리 ~ 10자리
		
		if (nameReg.test(nameValue)) {
			$(this).css('border', '2px solid blue');
		} else {
			$(this).css('border', '2px solid red');
		}
		
	})
	
	// 전화번호 데이터 형식 체크 - hpValue
		$(document).on('keyup','#hp',function() {
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
	    
	});
	
	// 비밀번호 데이터 형식 체크 - passValue
	$(document).on('keyup','#pass',function() {
	    passValue = $(this).val().trim();
	    passReg = /^(?=.*[a-zA-Z0-9!@#$%^&*()_+\\[\];:\\,./<>?`~|-]).{8,}$/; // ',",{,}를 제외한 특수문자, 영문대소문자, 숫자 포함 8자리 이상
	    
	    if (passReg.test(passValue)) {
	        $(this).css('border', '2px solid blue');
	    } else {
	        $(this).css('border', '2px solid red');
	    }
	});
	
	
	
	
	$(document).on('keyup','#passChk',function() {
		
		passOkValue = $(this).val().trim();
		if(passOkValue == passValue){
	        $(this).css('border', '2px solid blue');
		} else {
	        $(this).css('border', '2px solid red');
	        
	        
		}
		if((passOkValue == passValue) && (passReg.test(passValue))){
		        $('#submitBtn').prop('disabled', false);
		}
		
	});
	
	
	
	
	
	
	// 이메일 데이터 형식 체크 - mailValue
	$(document).on('keyup','#email',function() {
	    mailValue = $(this).val().trim();
	    mailReg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/; 
	    // 영문 대소문자, 숫자, 밑줄(_), 점(.), 하이픈(-)을 포함 한번이상 사용 @
	    // 영문 대소문자, 숫자, 점(.), 하이픈(-)을 포함 한번이상 사용
	    if (mailReg.test(mailValue)) {
	        $(this).css('border', '2px solid blue');
	    } else {
	        $(this).css('border', '2px solid red');
	    }
	});

	$(document).on('click','#nicknameCheckBut',function() {
		nicknameValue = $('#nickname').val().trim();
		$.ajax({
			url : `${myPath}/chkNicknameDuplication.do`,
			type : "get",
			data : { "nickname" : nicknameValue },
			success : res => {
				if(res.flag == 'false'){
					$('#checkNickname').text('사용 가능').css('color', 'blue');
				} else {
					$('#checkNickname').text('사용 불가능').css('color', 'red');
				}
			},
			error : xhr => {
				alert("상태 : " + xhr.status)
			},
			dataType : 'json'
		});
	})
	// 유효성체크 ---------------------------------------------------------------------------------------------
	
	
	$("#status").click(function() {
		$.ajax({
			url : `${myPath}/selectPartyUser.do`,
			type : "get",
			data : { "userNo" : user.user_no },
			success : res => {
				partyUserList = res;
				console.log(partyUserList);
				
				let htmlCode = 
					`
						<table class="table">
			    <thead>
			      <tr>
			        <th>번호</th>
			        <th>모임명</th>
			        <th>관련축제</th>
			        <th>가입현황</th>
			      </tr>
			    </thead>
					`;
						
					for(i = 0; i < partyUserList.length; i++) {
						if(partyUserList[i].user_no == user.user_no) {
							
							let curFesName = "";
							for(j = 0; j < partyList.length; j++) {
								if(partyUserList[i].party_no == partyList[j].party_no) {
									
									for(k = 0; k < festivalList.length; k++)
										if(partyList[j].festival_no == festivalList[k].festival_no)
										curFesName = festivalList[k].festival_name;
								}
							}
							
							htmlCode += 
								`
						    <tbody>
						      <tr>
						        <td>${partyUserList[i].party_no}</td>
						        <td id=${partyUserList[i].party_no} class='partyn'>${partyList[partyUserList[i].party_no - 1].party_name}</td>
						        <td>${curFesName}</td>`;
						        
						        if(partyUserList[i].party_user_delyn == 1) {
						        	htmlCode += `<td>가입대기</td>`
						        } else if(partyUserList[i].party_user_delyn == 2) {
							        	htmlCode += `<td>가입중</td>`
						        } else if(partyUserList[i].party_user_delyn == 3) {
							        	htmlCode += `<td>회원 탈퇴</td>`
								} else if(partyUserList[i].party_user_delyn == 4) {
							        	htmlCode += `<td>회원 강퇴</td>`
								}
						        
						        htmlCode += `</tr>
								    </tbody>`;
						}
					
						}
					htmlCode += `</table>`;
					$("#div-table").html(htmlCode);
			},
			dataType : 'json'
		})
	})
	
	
	$("#myParty").click(function() {
		
		console.log(memberCnt);
		
		$.ajax({
			url : `${myPath}/selectPartyUser.do`,
			type : "get",
			data : { "userNo" : user.user_no },
			success : res => {
				partyUserList = res;
				console.log("ㅋㅋ",partyUserList);
				
				let htmlCode = 
					`
						<table class="table">
			    <thead>
			      <tr>
			        <th>번호</th>
			        <th>모임명</th>
			        <th>관련축제</th>
			        <th>모집인원</th>
			        <th>모집현황</th>
			        <th>권한</th>
			      </tr>
			    </thead>
					`;
						
					for(i = 0; i < partyUserList.length; i++) {
						
						if(partyUserList[i].user_no == user.user_no) {
							
							if(partyUserList[i].party_user_delyn != 1) {
								let curPartyMemberCnt = memberCnt[partyUserList[i].party_no];
								console.log(partyUserList[i].party_no);
								
								let partyStatus = "모집마감";
								
								if(partyList[partyUserList[i].party_no-1].party_delyn == "N") {
									partyStatus = "모집중"
								}
								
								let curFesNum = partyList[partyUserList[i].party_no - 1].festival_no;
								
								let curFesName = "";
								
								for(j = 0; j < partyList.length; j++) {
									if(partyUserList[i].party_no == partyList[j].party_no) {
										
										for(k = 0; k < festivalList.length; k++)
											if(partyList[j].festival_no == festivalList[k].festival_no)
											curFesName = festivalList[k].festival_name;
									}
								}
								let auth = "회원";
								
								if(partyList[partyUserList[i].party_no - 1].user_no == user.user_no) {
									auth = "모임장";
								}
								
								htmlCode += 
									`
							    <tbody>
							      <tr>
							        <td>${partyUserList[i].party_no}</td>
							        <td id=${partyUserList[i].party_no} class='partyn'>${partyList[partyUserList[i].party_no - 1].party_name}</td>
							        <td>${curFesName}</td>
							        <td>${partyList[partyUserList[i].party_no - 1].party_percount}</td>
							        <td>${partyStatus}</td>
							        <td>${auth}</td>
							      </tr>
								</tbody>`;
							} 
						}
					}
				
					htmlCode += `</table>`;
					
				$("#div-table").html(htmlCode);
			},
			dataType : 'json'
		})
	})
	
	
	// -------------------------------- 이채민---------------------------------------
	
	
	console.log("user", user);
	console.log("userNO", user.user_no);
	
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
//			getPartyDetail(modal_party_no);
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
	
	
	// -------------------------------이채민--------------------------
	
	
})
function getMarkList(){
	
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
}
	
</script>

<style>
      .h1-name {
        position: relative;
        top: 300px;
        transform: scale(5);
        transition: 500ms;
        opacity: 0;
      }

      .nameSpan {
      	color : #5b4dff;
      }
      
      .nav-item{
     	width: 33.3%;
      }
      
      #updateForm {
      	display: flex;
      	justify-content: center;
      }

		.partyBtn {
			width: 44%;
			height : 50px;
		}
		
    </style>

</head>
<body data-mypath="<%=request.getContextPath()%>">

<header>
	<jsp:include page="/jsp/nav.jsp"/>
</header>

	<main>
		<div class="container mt-3 text-center inner">
			<div class="myPage-box">
				<h1 class="mt-4 h1-name">
					<span class="nameSpan"></span>님의 마이페이지 입니다.
				</h1>
				<button id="logout" class="btn btn-outline-danger mt-3">로그아웃</button>
				<div class="mt-4">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link"
							data-bs-toggle="tab" href="#home">정보수정</a></li>
						<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
							href="#menu1">찜한 모임 목록</a></li>
						<li class="nav-item"><a class="nav-link active" data-bs-toggle="tab"
							href="#menu2">모임 현황</a></li>
					</ul>

					<!-- Tab panes -->
					<div class="tab-content">
						<div
							class="tab-pane container fade"
							id="home">
							<div id="modify" class="d-flex flex-column justify-content-center align-items-center">
							<div style="height: 20px"></div>
							<div style="height: 20px"></div>
							<label for="input-pass">정보를 수정하려면 비밀번호를 입력해주세요.</label>
							<div style="height: 20px"></div>
							<input type="password" style="width: 33%;" class="form-control"
								id="input-pass" name="festival_tel">
							<div style="height: 20px"></div>
							<button class="btn btn-primary" id="btn-passChk">완료</button>
							<div style="height: 20px"></div>
							</div>
							<div id="updateForm"></div>
						</div>
						<div class="tab-pane container fade" id="menu1">
							
						<!--============================= 이채민 =================================-->	
						<div class="container mt-3"> 
                         <h2>찜 리스트</h2>
                         <br><br>
                         <div id="markList">
                         </div>
                        </div>

                       <!-- index 소모임 모달 -->
                       <!-- The Modal -->
                       <div class="modal" id="partyInfoModal">
                        <div class="modal-dialog modal-dialog-centered">
                         <div id="party-detail-modal" class="modal-content">
                         </div>
                        </div>
                       </div>	
				       <!--============================= 이채민 =================================-->		
							
							
						</div>
						<div class="tab-pane container active" id="menu2">
							<div class="d-flex justify-content-around align-items-center" style="height : 150px;">
								<button class="btn btn-primary partyBtn" id="status">가입현황</button>
								<button class="btn btn-primary partyBtn" id="myParty">my소모임</button>
								
							</div>
							<div id="div-table">
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<footer>
	<jsp:include page="/jsp/footer.jsp"/>
</footer>


</body>
</html>