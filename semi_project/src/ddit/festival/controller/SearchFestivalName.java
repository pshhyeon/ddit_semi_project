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

/**
 * Servlet implementation class FestivalList
 */
@WebServlet("/searchFestivalName.do")
public class SearchFestivalName extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String fesName = request.getParameter("fesName");
		System.out.println(fesName);
		
		IFestivalService service = FestivalServiceImpl.getInstance();
		List<FestivalVO> festivalList = service.searchFestivalName(fesName);
		
		//System.out.println(festivalList);
		
		Gson gson = new Gson();
		String searchStr = gson.toJson(festivalList);
		request.setAttribute("festivalList", searchStr);
		
		response.getWriter().write(searchStr);
		//request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
