

// 찜 상태 확인 메서드
getbookmarkStatus = function(callback) {
	var stat = false;
	$.ajax({
		url : `${myPath}/getbookmarkStatus.do`,
		type : 'get',
		data : {'party_no' : vId,
				'user_no' : user_no
		},
		success : function(res) {
			console.log("@partyMain.js@ getbookmarkStatus메서드flag ==> " + res.flag);
			if(res.flag == "null"){
				stat = false;
			} else {
				stat = true;
			}
			callback(stat); // AJAX 요청이 완료된 후에 콜백 함수 호출
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
			callback(stat); // 에러가 발생하더라도 콜백 함수 호출
		},
		dataType : 'json'
	});
}
/*
// getbookmarkStatus사용법
	getbookmarkStatus(function(stat) {
	    // AJAX 요청이 완료된 후에 실행되는 코드
	    console.log("getbookmarkStatus 결과:", stat);
	    // stat 값을 이용한 다른 동작 수행 가능
	});
*/


// 찜 버튼 상태 수정
modifyBookmarkBtn = function() {
	getbookmarkStatus(function(stat) {
		
		if (stat) {
			// 찜 취소
			$.ajax({
				url : `${myPath}/delBookmark.do`,
				type : 'post',
				data : {"user_no" : user_no, "party_no" : vId},
				success : function(res) {
					console.log("@partyMain.js 찜버튼수정 메서드 @true면@찜 삭제 완료 ==> " + res.flag);
					if(res.flag == 'true'){
						console.log("@partyMain.js 찜버튼수정 메서드 @true" + res.flag);
						$('#modalBookmarkBtn').attr('btnStatus', 'bookmarkfalse').val('♡찜하기');
					}
				},
				error : function(xhr) {
					alert("상태 : " + xhr.status);
				},
				dataType : 'json'
			});
		} else {
			// 찜 하기
			$.ajax({
				url : `${myPath}/insertBookmark.do`,
				type : 'post',
				data : {"user_no" : user_no, "party_no" : vId},
				success : function(res) {
					console.log("@partyMain.js 찜버튼수정 메서드 @true면@찜 추가 완료 ==> " + res.flag);
					if(res.flag == 'true'){
						console.log("@partyMain.js 찜버튼수정 메서드 @true" + res.flag);
						$('#modalBookmarkBtn').attr('btnStatus', 'bookmarktrue').val('♥찜하기');
					}
				},
				error : function(xhr) {
					alert("상태 : " + xhr.status);
				},
				dataType : 'json'
			});
		}
	});
}


// 가입하기 버튼 상태 수정
modifyJoinBtn = function() {
	// user_no 회원번호
	// party_user_status 파티에 대한 회원의 상태
	// vId 선택한 파티 번호
	
	console.log('modifyJoinBtn메서드 일반회원 수행시 값 : ');
	console.log('@@ party_user_status ==> ' + party_user_status);
	console.log('@@ user_no ==> ' + user_no);
	console.log('@@ vId ==> ' + vId);
	// party_user_status == 0일때
	if(party_user_status == '0'){
		$.ajax({
			url : `${myPath}/insertJoinParty.do`,
			type : 'post',
			data : {"user_no" : user_no, "party_no" : vId},
			success : function(res) {
				console.log("@partyMain.js 가입버튼수정 메서드 @true면@0인 회원 1 추가 완료 ==> " + res.flag);
				party_user_status = '1';
				$('#modaljoinBtn').attr('idx', '1').val('가입대기');
			},
			error : function(xhr) {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		});
	}

	// party_user_status == 1일때
	else if(party_user_status == '1'){
		$.ajax({
			url : `${myPath}/delJoinParty.do`,
			type : 'post',
			data : {"user_no" : user_no, "party_no" : vId},
			success : function(res) {
				console.log("@partyMain.js 가입버튼수정 메서드 @true면@1인 회원 삭제 완료 ==> " + res.flag);
				party_user_status = '0';
				$('#modaljoinBtn').attr('idx', '0').val('가입하기');
			},
			error : function(xhr) {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		});
	}

	// party_user_status == 3일때
	else if(party_user_status == '3'){
		$.ajax({
			url : `${myPath}/updateJoinParty.do`,
			type : 'post',
			data : {"user_no" : user_no, "party_no" : vId},
			success : function(res) {
				console.log("@partyMain.js 가입버튼수정 메서드 @true면@3인 회원 1 변경 완료 ==> " + res.flag);
				party_user_status = '1';
				$('#modaljoinBtn').attr('idx', '1').val('가입대기');
			},
			error : function(xhr) {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		});
	}
}

// 파티 상세 정보 가져오기
getPartyDetail = function(party_no, loginChk, userStatusNum) {
	$.ajax({
		url : `${myPath}/getPartyDetail.do`,
		type : 'post',
		data : {'party_no' : party_no},
		success : function(res) {
			// 모달창 안의 데이터 설정
			console.log("@partyMain.js@상세정보 가져오기 성공 ==> " + res.flag);
			user_nickname = res.map.USER_NICKNAME;	
			user_name = res.map.USER_NAME;
			user_count = res.map.USER_COUNT;
			party_no = res.map.PARTY_NO;
			party_name = res.map.PARTY_NAME;
			party_percount = res.map.PARTY_PERCOUNT;
			party_status = res.map.PARTY_STATUS;
			party_date = res.map.PARTY_DATE;
			party_info = res.map.PARTY_INFO;
			festival_no = res.map.FESTIVAL_NO;
			festival_name = res.map.FESTIVAL_NAME;
			hashtags = res.map.HASHTAGS;
			
			// 모달창 html작성
			var modalCode = 
			`
			  <div class="modal-header">
		        <h3 class="modal-title text-center fw-900">${party_name}</h3>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	  <table class="table modalTable">
		      	  	<tr>
		      	  	<th>모임장</th>
		      	  	<td colspan="4">${user_nickname}</td>
		      	  	</tr>
		      	  	
		      	  	<tr>
		      	  	<th>인원</th>
		      	  	<td colspan="2">${user_count} / ${party_percount}</td>
		      	  	<th>상태</th>
		      	  	<td colspan="2">${party_status}</td>
		      	  	</tr>
		      	  	
		      	  	<tr>
		      	  	<th>축제 정보</th>
		      	  	<td colspan="5">${festival_name}</td>
		      	  	</tr>
		      	  	
		      	  	<tr>
		      	  	<th>해쉬태그</th>
		      	  	<td colspan="5">${hashtags}</td>
		      	  	</tr>
		      	  	
		      	  	<tr>
		      	  	<th>소개</th>
		      	  	<td colspan="5">${party_info}</td>
		      	  	</tr>
		      	  </table>
		      </div>
		
		      <!-- Modal footer -->
		      <div id="modalBtnGroup" class="modal-footer" style="display: flex; justify-content: center;">
			`;
			
			// 찜하기 버튼 생성 조건
			// loginChk, userStatusNum
			if(loginChk && userStatusNum != 4){
				getbookmarkStatus(function(stat) { // AJAX 요청이 완료된 후에 실행되는 코드
					// stat 찜 되어있으면 true 없으면 false
					// 유저 상태 1, 3
				    if (stat) {
						modalCode += '<input type="button" id="modalBookmarkBtn" class="btn btn-primary modalBtn" btnStatus="bookmarktrue" value="♥찜하기">';
						console.log("코드 생성 > 찜 여부true : " + stat);
					} else {
						modalCode += '<input type="button" id="modalBookmarkBtn" class="btn btn-primary modalBtn" btnStatus="bookmarkfalse" value="♡찜하기">';
						console.log("코드생성 > 찜 여부false : " + stat);
					}
					if(party_status == "모집중"){
						// 가입 하기 버튼 생성
						if(userStatusNum == 0){
							modalCode += `<input type="button" id="modaljoinBtn" class="btn btn-primary modalBtn" idx="0" value="가입하기">`;
						} else if(userStatusNum == 1) {
							modalCode += `<input type="button" id="modaljoinBtn" class="btn btn-primary modalBtn" idx="1" value="가입대기">`;
						} else if(userStatusNum == 3) {
							modalCode += `<input type="button" id="modaljoinBtn" class="btn btn-primary modalBtn" idx="3" value="가입하기">`;
						}
					}
					
					modalCode += `</div>`;
					
					$('#party-detail-modal').html(modalCode);
					$('#partyInfoModal').modal('show');
				});
				
			} else {
				modalCode += `</div>`;
				$('#party-detail-modal').html(modalCode);
				$('#partyInfoModal').modal('show');
			} 
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
}

// 유저 가입 파티 여부 체크
userPartyChk = function(loginChk) {
	$.ajax({
		url : `${myPath}/getUserPartystatus.do`,
		type : 'post',
		data : {'user_no' : user_no, 'party_no' : vId },
		success : function(res) {
			console.log("userPartyChk 성공 - 회원 상태 ==> " + res.flag)
			console.log("loginChk" + loginChk);
			console.log("res.flag" + res.flag);
			party_user_status = res.flag;
			if(user_admin_chk || loginChk && (res.flag == '2')){
				location.href = `${myPath}/party/partyDetail.jsp?selectedPartyNo=${vId}`;
			} else {
				console.log("로그인x || 가입 x0 || 가입대기1 || 탈퇴3 || 강퇴4 ==> 모달창 생성");
				console.log("userPartyChk메서드loginChk" + userPartyChk);
				console.log("userPartyChk메서드res.flag" + res.flag);
				getPartyDetail(vId, loginChk, res.flag);
				
			}
		},
		error : function(xhr) {
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
}

// 파티 리스트 출력
partyList = function() {
	stype = $("#stype option:selected").val().trim();
	sword = $("#sword").val().trim();
	
	$.ajax({
			url : `${myPath}/getPartyBoardList.do`,
			type : "get",
			data : {"page" : currentPage, 'stype' : stype, 'sword' : sword},
			success : res => {
//				alert("성공 : " + res)
				code = "";
				$.each(res.list, function(i, v) {
// {"PARTY_NO":12,"RNUM":1,"PARTY_STATUS":"모집중","USER_CNT":1,"PARTY_NAME":"테스트입니다2","REGION_SIDO":"전라남도","PARTY_PERCOUNT":"10"}
					code += 
						`
						<tr id='${v.PARTY_NO}' class='listOne'>
	            			<td>${v.RNUM}</td>
	           				<td>${v.PARTY_NAME}</a></td>
	            			<td>${v.REGION_SIDO}</td>
	            			<td>${v.USER_CNT}/${v.PARTY_PERCOUNT}</td>
	            			<td>${v.PARTY_STATUS}</td>
	          			</tr>
						`
					})
				$('#partyListBody').html(code);
					
				// 페이지 번호 출력하기
				pagecontroll = pageNav(res.sp, res.ep, res.tp);
				$('#pageNav').html(pagecontroll);
				
			},
			error : xhr => {
				alert("상태 : " + xhr.status)
			},
			dataType : 'json'
		});
}

// 페이징 처리
pageNav = function(sp, ep, tp) {
	pageNavCode = `<ul class='pagination'>`;
	if(sp > 1){
			pageNavCode+= `<li class="page-item"><a class="page-link prev" href="#">이전</a></li>`;
		}
		
	if(currentPage > tp) currentPage = tp;
	
	for (i=sp; i<=ep; i++) {
		if (i == currentPage) {
			pageNavCode += `<li class="page-item active"><a class="page-link pnum" href="#">${i}</a></li>`;
		} else {
			pageNavCode += `<li class="page-item"><a class="page-link pnum" href="#">${i}</a></li>`;
		}	
	}
		
	if (tp > ep) {
		pageNavCode += `<li class="page-item"><a class="page-link next" href="#">다음</a></li>`;
	}
		
	pageNavCode += `</ul>`;
	return pageNavCode;
}

