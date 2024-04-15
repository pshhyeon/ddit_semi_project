package ddit.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.board.service.BoardServiceImpl;
import ddit.board.service.IBoardService;
import ddit.vo.BoardVO;
import ddit.vo.PageVO;

@WebServlet("/boardList.do")
public class BoardList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		//최초 실행시 page=1, category="", search=""
		int page = Integer.parseInt(request.getParameter("page"));
		String category = request.getParameter("category");
		String search = request.getParameter("search");
		
		IBoardService service = BoardServiceImpl.getInstance();
		
		PageVO vo = service.getPageInfo(page, category, search);
		//start, end, startPage, endPage, totalPage
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("category", category);
		map.put("search", search);
		map.put("start", vo.getStart());
		map.put("end", vo.getEnd());
		List<BoardVO> list = service.boardList(map);
//		System.out.println("카테고리"+map.get("category"));
//		System.out.println("검색어"+map.get("search"));
//		System.out.println("시작페이지"+map.get("start"));
//		System.out.println("끝페이지"+map.get("end"));
//		System.out.println(list.size());
		
		request.setAttribute("list", list);
		request.setAttribute("startpage", vo.getStartPage());
		request.setAttribute("endpage", vo.getEndPage());
		request.setAttribute("totalpage", vo.getTotalPage());
		
		request.getRequestDispatcher("/view/boardList.jsp").forward(request, response);
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
