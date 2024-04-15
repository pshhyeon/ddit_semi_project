package ddit.notifice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.board.service.BoardServiceImpl;
import ddit.board.service.IBoardService;
import ddit.notifice.service.INotificeService;
import ddit.notifice.service.NotificeServiceImpl;
import ddit.vo.NotificeVO;

@WebServlet("/updateNoti.do")
public class UpdateNoti extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
		
		String title =request.getParameter("title");
		String content = request.getParameter("content");
		int notiNo = Integer.parseInt(request.getParameter("notiNo"));
		
		NotificeVO vo = new NotificeVO();
		vo.setNotifice_title(title);
		vo.setNotifice_content(content);
		vo.setNotifice_no(notiNo);
		
		INotificeService service = NotificeServiceImpl.getInstance();
		
		int res = service.updateNoti(vo);
		
		request.setAttribute("cnt", res);
		
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
