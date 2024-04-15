package ddit.party.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;
import ddit.vo.Party_userVO;

@WebServlet("/delJoinParty.do")
public class DelJoinParty extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int party_no = Integer.parseInt(request.getParameter("party_no"));
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		
		Party_userVO vo = new Party_userVO();
		vo.setParty_no(party_no);
		vo.setUser_no(user_no);
		
		IPartyService service = PartyServiceImpl.getInstance();
		int res = service.delJoinParty(vo);
		
		request.setAttribute("cnt", res);
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
		
	}

}
