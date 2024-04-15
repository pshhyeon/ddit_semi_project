package ddit.party.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;

@WebServlet("/updatePartyStatus.do")
public class UpdatePartyStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// updatePartyStatus
		
		request.setCharacterEncoding("utf-8");
		String party_delyn = request.getParameter("party_delyn");
		int party_no = Integer.parseInt(request.getParameter("party_no"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("party_delyn", party_delyn);
		map.put("party_no", party_no);
		IPartyService service = PartyServiceImpl.getInstance();
		int res = service.updatePartyStatus(map);
		request.setAttribute("cnt", res);
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
	}

}
