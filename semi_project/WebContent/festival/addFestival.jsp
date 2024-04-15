<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isELIgnored="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script> -->
<script src="/semi_project/js/jquery.serializejson.min.js" defer></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serializejson/2.9.0/jquery.serializejson.min.js"></script> -->
<script src="/semi_project/js/weather.js" defer></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
$(() => {
	let myPath = "<%=request.getContextPath()%>"
	// 검색 버튼 찾아옴
	let searchBtn = document.getElementById("postcode_search_button");

  	// 우편번호 검색창 생성하는 함수, daum.Postcode클래스 사용
  	const daumPostcode = new daum.Postcode({
		// 검색 창에서 특정 주소를 선택했을 때 발생하는 이벤트
    	oncomplete: function (data) {
			// 받아온 data객체에서 필요한 값을 가져옴
	        const address = data.address;
//	        const zonecode = data.zonecode;

   	    	// html요소에 값을 담아줌 input이니까 value로
        	document.getElementById("address").value = address;
        	document.getElementById("streetNum").value = address;
    	},
 	});

  	// 버튼 클릭시 위에서 생성한 우편번호 검색창을 오픈
  	searchBtn.addEventListener("click", function () {
		daumPostcode.open();
 	});
  	
  	$('#join').on('click', function() {
		let fdata = $("#addFestivalForm").serializeJSON();
		console.log(fdata);
		
		$.ajax({
			url : `${myPath}/addFestival.do`,
			type : 'post',
			data : fdata,
 			success : res => {
				if (res.flag == "true") {
					location.href = `${myPath}/festival/festivalMain.jsp`
				}
			},
			error : xhr => {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		})
		
		
	})
})
</script>

</head>
<body>
<header id="nav">
		<jsp:include page="../jsp/nav.jsp" />
	</header>
	
	
	

	<div class="container mt-3">
	  <h2>축제 등록</h2>
	  <form id="addFestivalForm">
	    <div class="mb-2 mt-2">
	      <label for="fesName">축제명</label>
	      <div class="d-flex flex-row">
		      <input type="text" class="form-control" id="fesName" name="festival_name" required>
	      </div>
	    </div>
	    
	     <div class="mb-2 mt-2" id="postcode_search">
	   	    <label for="address">축제 주소</label>
      		<div class="d-flex flex-row">
      			<input type="text" class="form-control" id="address" placeholder="주소" name="festival_addr" readonly required />
      			<button type="button" class="btn btn-outline-primary btn-sm" id="postcode_search_button">주소검색</button>
      			<!-- 지번에도 주소 입력받도록 -->
	 			 <input type="text" class="form-control d-none" id="streetNum" placeholder="주소" name="festival_street_number" readonly />
      		</div>
      		<div id="postcode_list"></div>
    	</div>
	    
	    <div class="mb-2 mt-2">
	      <label for="hp">문의 번호</label>
	      <input type="text" class="form-control" id="hp" name="festival_tel" required>
	    </div>
	    
	    <div class="mb-2 mt-2">
	      <label for="site">축제 사이트</label>
	      <input type="text" class="form-control" id="site" name="festival_site" required>
	    </div>
	    
	    <div class="mb-2 mt-2">
	      <label for="location">축제 위치</label>
	      <input type="text" class="form-control" id="location" name="festival_location" required>
	    </div>
	  
	  <div class="mb-2 mt-2">
	      <label for="fes_start">축제 시작일 </label>
	      <input type="date" class="form-control" id="fes_start" name="festival_start" required>
	    </div>
	    
	    <div class="mb-2 mt-2">
	      <label for="fes_finish">축제 종료일</label>
	      <input type="date" class="form-control" id="fes_finish" name="festival_finish" required>
	    </div>
	  
	    <div class="mb-2 mt-2">
	      <label for="content">축제 내용</label>
	      <input type="text" class="form-control" id="content" name="festival_content" required>
	    </div>
	    
	    <div class="mb-2 mt-2 d-flex">
	    
	    <div style="width: 45%;">
					<label for="inst">주관</label>
	      <input type="text" class="form-control" id="inst" name="festival_inst" required>
				</div>
				<div style="width: 10%;"></div>
					<div style="width: 45%;">
					<label for="sido_no">시/도 선택</label>
					<select class="form-control"
							id="sido_no" name="sido_no" required>
							<option value="1">서울특별시</option>
							<option value="2">부산광역시</option>
							<option value="3">대구광역시</option>
							<option value="4">인천광역시</option>
							<option value="5">울산광역시</option>
							<option value="6">경기도</option>
							<option value="7">충청남도</option>
							<option value="8">강원특별자치도</option>
							<option value="9">전북특별자치도</option>
							<option value="10">전라남도</option>
							<option value="11">경상북도</option>
							<option value="12">경상남도</option>
							<option value="13">세종특별자치시</option>
							<option value="14">제주특별자치도</option>
							<option value="15">대전광역시</option>
						</select>
					</div>
	    </div>
	    
	    
			<div class="mb-2 mt-2 d-flex">
				<div style="width: 45%;">
					<label for="Latitude">위도</label> <input type="text"
						class="form-control" id="Latitude" name="latitude" required>
				</div>
				<div style="width: 10%;"></div>
				<div style="width: 45%;">
					<label for="longitude">경도</label> <input type="text"
						class="form-control" id="longitude" name="hardness" required>
				</div>
			</div>
			
			<p>위경도는 <a href="http://map.esran.com/" target="_blank" style="color : #5b4dff; fontSize : 16px;"> 여기 </a>에서 찾아 입력해주세요.</p>
			
			<button type="button" id=join class="btn btn-outline-danger btn-lg">등록하기</button> <br>
	  </form>
	  <!-- <form> -->
	</div>
	
	<footer id="fot">
		<jsp:include page="../jsp/footer.jsp" />
	</footer>
</body>

</html>