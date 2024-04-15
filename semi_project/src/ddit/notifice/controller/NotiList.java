package ddit.notifice.controller;

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
import ddit.notifice.service.INotificeService;
import ddit.notifice.service.NotificeServiceImpl;
import ddit.vo.BoardVO;
import ddit.vo.NotificeVO;
import ddit.vo.PageVO;
import ddit.vo.UserVO;


@WebServlet("/notiList.do")
public class NotiList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		//최초 실행시 page=1, category="", search=""
		int page = Integer.parseInt(request.getParameter("page"));
		String category = request.getParameter("category");
		String search = request.getParameter("search");
		
		INotificeService service = NotificeServiceImpl.getInstance();
		
		PageVO vo = service.getPageInfo(page, category, search);
		//start, end, startPage, endPage, totalPage
	
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("category", category);
		map.put("search", search);
		map.put("start", vo.getStart());
		map.put("end", vo.getEnd());
		List<NotificeVO> list = service.getAllBoard(map);
		
		request.setAttribute("list", list);
		request.setAttribute("startpage", vo.getStartPage());
		request.setAttribute("endpage", vo.getEndPage());
		request.setAttribute("totalpage", vo.getTotalPage());
		
		request.getRequestDispatcher("/view/notiList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
