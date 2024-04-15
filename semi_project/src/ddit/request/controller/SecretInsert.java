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


@WebServlet("/secretInsert.do")
public class SecretInsert extends HttpServlet {
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
		//유저정보를 가저올떄 vo가 다를때 map을 사용해서 put하자 
		//주의할점 value값이 mapper에 데이터값과 이름이 일치해야한다
		
		

		
		//System.out.println(map);
		

		IRequestService service = RequestServiceImpl.getInstance();
		int cnt = service.secretInsert(map);
		request.setAttribute("cnt", cnt);
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
