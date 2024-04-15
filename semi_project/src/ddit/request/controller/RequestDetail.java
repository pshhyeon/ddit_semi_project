package ddit.request.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.request.service.IRequestService;
import ddit.request.service.RequestServiceImpl;
import ddit.vo.RequestVO;


@WebServlet("/requestDetail.do")
public class RequestDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int requestNo = Integer.parseInt(request.getParameter("rindex"));
		
		IRequestService service = RequestServiceImpl.getInstance();
		RequestVO vo = service.requestDetail(requestNo);
		request.setAttribute("vo", vo);
		request.getRequestDispatcher("/request/requestDetail.jsp").forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

