package ddit.party.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;

@WebServlet("/getPartyDetail.do")
public class GetPartyDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int party_no = Integer.parseInt(request.getParameter("party_no"));
		
		IPartyService service = PartyServiceImpl.getInstance();
		
		Map<String, Object> map =  service.getPartydetail(party_no);
		
		request.setAttribute("partyDetail", map);
		
		request.getRequestDispatcher("/view/partyDetail.jsp").forward(request, response);
	}
	
	

}
