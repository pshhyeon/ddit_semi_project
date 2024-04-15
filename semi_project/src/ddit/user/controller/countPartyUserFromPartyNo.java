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
import ddit.vo.Party_userVO;

@WebServlet("/countPartyUserFromPartyNo.do")
public class countPartyUserFromPartyNo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		IUserService service = UserServcieImpl.getInstance();
		List res = service.countPartyUserFromPartyNo();
		
		System.out.println(res);
		
		Gson gson = new Gson();

		String jsonStr = gson.toJson(res);
		System.out.println(jsonStr);

		response.getWriter().write(jsonStr);
	}

}
