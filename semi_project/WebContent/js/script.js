

// -------------------------------------------- 카카오맵 시작
var mapContainer = document.getElementById("map"), // 지도를 표시할 div
  mapOption = {
    center: new kakao.maps.LatLng(37.56682, 126.97865), // 지도의 중심좌표
    level: 3, // 지도의 확대 레벨
  };

// 지도를 생성한다
var map = new kakao.maps.Map(mapContainer, mapOption);

/*// 지도에 마커를 생성하고 표시한다
var marker1 = new kakao.maps.Marker({
  position: new kakao.maps.LatLng(37.5726241, 126.999999), // 마커의 좌표
  map: map, // 마커를 표시할 지도 객체
});
// 마커 위에 표시할 인포윈도우를 생성한다
var infowindow1 = new kakao.maps.InfoWindow({
  content: '<div style="padding:5px;">첫번째 위치값 테스트입니다</div>', // 인포윈도우에 표시할 내용
});

var marker2 = new kakao.maps.Marker({
  position: new kakao.maps.LatLng(37.5726241, 126.976), // 마커의 좌표
  map: map, // 마커를 표시할 지도 객체
});
var infowindow2 = new kakao.maps.InfoWindow({
  content: '<div style="padding:5px;">두번째 위치값 테스트입니다 허허</div>', // 인포윈도우에 표시할 내용
});

var marker3 = new kakao.maps.Marker({
			  position: new kakao.maps.LatLng(37.5726211, 126.926), // 마커의 좌표
			  map: map, // 마커를 표시할 지도 객체
			});
			var infowindow3 = new kakao.maps.InfoWindow({
			  content: '<div style="padding:5px;">3번째 위치값 테스트입니다 허허</div>', // 인포윈도우에 표시할 내용
			});




// 인포윈도우를 지도에 표시한다
infowindow1.open(map, marker1);
infowindow2.open(map, marker2);
infowindow3.open(map, marker3);*/

			
// -------------------------------------------- 카카오맵 끝



function sideBarShow() {
  let sidebar = document.querySelector("#sidebar");
  sidebar.classList.toggle("active");
	
  if (sidebar.classList.contains("active")) {
    $(".toggle-btn span").text("menu_open");
  } else {
    $(".toggle-btn span").text("menu");
  }
}



