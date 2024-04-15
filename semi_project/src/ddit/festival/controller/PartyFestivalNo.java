package ddit.festival.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ddit.festival.service.FestivalServiceImpl;
import ddit.festival.service.IFestivalService;
import ddit.vo.FestivalVO;
import ddit.vo.PartyVO;

/**
 * Servlet implementation class FestivalList
 */
@WebServlet("/partyFestivalNo.do")
public class PartyFestivalNo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		
		IFestivalService service = FestivalServiceImpl.getInstance();
		List<PartyVO> partyList = service.partyFromFestivalNo(1);
		
		System.out.println(partyList);
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(partyList);
		//request.setAttribute("festivalList", jsonStr);
		
		//response.getWriter().write(jsonStr);
		//request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
