package ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.board.service.BoardServiceImpl;
import ddit.board.service.IBoardService;
import ddit.vo.BoardVO;

@WebServlet("/boardDetail.do")
public class BoardDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		int boardNo = Integer.parseInt(request.getParameter("bindex"));
		
		IBoardService service = BoardServiceImpl.getInstance();
		
		BoardVO vo = service.boardDetail(boardNo);
		
		request.setAttribute("vo", vo);
		request.getRequestDispatcher("/board/freeBoardDetail.jsp").forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
