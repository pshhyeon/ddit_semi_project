const myAPI = "ae077128449cf88203196cd19fcc1cab";
function onGeoOk(position) {
  const lat = position.coords.latitude;
  const lng = position.coords.longitude;
  // 현재의 위도와 경도를 받아온다.
  const url = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lng}&appid=${myAPI}&units=metric`;
  fetch(url)
    .then((respnse) => respnse.json())
    .then((data) => {
      const weatherCon = document.querySelector("#weather");
      const weather = document.querySelector("#weather span:first-child");
      const city = document.querySelector("#weather span:last-child");
      const weatherImg = document.querySelector("#weatherIcon");
      const weatherIcon = data.weather[0].icon;
      const weatherUrl = `http://openweathermap.org/img/wn/${weatherIcon}@2x.png`;
      city.innerHTML = ` ${data.name}`;
      weather.innerHTML = `${Math.round(data.main.temp)}º`;
      weatherCon.appendChild(weather);
      weatherCon.appendChild(city);
      document.getElementById("weatherIcon").src = weatherUrl; // 추가했습니다
      console.log(data);
    });
}
function onGeoErr() {
  alert("위치를 찾을 수 없습니다.");
}
navigator.geolocation.getCurrentPosition(onGeoOk, onGeoErr);





function sideBarShow() {
  let sidebar = document.querySelector("#sidebar");
  sidebar.classList.toggle("active");
  if (sidebar.classList.contains("active")) {
    $(".toggle-btn span").text("menu_open");
  } else {
    $(".toggle-btn span").text("menu");
  }
}