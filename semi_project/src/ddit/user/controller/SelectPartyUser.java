package ddit.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.Party_userVO;

@WebServlet("/selectPartyUser.do")
public class SelectPartyUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		//int userNo = Integer.parseInt(request.getParameter("userNo"));

		IUserService service = UserServcieImpl.getInstance();
		List<Party_userVO> vo = service.selectPartyUser();
		
		Gson gson = new Gson();

		String jsonStr = gson.toJson(vo);
		System.out.println(jsonStr);

		response.getWriter().write(jsonStr);
	}

}
