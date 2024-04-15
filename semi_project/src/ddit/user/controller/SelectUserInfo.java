package ddit.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.UserVO;

@WebServlet("/selectUserInfo.do")
public class SelectUserInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		IUserService service = UserServcieImpl.getInstance();
		UserVO vo = service.selectUserInfo(user_no);
		request.setAttribute("vo", vo);
		request.getRequestDispatcher("view/selectUserInfo.jsp").forward(request, response);
	}

}
