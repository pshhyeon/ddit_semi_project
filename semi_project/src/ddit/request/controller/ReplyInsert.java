package ddit.request.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.request.service.IRequestService;
import ddit.request.service.RequestServiceImpl;
import ddit.vo.ReplyVO;


@WebServlet("/replyInsert.do")
public class ReplyInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String reply_title = request.getParameter("reply_title");
		String reply_content = request.getParameter("reply_content");
		int request_no = Integer.parseInt(request.getParameter("request_no"));
		
		System.out.println(reply_title);
		System.out.println(reply_content);
		System.out.println(request_no);
		ReplyVO vo = new ReplyVO();
		vo.setReply_title(reply_title);
		vo.setReply_content(reply_content);
		vo.setRequest_no(request_no);
		IRequestService service = RequestServiceImpl.getInstance();
		int cnt = service.replyInsert(vo);
		request.setAttribute("cnt", cnt);
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
