package ddit.notifice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.notifice.service.INotificeService;
import ddit.notifice.service.NotificeServiceImpl;
import ddit.vo.NotificeVO;

@WebServlet("/notiDetail.do")
public class NotiDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		int notiNo = Integer.parseInt(request.getParameter("bindex"));
		
		INotificeService service = NotificeServiceImpl.getInstance();
		
		//상세 화면 볼 때  hit수 1 증가
		int result = service.getNotiHit(notiNo);
		System.out.println("NotiDetail->result : " + result);
		
		NotificeVO vo = service.notiDetail(notiNo);
		
		request.setAttribute("vo", vo);
		request.getRequestDispatcher("/board/notiDetail.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
