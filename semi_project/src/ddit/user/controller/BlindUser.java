package ddit.user.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.UserVO;

@WebServlet("/blindUser.do")
public class BlindUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		int userNo = Integer.parseInt(request.getParameter("userNo"));

		IUserService service = UserServcieImpl.getInstance();
		int res = service.blindUser(userNo);
		System.out.println(res);
	}
}
