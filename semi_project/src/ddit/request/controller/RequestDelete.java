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


@WebServlet("/requestDelete.do")
public class RequestDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		 int request_no = Integer.parseInt(request.getParameter("request_no"));
//		 int user_no = Integer.parseInt(request.getParameter("user_no")); //userNo
	      
		 System.out.println("�Ф�" +request_no);
//		 map.put("user_no", user_no);
//		 System.out.println("�Ф�" +user_no);
	      // service��ü
	      IRequestService service = RequestServiceImpl.getInstance();
	      
	      // �޼ҵ� ȣ��
	      int cnt= service.requestDelete(request_no);
	      System.out.println("���"+cnt);
	      
	      // request�� ����
	      request.setAttribute("cnt", cnt);
	      
	      // view������
	      request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
