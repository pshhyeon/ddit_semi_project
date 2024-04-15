package ddit.request.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ddit.request.service.IRequestService;
import ddit.request.service.RequestServiceImpl;
import ddit.vo.ReplyVO;
import ddit.vo.RequestVO;


@WebServlet("/replyList.do")
public class ReplyList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
        int request_no = Integer.parseInt(request.getParameter("requestNo"));
        System.out.println(request_no);
        IRequestService service  = RequestServiceImpl.getInstance();
        
			System.out.println(request_no);
			List<ReplyVO> reply = service.replyList(request_no);
	        Gson gson = new Gson();
	        String jsonReplyList = gson.toJson(reply);

	        PrintWriter out = response.getWriter();
	        out.print(jsonReplyList);
	        out.flush();
	        
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
