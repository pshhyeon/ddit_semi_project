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


@WebServlet("/replyUpdate.do")
public class ReplyUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        int request_no =  Integer.parseInt(request.getParameter("request_no"));
        String reply_title = request.getParameter("reply_title");
        String reply_content = request.getParameter("reply_content");
        System.out.println("request_no : "+request_no);
        System.out.println("reply_title : "+reply_title);
        System.out.println("reply_content : "+reply_content);
        ReplyVO vo = new ReplyVO();
        vo.setRequest_no(request_no);
        vo.setReply_title(reply_title);
        vo.setReply_content(reply_content);
        IRequestService service = RequestServiceImpl.getInstance();
        int res = service.replyUpdate(vo);
        request.setAttribute("cnt", res);
        request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
