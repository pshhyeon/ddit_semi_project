package ddit.comment.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.comment.service.CommentServiceImpl;
import ddit.comment.service.ICommentService;

@WebServlet("/commentDelete.do")
public class CommentDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int commentNo = Integer.parseInt(request.getParameter("commentNo"));
		System.out.println("comment번호"+commentNo);
		
		
		ICommentService service = CommentServiceImpl.getInstance();
		int res = service.deleteComment(commentNo);
		
		request.setAttribute("cnt", res);
		
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
