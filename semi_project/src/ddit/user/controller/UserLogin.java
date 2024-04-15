package ddit.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.UserVO;

@WebServlet("/userLogin.do")
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 전송시 데이터 받기
		String userId = request.getParameter("id");
		String userPass = request.getParameter("pass");

		UserVO vo = new UserVO();
		vo.setUser_id(userId);
		vo.setUser_pass(userPass);

		// service객체
		IUserService service = UserServcieImpl.getInstance();
		HttpSession logSession = request.getSession();

		// 메소드 호출
		UserVO userVo = service.loginUser(vo);
		
		System.out.println(userVo);

		Gson gson = new Gson();

		String jsonStr = gson.toJson(userVo);
		System.out.println(jsonStr);

		// request.setAttribute("user", jsonStr);

		if (userVo != null) { // 로그인 성공
			// session에 정보 저장
			logSession.setAttribute("user", jsonStr);               
			logSession.setAttribute("check", "true");
		} else {
			// 로그인 실패
			logSession.setAttribute("check", "false");
		}

		response.getWriter().write(jsonStr);
		// request.getRequestDispatcher("/user/loginForm.jsp").forward(request,
		// response);
	}

}
