<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 제이쿼리 -->
<script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 스타일 -->
<link rel="stylesheet" href="/semi_project/css/styles.css" />
<!-- partyDetailMain.js -->    
<script src="/semi_project/js/partyDetailMain.js"></script>
    
<script>
	<%
		request.setCharacterEncoding("utf-8");
		String userJsonStr = "";
		if(session.getAttribute("user") != null || userJsonStr.equals("")){
			userJsonStr = (String) session.getAttribute("user");
		}
	%>
	
	partyNo = '<%=request.getParameter("selectedPartyNo")%>';
	myPath = '<%= request.getContextPath() %>';
	user = <%=userJsonStr%>;
	party_leader_chk = false;
	admin_chk = false;
	currnet_user_count_no = 1;
	
	if(user.user_admin_chk == 'Y'){
		admin_chk = true;
	}
	$(() => {
		console.log("partyNo => " + partyNo);
		console.log("myPath => " + myPath);
		console.log("user_no => " + user.user_no);
		getPartyDetail(partyNo);
		
		$(document).on('click', '.select_user_nickname', function() {
			mem_id = $(this).attr('idx');
			getUserDetail(mem_id);
		});
		
		$(document).on('click', '#user_report_btn', function() {
			$('#user-detail-modal').html(user_report_modal_code());
		});
		
		$(document).on('click', '#go_user_btn', function() {
			var user_report_content = "";
			user_report_content = $('#user_report_content').val();
			$.ajax({
				url : `${myPath}/insertUserReport.do`,
				type : 'get',
				data : {'user_report_content' : user_report_content, "user_no" : mem_id},
				success : function(res) {
					alert('신고가 접수 되었습니다.')
					location.reload();
// 					$('.modal-backdrop').hide();
// 					$('#userInfoModal').hide();
// 					$('#user-detail-modal').html('');
// 					$('#userInfoModal').toggleClass('d-none');
				},
				error : function(xhr){
					alert("상태 : " + xhr.status);
				},
				dataType : 'json'
			});
		});
		
		$(document).on('click', '#party_report_btn', function() {
			$('#user-detail-modal').html(party_report_modal_code());
			$('#userInfoModal').show();
		});
		
		$(document).on('click', '#go_party_btn', function() {
			var party_report_content = "";
			party_report_content = $('#party_report_content').val();
			console.log("party_report_content ==> " + party_report_content);
			console.log("partyNo ==> " + partyNo);
			console.log("user.user_no ==> " + user.user_no);
			$.ajax({
				url : `${myPath}/insertPartyReport.do`,
				type : 'get',
				data : {'party_report_content' : party_report_content, "user_no" : user.user_no, "party_no" : partyNo},
				success : function(res) {
					alert('신고 완료');
					$('#userInfoModal').hide();
				},
				error : function(xhr){
					alert("상태 : " + xhr.status);
				},
				dataType : 'json'
			});
		});
		
		$(document).on('click', '#party_status_change_btn', function() {
			var status_change_val = '';
			if(party_status == '모집마감'){
				status_change_val = 'N';
			}
			else if(party_status == '모집중'){
				status_change_val = 'Y';
			}
			
			if(confirm('모집상태를 변경하시겠습니까?')){
				$.ajax({
					url : `${myPath}/updatePartyStatus.do`,
					type : 'get',
					data : {"party_delyn" : status_change_val, "party_no" : partyNo},
					success : function(res) {
						alert('변경완료');
						location.reload(); 
					},
					error : function(xhr){
						alert("상태 : " + xhr.status);
					},
					dataType : 'json'
				});
			}
		});
		
		$(document).on('click', '.modal_window_close_btn', function() {
			$('#userInfoModal').hide();
		});
		
		// 회원 상태 수정 이벤트
		// 회원 수락
		$(document).on('click', '.party_user_accept', function() {
			var set_select_user_num = $(this).attr('idx');
			var cthis = $(this);
			
			var $tr = cthis.closest("tr");

	        $.ajax({
				url : `${myPath}/acceptPartyUser.do`,
				type : 'get',
				data : {'party_no' : partyNo , 'user_no' : set_select_user_num },
				success : function(res) {
					alert('승인되었습니다');
					var code = '<input idx="' + set_select_user_num + '" type="button" class="btn btn-outline-primary party_user_force" value="가입중">';
					cthis.parent().html(code);
					getPartyUserList(partyNo);
				},
				error : function(xhr) {
					alert("상태 : " + xhr.status);
				},
				dataType : 'json'
			});
		});
		
		// 회원 거절
		$(document).on('click', '.party_user_reject', function() {
			var set_select_user_num = $(this).attr('idx');
			var cthis = $(this);
			$.ajax({
				url : `${myPath}/rejectPartyUser.do`,
				type : 'get',
				data : {'party_no' : partyNo , 'user_no' : set_select_user_num },
				success : function(res) {
					alert('반려 되었습니다.');
					cthis.parent().parent().remove();
				},
				error : function(xhr) {
					alert("상태 : " + xhr.status);
				},
				dataType : 'json'
			});
		});
		
		// 회원 강퇴
		$(document).on('click', '.party_user_force', function() {
			var set_select_user_num = $(this).attr('idx');
			var cthis = $(this);
			if (confirm(set_select_user_num + '번 회원을 강퇴하시겠습니까?')) {
				$.ajax({
					url : `${myPath}/forcePartyUser.do`,
					type : 'get',
					data : {'party_no' : partyNo , 'user_no' : set_select_user_num },
					success : function(res) {
						alert('강퇴 되었습니다.');
						cthis.parent().parent().remove();
						getPartyUserList(partyNo);
					},
					error : function(xhr) {
						alert("상태 : " + xhr.status);
					},
					dataType : 'json'
				});
			}
		});
		
		// 회원 강퇴
		$(document).on('click', '#party_exit_btn', function() {
			if (confirm('모임을 탈퇴 하시겠습니까?')) {
				$.ajax({
					url : `${myPath}/exitParty.do`,
					type : 'get',
					data : {'party_no' : partyNo , 'user_no' : user.user_no },
					success : function(res) {
						alert('탈퇴 성공');
						window.parent.postMessage('navigateParentToURL', '*');
					},
					error : function(xhr) {
						alert("상태 : " + xhr.status);
					},
					dataType : 'json'
				});
			}
		});
		
		$('#userInfoModal').on('shown.bs.modal', function () {
		    // 모달이 사용자에게 보여진 후 popover 초기화
		    $('[data-bs-toggle="popover"]').popover();
		});
		
	});
	
</script>

</head>
<body>

<div class="container mt-3">

	<!-- 유저 정보 리스트 -->
	<div id="party_detail_title_div" style="width: 100%;" class="text-center mt-3 mb-3"></div>
	<table id="partyInfoTable" class="table" style="text-align: center;"></table>
	
	<div id="party_member_set" style="text-align: right"></div>
	
	<br>
	<!-- 유저 정보 리스트 -->
	<div style="width: 100%;" class="text-center mt-3 mb-3"><h3 style="color: #ed4c78;">모임원 정보</h3></div>
	<table id="userListTable" class="table table-bordered" style="text-align: center; line-height : 50px"></table>
	<br><br>
	
      	
</div>

	<!-- partyDetail 유저 정보 Modal -->
	<div class="modal" id="userInfoModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div id="user-detail-modal" class="modal-content">
	    
	    </div>
	  </div>
	</div>
	
	<script>
		var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
		var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
		  return new bootstrap.Popover(popoverTriggerEl)
		});
	</script>
	
</body>

</html>