package ddit.comment.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.comment.service.CommentServiceImpl;
import ddit.comment.service.ICommentService;
import ddit.vo.CommentVO;

@WebServlet("/commentUpdate.do")
public class CommentUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String commentCon = request.getParameter("commentCon");
		int commentNo = Integer.parseInt(request.getParameter("commentNo"));
		
		CommentVO vo = new CommentVO();
		
		vo.setComments_no(commentNo);
		vo.setComments_con(commentCon);
		
		ICommentService service = CommentServiceImpl.getInstance();
		
		int res = service.updateComment(vo);
		
		request.setAttribute("cnt", res);
		
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	
	
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
