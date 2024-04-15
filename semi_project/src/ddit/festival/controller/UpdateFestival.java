package ddit.festival.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;

import ddit.festival.service.FestivalServiceImpl;
import ddit.festival.service.IFestivalService;
import ddit.vo.FestivalVO;

/**
 * Servlet implementation class FestivalList
 */
@WebServlet("/updateFestival.do")
public class UpdateFestival extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		IFestivalService service = FestivalServiceImpl.getInstance();

		//int fesNo = Integer.parseInt(request.getParameter("fesNo"));
		
		FestivalVO vo = new FestivalVO();
		
		try {
			BeanUtils.populate(vo, request.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
		System.out.println("업데이트 된 정보 : " + vo);
		
		int res = service.updateFestival(vo);

		request.setAttribute("cnt", res);
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
		
		//RequestDispatcher dispatcher = request.getRequestDispatcher("/festival/updateFestival.jsp");
		//dispatcher.forward(request, response);
		
		//response.sendRedirect("/festival/updateFestival.jsp");
		//request.getRequestDispatcher("/festival/updateFestival.jsp").forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
