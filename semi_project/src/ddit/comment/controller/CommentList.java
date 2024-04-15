package ddit.comment.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.comment.service.CommentServiceImpl;
import ddit.comment.service.ICommentService;
import ddit.vo.CommentVO;

@WebServlet("/commentList.do")
public class CommentList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		System.out.println("보드넘버 : "+boardNo);
		
		ICommentService service = CommentServiceImpl.getInstance();
		
		List<CommentVO> commentList = service.commentList(boardNo);
		List<CommentVO> nicknameList = service.listNicknameInfo(boardNo);
		System.out.println("코멘트리스트 사이즈 "+commentList.size());
		System.out.println("닉네임리스트 사이즈 "+nicknameList.size());
		
		request.setAttribute("list", commentList);
		request.setAttribute("nicknameList", nicknameList);
		
		request.getRequestDispatcher("/view/commentList.jsp").forward(request, response);
			
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
