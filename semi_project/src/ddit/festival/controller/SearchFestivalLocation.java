package ddit.festival.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
@WebServlet("/searchFestivalLocation.do")
public class SearchFestivalLocation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String fesName = request.getParameter("fesLocation");
		String sido = request.getParameter("sido");
		String gugun = request.getParameter("gugun");
		System.out.println(fesName);
		System.out.println(sido);
		System.out.println(gugun);
		
		Map<String,String> locationSearch = new HashMap<String,String>();
		
		locationSearch.put("title",fesName);
		
		if(sido == null || sido == "모든 시/도") {
			locationSearch.put("sido","");
		}else {
			locationSearch.put("sido",sido);
		}
		if(gugun == null) {
			locationSearch.put("gugun","");
		}else {
			locationSearch.put("gugun",gugun);
		}
		
		System.out.println(locationSearch);
		// 이후 매퍼수정 해야함, 시도와 구군을 festival_addr에 둘다 포함하게 찾아야 함
		
		
		IFestivalService service = FestivalServiceImpl.getInstance();
		List<FestivalVO> festivalList = service.searchFestivalLocation(locationSearch);
		
		System.out.println("지역검색 결과 :" + festivalList);

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
