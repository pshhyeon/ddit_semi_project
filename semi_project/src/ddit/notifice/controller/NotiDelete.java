package ddit.notifice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.notifice.service.INotificeService;
import ddit.notifice.service.NotificeServiceImpl;

@WebServlet("/notiDelete.do")
public class NotiDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int notiNo = Integer.parseInt(request.getParameter("notiNo"));
        
        INotificeService service = NotificeServiceImpl.getInstance();
        service.deleteNoti(notiNo); // 공지사항 번호를 이용하여 데이터베이스에서 해당 공지사항을 삭제하는 메소드를 호출합니다.
        
        response.sendRedirect("/semi_project/board/announcement.jsp"); // 삭제 후 공지사항 목록 페이지로 리다이렉트합니다.
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
