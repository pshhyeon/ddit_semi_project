package ddit.party.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;
import ddit.vo.PartyGongjiVO;


@WebServlet("/gongjiDelete.do")
public class GongjiDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int party_gongji_no = Integer.parseInt(request.getParameter("party_gongji_no"));
		IPartyService service = PartyServiceImpl.getInstance();
		int cnt  = service.gongjiDelete(party_gongji_no);
		request.setAttribute("cnt", cnt);
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
