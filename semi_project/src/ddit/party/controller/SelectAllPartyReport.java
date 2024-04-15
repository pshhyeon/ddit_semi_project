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
import ddit.vo.PartyReportVO;

@WebServlet("/selectAllPartyReport.do")
public class SelectAllPartyReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		
		IPartyService service = PartyServiceImpl.getInstance();
		
		List<PartyReportVO> vo = service.selectAllPartyReport();
		
		Gson gson = new Gson();

		String jsonStr = gson.toJson(vo);
		System.out.println(jsonStr);

		response.getWriter().write(jsonStr);
	}

}
