package ddit.party.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;

@WebServlet("/getAllPartyUserList.do")
public class GetAllPartyUserList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int party_no = Integer.parseInt(request.getParameter("party_no"));
		IPartyService service = PartyServiceImpl.getInstance();
		List<Map<String, Object>> list = service.getAllPartyUserList(party_no);
		request.setAttribute("list", list);
		request.getRequestDispatcher("view/getAllPartyUserList.jsp").forward(request, response);
	}

}
