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

@WebServlet("/insertPartyReport.do")
public class InsertPartyReport extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String party_report_content = request.getParameter("party_report_content");
		int party_no = Integer.parseInt(request.getParameter("party_no"));
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("party_report_content", party_report_content);
		map.put("party_no", party_no);
		map.put("user_no", user_no);
		
		IPartyService service = PartyServiceImpl.getInstance();
		int res = service.insertPartyReport(map);
		request.setAttribute("cnt", res);
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
	}

}
