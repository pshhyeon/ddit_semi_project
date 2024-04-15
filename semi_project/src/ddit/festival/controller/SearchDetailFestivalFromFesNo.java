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
@WebServlet("/searchDetailFestivalFromFesNo.do")
public class SearchDetailFestivalFromFesNo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		int fesNo = Integer.parseInt(request.getParameter("fesNo"));
		
		IFestivalService service = FestivalServiceImpl.getInstance();
		FestivalVO fesVo = service.detailFestival(fesNo);
		
		Gson gson = new Gson();
		String detailFes = gson.toJson(fesVo);
		response.getWriter().write(detailFes);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
