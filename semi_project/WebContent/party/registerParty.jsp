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
    <!-- 날씨 스크립트 -->
    <script src="../js/weather.js" defer></script>
    <!-- 카카오 페이 결제(포트원) -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    
    <script>
    var today = new Date();
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes();  // 분
	var seconds = today.getSeconds();  // 초
	var milliseconds = today.getMilliseconds();
	var makeMerchantUid = `${hours}` + `${minutes}` + `${seconds}` + `${milliseconds}`;
	
	myPath = '<%= request.getContextPath() %>';
	user = <%=session.getAttribute("user")%>;
	$(function() {
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
		
		getHashtagList();
		
		
		// 가입 신청 시 필요한 데이터
		var premiumChk = false;
		var party_name = "";
		var party_percount = 10;
		var user_no = user.user_no;
		var festival_no = <%=request.getParameter("festival_no")%>
		var party_info = "";
        var hashtag1 = "";
        var hashtag2 = "";
        var hashtag3 = "";
        
        $('#toggleButton').click(function(){
            // 체크 상태를 확인하고 반대로 설정
            var clicked_btn = $(this);
            if($(this).prop('checked')){
				kakaoPay(clicked_btn);
            }
        });
        
        $('#toggleButton').change(function() {
            // 체크박스의 상태를 가져와서 확인
            var isChecked = $(this).prop('checked');
            
            // 체크된 경우
            if (isChecked) {
                party_percount = 20;
                premiumChk = true;
                console.log("토글 버튼이 체크되었습니다. ==> " + party_percount);
            // 카카오 페이 API
            // 카카오 페이 API 결제 끝
                
            } else { // 체크되지 않은 경우
                party_percount = 10;
                premiumChk = false;
                console.log("토글 버튼이 체크 해제되었습니다. ==> " + party_percount);
            }
        });
        
        // 모임 등록 ==> 순서 1. 모임등록 2. 모임 번호 조회 3. 파티 유저 등록 4. 해쉬태그 등록
		$('#party_register_btn').on('click', function() {
			hashtag1 = $('#hashtag1').val();
			hashtag2 = $('#hashtag2').val();
			hashtag3 = $('#hashtag3').val();
			party_name = $('#party_name').val();
			party_info = $('#party_info').val();

			console.log("가입버튼 클릭");
			console.log("party_name ==> " + party_name);
			console.log("party_percount ==> " + party_percount);
			console.log("premiumChk ==> " + premiumChk);
			console.log("user_no ==> " + user_no);
			console.log("festival_no ==> " + festival_no);
			console.log("party_info ==> " + party_info);
			console.log("hashtag1 ==> " + hashtag1);
			console.log("hashtag2 ==> " + hashtag2);
			console.log("hashtag3 ==> " + hashtag3);
			
			$.ajax({
				url : `${myPath}/registerParty.do`,
				type : 'post',
				data : {
					'party_name' : party_name,
					'user_no' : user_no,
					'festival_no' : festival_no,
					'party_percount' : party_percount,
					'party_info' : party_info,
					'hashtag1' : hashtag1,
					'hashtag2' : hashtag2,
					'hashtag3' : hashtag3,
				},
				success : function(res) {
					alert('모임 등록성공');
					location.href = `${myPath}/party/partyMain.jsp`;
				},
				error : function(xhr) {
					alert('상태 : ' + xhr.status);
				},
				dataType : 'json'
			});
			
			
		});
		
		// 해쉬태그 중복체크 blok
		$('#hashtag1, #hashtag2, #hashtag3').change(function() {
			var already_selected_option1 = "";
			var already_selected_option2 = "";
			clicktag_id = $(this).attr('id');
			clicktag_val = $(this).val();
			
			$('select').not(this).each(function() { // 모든 select 요소에 대해 반복
				if(already_selected_option1 == ""){
					already_selected_option1 = $(this).val();
				} else {
					already_selected_option2 = $(this).val();
				}
			});
			console.log("already_selected_option1 ==> " + already_selected_option1);
			console.log("already_selected_option2 ==> " + already_selected_option2);
			if (already_selected_option1 == clicktag_val || already_selected_option2 == clicktag_val) {
				alert('이미 선택한 해쉬태그 입니다');
				$('#' + clicktag_id).val('');
			}
		});
		
		// 돌아가기
		$('#back_btn').on('click', function() {
			window.history.back();
		})
		
	});
	
	getHashtagList = function() {
		$.ajax({
			url : `${myPath}/getHashtagList.do`,
			type : 'get',
			success : function(res) {
				option_code = '<option value="">해쉬태그 선택</option>';
				$.each(res.HashmapList, function(i, v) {
					option_code += `<option value=${v.hashtag_no}>${v.hashtag_name}</option>`;
				});
				$('#hashtag1').html(option_code);
				$('#hashtag2').html(option_code);
				$('#hashtag3').html(option_code);
			},
			error : function(xhr) {
				alert('상태 : ' + xhr.status);
			},
			dataType : 'json'
		});
	}	
	
	
	var IMP = window.IMP;
	function kakaoPay(btn) {
	    if (confirm("결제 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
	        IMP.init("iamport"); // 가맹점 식별코드
	        IMP.request_pay({
	            pg: 'kakaopay.TC0ONETIME', // PG사 코드표에서 선택
	            pay_method: 'card', // 결제 방식
	            merchant_uid: "IMP" + `${makeMerchantUid}`, // 결제 고유 번호
	            name: 'party_premium', // 제품명
	            amount: 5000, // 가격
	            //구매자 정보 ↓
	            buyer_email: 'mzmz000.outlook.com',
	            buyer_name: `엠제또`,
	            buyer_tel : '010-1234-5678',
	            buyer_addr : '서울특별시 강남구 삼성동',
	            buyer_postcode : '123-456'
	        }, async function (rsp) { // callback
	            if (rsp.success) { //결제 성공시
	                console.log(rsp);
	                $(btn).prop('checked', true);
	            } else {
	            	// rsp.error_code == F1002 ==> 이미 결제된 내역
	            	// rsp.status == paid
	            	if (rsp.error_code == 'F1002') {
		                alert(rsp.error_msg);
		            	console.log("rsp.error_code ==> " + rsp.error_code);
		                $(btn).prop('checked', true);
	            	} else {
		                alert(rsp.error_msg);
		                $(btn).prop('checked', false);
	            	}
	            }
	        });
	    } else { // 구매 확인 알림창 취소 클릭시 돌아가기
	    	$(btn).prop('checked', false);
	    }
	}
	
	</script>

</head>
<body>

<header>
	<jsp:include page="/jsp/nav.jsp"/>
</header>
    
<main>
<!-- 
party_no(자동등록)
party_name						>> 파티 이름
party_percount					>> 파티 인원은 프리미엄
party_delyn(모집상태는 여기서 안함)
party_date(sysdate)
user_no(user session에서 가져옴)
festival_no						>> 파라미터로 받아옴
party_info						>> 작성

 -->
 <div class="container mt-3" style="text-align: center;">

	 <h2><%=request.getParameter("festival_name")%> 소모임을 등록합니다 :)</h2>
	  <form id="registerForm">
	  
	    <br>
	    <div class="mb-2 mt-2">
	      <label for="party_name">소모임 이름</label>
	      <div class="d-flex flex-row">
		      <input type="text" class="form-control" id="party_name" name="party_name">
	      </div>
	    </div>
	  
	    <br>
	    <div class="mb-2 mt-2">
	      <label for="party_info">소모임 소개</label>
	      <input type="text" class="form-control" id="party_info" name="party_info">
	    </div>
	    
	    <br>
	    <div class="mb-2 mt-2">
	      <label for="hashtag1">해쉬태그1</label>
		    <select id="hashtag1" class="form-select-sm" style="width: 200px; text-align: center; border-color : #ed4c78; border-radius: 0.375rem;">
			    <option value="" selected>해쉬태그 선택</option>
		  	</select>
	    </div>
	    
	    <div class="mb-2 mt-2">
	      <label for="hashtag2">해쉬태그2</label>
		    <select id="hashtag2" class="form-select-sm" style="width: 200px; text-align: center; border-color : #ed4c78; border-radius: 0.375rem;">
			    <option value=""selected>해쉬태그 선택</option>
		  	</select>
	    </div>
	    
	    <div class="mb-2 mt-2">
	      <label for="hashtag3">해쉬태그3</label>
		    <select id="hashtag3" class="form-select-sm" style="width: 200px; text-align: center; border-color : #ed4c78; border-radius: 0.375rem;">
			    <option value=""selected>해쉬태그 선택</option>
		  	</select>
	    </div>
	    
	    <br>
	    <div class="mb-2 mt-2">
		    <p>프리미엄 소모임을 통해 20명의 회원과 모임을 가질 수 있습니다. (기본 10명)</p>
		  <div class="form-check form-switch form-check-inline">
		    <input class="form-check-input btn-lg" type="checkbox" id="toggleButton">
		    <label class="form-check-label custom-control-label" for="toggleButton">5000원이 결제됩니다.</label>
		    
		  </div>
		</div>
	  
	  
	  	<br>
	    <button type="button" id=back_btn class="btn btn-light" style="border-color: #ed4c78; background-color: white;">돌아가기</button>
	    <button type="button" id=party_register_btn class="btn btn-primary" style="border: none; background-color: #ed4c78;">등록하기</button>
	  </form>
</div>
</main>

<footer>
	<jsp:include page="/jsp/footer.jsp"/>
</footer>

</body>

</html>