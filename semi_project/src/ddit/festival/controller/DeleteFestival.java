package ddit.festival.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;

import ddit.festival.service.FestivalServiceImpl;
import ddit.festival.service.IFestivalService;
import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.FestivalVO;

/**
 * Servlet implementation class FestivalList
 */
@WebServlet("/deleteFestival.do")
public class DeleteFestival extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		int fesNo = Integer.parseInt(request.getParameter("currentFesNo"));
		
		IFestivalService service = FestivalServiceImpl.getInstance();
		
		int res = service.deleteFestival(fesNo);
		System.out.println("삭제 결과 : " +res);
		request.setAttribute("cnt", res);
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
