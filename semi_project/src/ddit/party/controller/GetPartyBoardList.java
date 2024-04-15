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

@WebServlet("/getPartyBoardList.do")
public class GetPartyBoardList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int page = Integer.parseInt(request.getParameter("page"));
		String sType = request.getParameter("stype");
		String sWord = request.getParameter("sword");
		
		System.out.println("@@getPartyList.servlet@@stype ==> " + sType);
		System.out.println("@@getPartyList.servlet@@sword ==> " + sWord);
		
		IPartyService service = PartyServiceImpl.getInstance();
		
		PageVO vo = service.getPageInfo(page, sType, sWord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stype", sType);
		map.put("sword", sWord);
		map.put("start", vo.getStart());
		map.put("end", vo.getEnd());
		
		List<Map<String, Object>> list = service.getPartyBoardList(map);
		
		request.setAttribute("list", list);
		request.setAttribute("startp", vo.getStartPage());
		request.setAttribute("endp", vo.getEndPage());
		request.setAttribute("totalp", vo.getTotalPage());
		
		request.getRequestDispatcher("/view/partyMainList.jsp").forward(request, response);
		
	}

}
