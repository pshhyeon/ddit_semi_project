// detailFestival.js

// modal_login_chk > boolean
// modal_party_user_status > int
// modal_party_no > int
// modal_user_no > int


// 찜 버튼 상태 수정
modifyBookmarkBtn = function() {
	getbookmarkStatus(function(stat) {
		
		if (stat) {
			// 찜 취소
			$.ajax({
				url : `${myPath}/delBookmark.do`,
				type : 'post',
				data : {"user_no" : modal_user_no, "party_no" : modal_party_no},
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
				data : {"user_no" : modal_user_no, "party_no" : modal_party_no},
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
	// modal_party_user_status == 0일때
	if(modal_party_user_status == '0'){
		$.ajax({
			url : `${myPath}/insertJoinParty.do`,
			type : 'post',
			data : {"user_no" : modal_user_no, "party_no" : modal_party_no},
			success : function(res) {
				console.log("@partyMain.js 가입버튼수정 메서드 @true면@0인 회원 1 추가 완료 ==> " + res.flag);
				modal_party_user_status = '1';
				$('#modaljoinBtn').attr('idx', '1').val('가입대기');
			},
			error : function(xhr) {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		});
	}

	// modal_party_user_status == 1일때
	else if(modal_party_user_status == '1'){
		$.ajax({
			url : `${myPath}/delJoinParty.do`,
			type : 'post',
			data : {"user_no" : modal_user_no, "party_no" : modal_party_no},
			success : function(res) {
				console.log("@index.js 가입버튼수정 메서드 @true면@1인 회원 삭제 완료 ==> " + res.flag);
				modal_party_user_status = '0';
				$('#modaljoinBtn').attr('idx', '0').val('가입하기');
			},
			error : function(xhr) {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		});
	}

	// modal_party_user_status == 3일때
	else if(modal_party_user_status == '3'){
		$.ajax({
			url : `${myPath}/updateJoinParty.do`,
			type : 'post',
			data : {"user_no" : modal_user_no, "party_no" : modal_party_no},
			success : function(res) {
				console.log("@index.js 가입버튼수정 메서드 @true면@3인 회원 1 변경 완료 ==> " + res.flag);
				modal_party_user_status = '1';
				$('#modaljoinBtn').attr('idx', '1').val('가입대기');
			},
			error : function(xhr) {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		});
	}
}

// 찜 상태 확인 메서드
getbookmarkStatus = function(callback) {
	var stat = false;
	$.ajax({
		url : `${myPath}/getbookmarkStatus.do`,
		type : 'get',
		data : {'party_no' : modal_party_no,
				'user_no' : modal_user_no
		},
		success : function(res) {
			console.log("@index.js@ getbookmarkStatus메서드flag ==> " + res.flag);
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


// 파티 상세 정보 가져오기
getPartyDetail = function(party_no) {
	$.ajax({
		url : `${myPath}/getPartyDetail.do`,
		type : 'post',
		data : {'party_no' : modal_party_no },
		success : function(res) {
			// 모달창 안의 데이터 설정
			console.log("@index.js@파티 상세정보 가져오기 성공 ==> " + res.flag);
			var user_nickname = res.map.USER_NICKNAME;	
			var user_name = res.map.USER_NAME;
			var user_count = res.map.USER_COUNT;
			var party_no = res.map.PARTY_NO;
			var party_name = res.map.PARTY_NAME;
			var party_percount = res.map.PARTY_PERCOUNT;
			var party_status = res.map.PARTY_STATUS;
			var party_date = res.map.PARTY_DATE;
			var party_info = res.map.PARTY_INFO;
			var festival_no = res.map.FESTIVAL_NO;
			var festival_name = res.map.FESTIVAL_NAME;
			var hashtags = res.map.HASHTAGS;
			
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
			if(modal_login_chk && modal_party_user_status != 4){
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
						if(modal_party_user_status == "0"){
							modalCode += `<input type="button" id="modaljoinBtn" class="btn btn-primary modalBtn" idx="0" value="가입하기">`;
						} else if(modal_party_user_status == "1") {
							modalCode += `<input type="button" id="modaljoinBtn" class="btn btn-primary modalBtn" idx="1" value="가입대기">`;
						} else if(modal_party_user_status == "3") {
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
	});
}


// 유저 가입 파티 여부 체크 loginChk(bool), user_no, party_no(vId), user_admin_Chk
userPartyChk = function() {
	$.ajax({
		url : `${myPath}/getUserPartystatus.do`,
		type : 'post',
		data : {'user_no' : modal_user_no, 'party_no' : modal_party_no },
		success : function(res) {
			console.log("userPartyChk 성공 - 회원 상태 ==> " + res.flag)
			console.log("loginChk" + modal_login_chk);
			console.log("res.flag" + res.flag);
			modal_party_user_status = res.flag;
			if(modal_user_admin_chk =='Y' || modal_login_chk && (res.flag == '2')){
				location.href = `${myPath}/party/partyDetail.jsp?selectedPartyNo=${modal_party_no}`;
			} else {
				console.log("로그인x || 가입 x0 || 가입대기1 || 탈퇴3 || 강퇴4 ==> 모달창 생성");
				console.log("userPartyChk메서드res.flag" + res.flag);
				getPartyDetail();
			}
		},
		error : function(xhr) {
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
}