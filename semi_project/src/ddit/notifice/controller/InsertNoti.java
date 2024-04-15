package ddit.notifice.controller;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ddit.notifice.service.INotificeService;
import ddit.notifice.service.NotificeServiceImpl;
import ddit.vo.NotificeVO;

@WebServlet("/insertNoti.do")
public class InsertNoti extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String title = request.getParameter("notiTitle");
		String content = request.getParameter("notiContent");
		
		NotificeVO vo = new NotificeVO();
		vo.setNotifice_title(title);
		vo.setNotifice_content(content);
		
		INotificeService service = NotificeServiceImpl.getInstance();
		
		int res = service.InsertNoti(vo);
		
		System.out.println("insert res---=="+res);
		request.setAttribute("res", res);
		
		response.sendRedirect(request.getContextPath() + "/board/announcement.jsp");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
