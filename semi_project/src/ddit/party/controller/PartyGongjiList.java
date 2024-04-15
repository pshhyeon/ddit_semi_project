package ddit.party.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;
import ddit.vo.PageVO;
import ddit.vo.PartyGongjiVO;


@WebServlet("/partyGongjiList.do")
public class PartyGongjiList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int party_no = Integer.parseInt(request.getParameter("party_no"));
		int page = Integer.parseInt(request.getParameter("page"));
		String category = request.getParameter("category");
		String search = request.getParameter("search");
		System.out.println("party_no : "+ party_no);
		IPartyService service = PartyServiceImpl.getInstance();
		
		System.out.println("페이지 = "+page);
		
		PageVO vo = service.getPageInfo(page, category, search);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("category", category);
		map.put("search", search);
		map.put("start", vo.getStart());
		map.put("end", vo.getEnd());
		map.put("party_no", party_no);
		
		List<PartyGongjiVO> gongjiList = service.partygongjiList(map);
		request.setAttribute("startpage", vo.getStartPage());
		request.setAttribute("endpage", vo.getEndPage());
		request.setAttribute("totalpage", vo.getTotalPage());
		request.setAttribute("currentPage", page);
		
		System.out.println("리스트 크기"+gongjiList.size());
		
		request.setAttribute("list", gongjiList);
		request.getRequestDispatcher("/view/gongjiList.jsp").forward(request, response);
		
	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
