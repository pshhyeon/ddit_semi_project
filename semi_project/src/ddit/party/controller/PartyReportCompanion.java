package ddit.party.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;
import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.PartyReportVO;
import ddit.vo.UserVO;

@WebServlet("/partyReportCompanion.do")
public class PartyReportCompanion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		int reportNo = Integer.parseInt(request.getParameter("reportNo"));
		
		IPartyService service = PartyServiceImpl.getInstance();
		
		int res = service.partyReportCompanion(reportNo);
		System.out.println(res);
	}
}
