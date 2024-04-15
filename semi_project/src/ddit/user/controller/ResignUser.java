package ddit.user.controller;

import java.io.IOException;
import java.util.List;

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

@WebServlet("/resignUser.do")
public class ResignUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		int userNo = Integer.parseInt(request.getParameter("userNo"));
		System.out.println("유저넘버 확인 : " + userNo);
		
		IUserService service = UserServcieImpl.getInstance();
		int res1 = service.resignUser(userNo);
		int res2 = service.resignPartyUserUpdate(userNo);
		int res3 = service.resignPartyUserDelete(userNo);
		
		HttpSession session = request.getSession();
		session.invalidate();
	}
}
