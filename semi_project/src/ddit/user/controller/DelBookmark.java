package ddit.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;
import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.MarkVO;
import ddit.vo.Party_userVO;

@WebServlet("/delBookmark.do")
public class DelBookmark extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int party_no = Integer.parseInt(request.getParameter("party_no"));
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		
		MarkVO vo = new MarkVO();
		vo.setParty_no(party_no);
		vo.setUser_no(user_no);
		
		IUserService service = UserServcieImpl.getInstance();
		int res = service.delBookmark(vo);
		
		request.setAttribute("cnt", res);
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
	}

}
