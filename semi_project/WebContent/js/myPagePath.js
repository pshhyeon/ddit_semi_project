// 마이페이지 경로 설정
$("#link-myPage").click(function() {
	if (user == null) {
		location.href = `${myPath}/user/loginForm.jsp`;
	} else if (user.user_admin_chk == "Y") {
		location.href = `${myPath}/user/adminPage.jsp`;
	} else {
		location.href = `${myPath}/user/myPage.jsp`;
	}
})