<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!-- 제이쿼리 -->
    <script src="../js/jquery-3.7.1.min.js"></script>
	<!-- 부트스트랩 -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- 머테리얼 아이콘 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- 스타일 -->
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/partyMainStyles.css" />
    <!-- 날씨 스크립트 -->
    <script src="../js/weather.js" defer></script>
    
    
    <script type="text/javascript">
    const myPath = '<%=request.getContextPath()%>';
    </script>
    
    <script src="../js/markList.js"></script>
    
<script>
$(function() {
	let user = <%=session.getAttribute("user")%>;
	let myPath = '<%=request.getContextPath()%>';
	let partyList = "";
	let festivalList = "";
	let partyUserList = "";
	let memberCnt = "";
	let userList = "";
	let userReportList = "";
	let partyReportList = "";
	
	$(".nameSpan").text(user.user_name);	
	
	const h1 = document.querySelector(".h1-name");
	
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
	
	// 로드시 환영??메세지
	$(() => {
        $(h1).css("top", "0");
        $(h1).css("transform", "scale(1)");
        $(h1).css("opacity", "1");
      });
	
	$('#logout').on('click', function() {
		location.href = `<%=request.getContextPath()%>/logout.do`
	})
	
	// 축제 리스트
		$.ajax({
			url : `${myPath}/festivalList.do`
			, type : "GET"
			, async : false
			, success : function(res) {
				festivalList = res;
			}
			, dataType : "JSON"
		})
		
		// 멤버 인원수 배열로 가져오기
		$.ajax({
			url : `${myPath}/countPartyUserFromPartyNo.do`
			, type : "GET"
			, async : false
			, success : function(res) {
				memberCnt = res;
			}
			, dataType : "JSON"
		})
		
		$.ajax({
			url : `${myPath}/selectUserReport.do`
			, type : "GET"
			, async : false
			, success : function(res) {
				userReportList = res;
				console.log(userReportList);
			}
			, dataType : "JSON"
		})
		
		$.ajax({
			url : `${myPath}/selectAllPartyReport.do`
			, type : "GET"
			, async : false
			, success : function(res) {
				partyReportList = res;
				console.log(partyReportList);
			}
			, dataType : "JSON"
		})
		
		
		
		
	
	// 사이트 접속하면 소모임 리스트 받아오기
		$.ajax({
			url : `${myPath}/partyList.do`
			, type : "GET"
			, success : function(res) {
				partyList = res;
				console.log(partyList);
				
				let htmlCode = 
					`
				<table class="table">
			    <thead>
			      <tr>
			        <th>번호</th>
			        <th>모임명</th>
			        <th>인원</th>
			        <th>상태</th>
			        <th>신고여부</th>
			        <th>경고부여</th>
			      </tr>
			    </thead>
					`;
					
					
					
					for(i = 0; i < partyList.length; i++) {
						
						let delynStr = "모집중";
						if(partyList[i].party_delyn == "Y") delynStr = "모집마감";
						
						htmlCode +=
							`
							<tbody>
							<tr>
							<td class="partyNo">${partyList[i].party_no}</td>
							<td id=${partyList[i].party_no} class='partyn'>${partyList[i].party_name}</td>
							<td>${memberCnt[i]} / ${partyList[i].party_percount}</td>
							<td>${delynStr}</td>`
							
							
							
							for(j = 0; j < partyReportList.length; j++) {
								
								if(partyReportList[j].party_check_yn == "N" && partyReportList[j].party_no == partyList[i].party_no) {
									
									htmlCode += `<td><span class="material-symbols-outlined">
										check
										</span></td>
										<td><button id="btn-partyReport" class="btn btn-danger">경고부여</button></td>
										`;
										break;
								}
							}
					}
				
					htmlCode += `</tr>
						</tbody></table>`;
					
				$("#party-table").html(htmlCode);
			}
			, dataType : "JSON"
		})
		
		// 유저 리스트 뽑기
		$.ajax({
		url : `${myPath}/selectAllUser.do`
		, type : "GET"
		, success : function(res) {
			userList = res;
			console.log(userList);
			
			let htmlCode = 
				`
					<table class="table">
		    <thead>
		      <tr>
		        <th>번호</th>
		        <th>아이디</th>
		        <th>이름</th>
		        <th>닉네임</th>
		        <th>생년월일</th>
		        <th>회원상태</th>
		        <th>신고여부</th>
		        <th>경고</th>
		      </tr>
		    </thead>
				`;
				
				for(i = 0; i < userList.length; i++) {
					
					
					
					htmlCode +=
						`
						<tbody>
						<tr>
						<td class="userNo">${userList[i].user_no}</td>
						<td>${userList[i].user_id}</td>
						<td>${userList[i].user_name}</td>
						<td>${userList[i].user_nickname}</td>
						<td>${userList[i].user_bir}</td>
						<td>${userList[i].user_delyn == "N" ? "Y" : "N"}</td>
						`
						
						for(j = 0; j < userReportList.length; j++) {
							if(userList[i].user_no == userReportList[j].user_no && userReportList[j].check_yn == 'N') {
								htmlCode += `
									<td><span class="material-symbols-outlined">
									check
									</span></td>
									<td><button id="btn-userReport" class="btn btn-sm btn-danger">경고부여</button></td>
								`;
							}
						}
						
						htmlCode += `</tr>
					</tbody>
						`;
				}
			
				htmlCode += `</table>`;
				
			$("#mem-table").html(htmlCode);
		}
		, dataType : "JSON"
	});
	

	$("#userManage").click(function() {
		//$("#userList").removeClass("d-none");
		//$("#partyList").addClass("d-none");
	});
	
	$("#partyManage").click(function() {
		//$("#partyList").removeClass("d-none");
		//$("#userList").addClass("d-none");
	});
	
	$(document).on('click','#btn-partyReport',function() {
		let selectPartyNum = $(this).parents("tr").find(".partyNo").text();
		
		for(i = 0; i < partyReportList.length; i++) {
			let partyName = ""
			for(j = 0; j < partyList.length; j++) {
				if(partyReportList[i].party_no == partyList[j].party_no) {
					partyName = partyList[j].party_name;
				}
			}
			if(selectPartyNum == partyReportList[i].party_no && partyReportList[i].party_check_yn == "N") {
				
				if ( confirm(`신고 사유 : ${partyReportList[i].party_report_content}`) ) 
				{ 
						let curPartyReportNum = partyReportList[i].party_report_no;
						console.log(curPartyReportNum);
				 		$.ajax({
						url : `${myPath}/reportParty.do`
						, data : {"reportNo" : curPartyReportNum}
						, type : "GET"
						, async : false
						, success : function() {
							alert(`${partyName}모임에 경고를 부여했습니다.`);
							location.reload();
						} 
					}) 
				} else {
				    let curPartyReportNum = partyReportList[i].party_report_no;
					console.log(curPartyReportNum);
			 		$.ajax({
					url : `${myPath}/partyReportCompanion.do`
					, data : {"reportNo" : curPartyReportNum}
					, type : "GET"
					, success : function() {
						alert("모임 신고 반려");
						location.reload();
					} 
				})				    
			}
		}}
	})
	
	
	$(document).on('click','#btn-userReport',function() {
		let selectUserNum = $(this).parents("tr").find(".userNo").text();
		
		let reportCnt = 0;
		
		// 이미 처리된 신고 카운트 하기
		for(i = 0; i < userReportList.length; i++) {
			if(selectUserNum == userReportList[i].user_no && userReportList[i].check_yn == "Y") {
				reportCnt++;
			}
		}
		
		for(i = 0; i < userReportList.length; i++) {
			
			if(selectUserNum == userReportList[i].user_no && userReportList[i].check_yn == "N") {
				
				if ( confirm(`신고 사유 : ${userReportList[i].user_report_content}`) ) { 
					alert(`해당 유저에게 경고를 부여합니다. 현재 경고횟수 ${reportCnt + 1}`)
					
					// 경고횟수가 2회일 때 블라인드 처리
					if(reportCnt == 2) {
						$.ajax({
							url : `${myPath}/blindUser.do`
							, data : {"userNo" : selectUserNum}
							, type : "GET"
							, async : false
							, success : function() {
								alert(`${selectUserNum}번 유저가 블라인드 처리되었습니다.`);
								location.reload();
							}
						})
					} else {
						let curUserReportNum = userReportList[i].user_report_no;
						console.log(curUserReportNum);
						$.ajax({
						url : `${myPath}/reportUser.do`
						, data : {"reportNo" : curUserReportNum}
						, type : "GET"
						, success : function() {
							alert(`${selectUserNum}번 유저에게 경고를 부여했습니다.`);
							location.reload();
							}
						})
					}
				} else {
					    let curUserReportNum = userReportList[i].user_report_no;
						console.log("현재 유저 신고 번호 : " + curUserReportNum);
				 		$.ajax({
						url : `${myPath}/userReportCompanion.do`
						, data : {"reportNo" : curUserReportNum}
						, type : "GET"
						, success : function() {
							alert("유저 신고 반려");
							location.reload();
						} 
				 	})
				} 
				
			}
		}
	})
	
	//------------------ modal
	
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
	
	//------------------ modal
	
})
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
<body>

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
						<li class="nav-item"><a class="nav-link active"
							data-bs-toggle="tab" id="userManage" href="#userList">회원 관리</a></li>
						<li class="nav-item"><a class="nav-link" id="partyManage" data-bs-toggle="tab"
							href="#partyList">모임 관리</a></li>
						<li class="nav-item"><a class="" href="../festival/festivalMain.jsp">축제 관리 페이지로</a></li>
					</ul>

					<!-- Tab panes -->
					<div class="tab-content">
						<div
							class="tab-pane container active"
							id="userList">
							<div id="mem-table" class="d-flex flex-column justify-content-center align-items-center">
							</div>
						</div>
						
						<div class="tab-pane container fade" id="partyList">
							<div id="party-table" class="d-flex flex-column justify-content-center align-items-center">
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