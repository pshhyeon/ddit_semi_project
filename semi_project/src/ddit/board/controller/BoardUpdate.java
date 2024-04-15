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

/**
 * Servlet implementation class BoardUpdate
 */
@WebServlet("/boardUpdate.do")
public class BoardUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String title =request.getParameter("title");
		String content = request.getParameter("content");
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		BoardVO vo = new BoardVO();
		vo.setBoard_title(title);
		vo.setBoard_content(content);
		vo.setBoard_no(boardNo);
		
		IBoardService service = BoardServiceImpl.getInstance();
		
		int res = service.boardUpdate(vo);
		
		request.setAttribute("cnt", res);
		
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
		
		
		
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
