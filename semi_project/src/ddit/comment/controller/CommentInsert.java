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

/**
 * Servlet implementation class CommentInsert
 */
@WebServlet("/commentInsert.do")
public class CommentInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String content = request.getParameter("content");
		System.out.println("내용"+content);
		int boardNo =Integer.parseInt(request.getParameter("boardNo"));
		System.out.println("게시판번호"+boardNo);
		int userNo =Integer.parseInt(request.getParameter("userNo"));
		System.out.println("로그인한넘"+userNo);
		
		CommentVO vo = new CommentVO();
		vo.setComments_con(content);
		System.out.println(vo.getComments_con());
		vo.setBoard_no(boardNo);
		vo.setUser_no(userNo);
		
		ICommentService service = CommentServiceImpl.getInstance();
		
		int res = service.insertComment(vo);
		
		request.setAttribute("cnt", res);
		
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
		
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
