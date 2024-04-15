

$(function() {
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
//        	document.getElementById("postcode").value = zonecode;
    	},
 	});

  	// 버튼 클릭시 위에서 생성한 우편번호 검색창을 오픈
  	searchBtn.addEventListener("click", function () {
		daumPostcode.open();
 	});
})
	
