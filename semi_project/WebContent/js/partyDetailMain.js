// partyDetailMain.js
$(() => {
	
	
$(document).on('click', '#party_member_set_btn', function() {
	$.ajax({
		url : `${myPath}/getAllPartyUserList.do`,
		type : 'get',
		data : {"party_no" : partyNo},
		success : function(res) {
//			alert('가져오기 완료');
			
			var user_set_modal_code = 
	`
	 <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원관리</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
		<table class="table" style="text-align: center;">
			<tr>
				<th>이름</th>
				<th>아이디</th>
				<th>상태</th>
			</tr>`;

	$.each(res.list, function(i, v) {
		var set_user_no = v.USER_NO
		var set_user_name = v.USER_NAME
		var set_user_id = v.USER_ID
		var set_user_in = v.USER_IN
		var set_party_no = v.PARTY_NO
		var set_user_delyn = v.PARTY_USER_DELYN == 1 ? '가입대기' : '가입중';
		
		console.log(set_user_no);
		console.log(set_user_name);
		console.log(set_user_id);
		console.log(set_user_in);
		console.log(set_party_no);
		console.log(set_user_delyn);
		
		if(set_user_no != user.user_no){// 파티장 출력 x
			user_set_modal_code += 
			`
			<tr>
				<td>
				<a href="#" title="소개" data-bs-toggle="popover" data-bs-placement="right" data-bs-content="${set_user_in}" 
					style="text-decoration: none; color: black;">
					${set_user_name}</a>
				</td>	
				<td>${set_user_id}</td>
				<td idx="${set_user_no}" style="display: none;">${set_user_in}</td>`;
			if(set_user_delyn == '가입중'){
				user_set_modal_code += `
					<td><input idx="${set_user_no}" type="button" class="btn btn-outline-primary party_user_force" value=${set_user_delyn}></td>
				</tr>`
			} else {
				user_set_modal_code += `
					<td><input idx="${set_user_no}" type="button" class="btn btn-outline-success btn-sm party_user_accept" value="승인">
					    <input idx="${set_user_no}" type="button" class="btn btn-outline-danger btn-sm party_user_reject" value="반려"></td>
				</tr>`
			}
		} 
		
	});

	user_set_modal_code += `
		</table>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
	`;
	
	$('#user-detail-modal').html(user_set_modal_code);
	$('#userInfoModal').modal('show');
	
	
	
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	});
});

	
user_report_modal_code = function() {
	return `
	<div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">회원 신고</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">신고 사유:</label>
            <textarea class="form-control" id="user_report_content"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button id="go_user_btn" type="button" class="btn btn-danger">신고하기</button>
 	  </div>
	`;
}
	
party_report_modal_code = function() {
	return `
		  <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">소모임 신고</h1>
	        <button type="button" class="btn-close modal_window_close_btn" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>

	      <div class="modal-body">
	        <form>
	          <div class="mb-3">
	            <label for="message-text" class="col-form-label">신고 사유:</label>
	            <textarea class="form-control" id="party_report_content"></textarea>
	          </div>
	        </form>
	      </div>

	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary modal_window_close_btn" data-bs-dismiss="modal">취소</button>
	        <button id="go_party_btn" type="button" class="btn btn-danger">신고하기</button>
		  </div>
	`;
}

	
	
getUserDetail = function(mem_id) {
	$.ajax({
		url : `${myPath}/selectUserInfo.do`,
		type : 'get',
		data : {'user_no' : mem_id},
		success : function(res) {
			console.log("@partyDetail.js@getUserDetail 가져오기 성공");
			console.log("@partyDetail.js@getUserDetail res.vo.user_profile_name ==> " + res.vo.user_profile_name);
			
			user_info_modal_code = 
			`
			<div class="modal-header">
		        <h3 class="modal-title text-center fw-900"></h3>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
				<div style="display: flex; align-items: center;">
				    <div style="margin-right: 20px;">
				        <img alt="image not found" src="${myPath}/imageView.do?filename=${res.vo.user_profile_name}" style="width:200px; height:200px;">
				    </div>
				    <div>
				        <ul style="list-style: none; margin: 0; padding: 0;">
				            <li style="margin-bottom: 5px;">닉네임 : ${res.vo.user_nickname}</li>
				            <li style="margin-bottom: 5px;">이 름 : ${res.vo.user_name}</li>
				            <li style="margin-bottom: 5px;">생년월일 : ${res.vo.user_bir}</li>
				            <li><input id="user_report_btn" type="button" class="btn btn-outline-danger btn-sm" value="회원 신고하기"></li>
				        </ul>
				    </div>
				</div>

				</div>
		      	

		      </div>
		
		      <!-- Modal footer -->
		      <div id="modalBtnGroup" class="modal-footer" style="display: flex; justify-content: center;">
				<p>${res.vo.user_in}</p>
			  </div>
			`;
			//	user-detail-modal
			$('#user-detail-modal').html(user_info_modal_code);
			$('#userInfoModal').modal('show');
			if(admin_chk){
				$('#user_report_btn').prop("disabled", true);
			}
		},
		error : function(xhr) {
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
		});
	
}


	
// getPartyUserList
getPartyUserList = function(sParty_no) {
	$.ajax({
		url : `${myPath}/getPartyUserList.do`,
		type : 'get',
		async : false,
		data : {'party_no' : sParty_no},
		success : function(res) {
			console.log("@partyDetail.js@getPartyUserList 가져오기 성공");

			var userListCode = 
			`
			<tr>
		   	  	<th>번호</th>
		   	  	<th>닉네임</th>
		   	  	<th>이메일</th>
		   	  	<th>회원유형</th>
  	  		</tr>
			
			`;
			for (var i = 0; i < res.list.length; i++) {
				var v = res.list[i];
//			    console.log((i + 1) + "유저 번호 ==> " + v.user_no);

				var userType = (v.user_nickname === user_nickname) ? '모임장' : '일반회원';

				userListCode += 
				`
				<tr>
			   	  	<td>${i + 1}</td>
			   	  	<td idx=${v.user_no} class="select_user_nickname">${v.user_nickname}</td>
			   	  	<td>${v.user_mail}</td>
			   	  	<td id=${v.user_no}>${userType}</td>
		  	  	</tr>
				`;
				currnet_user_count_no++;
			}
			$('#userListTable').html(userListCode);
			
		},
		error : function(xhr) {
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
		});
	
} // /getPartyUserList

	
// 파티 상세 정보 가져오기
getPartyDetail = function(sParty_no) {
	$.ajax({
		url : `${myPath}/getPartyDetail.do`,
		type : 'post',
		async : false,
		data : {'party_no' : sParty_no},
		success : function(res) {
			// 모달창 안의 데이터 설정
			// 오류나면 전역변수 한번 확인해보기
			console.log("@partyDetail.js@상세정보 가져오기 성공 ==> " + res.flag);
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
			
			if(user.user_nickname == res.map.USER_NICKNAME){
				party_leader_chk = true;
				console.log("파티장입니다");
			}
			$('#party_detail_title_div').html(`<h1 style="color: #ed4c78;">「${party_name}」</h1>`);
			// 모달창 html작성
			var partyInfoCode = 
			`
			<br>
	   	  	<tr>
			    <th class="col-2">모임장</th>
			    <td colspan="4" class="col-4">${user_nickname}</td>
			    <td class="col-3"><input id="party_report_btn" type="button" class="btn btn-outline-danger btn-sm" value="모임 신고하기"></td>
			</tr>
			
			<tr>
			    <th class="col-2">인원</th>
			    <td colspan="3" class="col-2">${user_count} / ${party_percount}</td>
			    <th class="col-2">상태</th>`;
			if(party_leader_chk && (user_count != party_percount)){
				partyInfoCode += `<td class="col-2"><input id="party_status_change_btn" type="button" class="btn btn-outline-primary btn-sm" value="${party_status}"></td>`;
			} else {
				partyInfoCode += `<td colspan="3" class="col-2">${party_status}</td>`;
			}
			partyInfoCode += `
			</tr>
			
			<tr>
			    <th class="col-2">축제 정보</th>
			    <td colspan="5" class="col-10">${festival_name}</td>
			</tr>
			
			<tr>
			    <th class="col-2">해쉬태그</th>
			    <td colspan="5" class="col-10">${hashtags}</td>
			</tr>
			
			<tr>
			    <th class="col-2">소개</th>
			    <td colspan="5" class="col-10">${party_info}</td>
			</tr>
			`;
			
			$('#partyInfoTable').html(partyInfoCode);
			if(admin_chk){
				$('#party_report_btn').prop("disabled", true);
			}
			
			if(party_leader_chk){
				$('#party_member_set').html(
				`<input id="party_member_set_btn" type="button" class="btn btn-outline-primary btn-sm" value="모임회원 관리">`);
			} 

			if (!party_leader_chk && !admin_chk){
				$('#party_member_set').html(`<input id="party_exit_btn" type="button" class="btn btn-outline-secondary btn-sm" value="모임 탈퇴">`);
			}
			
			getPartyUserList(partyNo);
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	});
} // /getPartyDetail();


	
});
