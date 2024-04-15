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

@WebServlet("/getUserPartystatus.do")
public class GetUserPartystatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		int party_no = Integer.parseInt(request.getParameter("party_no"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("party_no", party_no);
		System.out.println("@getPartyStatus.java@파라미터로 받은 map ==> " + map);
		
		IPartyService service = PartyServiceImpl.getInstance();
		
		int res = service.getUserPartystatus(map);
		System.out.println("@getPartyStatus.java@결과servlet res val ==>" + res);
		
		request.setAttribute("userPartystatus", res);
		
		request.getRequestDispatcher("/view/userPartystatus.jsp").forward(request, response);
	}

}
