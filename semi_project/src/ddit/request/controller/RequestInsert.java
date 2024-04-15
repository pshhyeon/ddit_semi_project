 package ddit.request.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.request.service.IRequestService;
import ddit.request.service.RequestServiceImpl;
import ddit.vo.RequestVO;


@WebServlet("/requestInsert.do")
public class RequestInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String request_title = request.getParameter("title");
		String request_content = request.getParameter("content");
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		Map<String, Object > map = new HashMap<String, Object>();
		map.put("request_title",request_title);
		map.put("request_content", request_content);
		map.put("user_no", user_no);
		//System.out.println(map);
		

		IRequestService service = RequestServiceImpl.getInstance();
		int cnt = service.requestInsert(map);
		request.setAttribute("cnt", cnt);
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
