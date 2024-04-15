package ddit.party.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;
import ddit.vo.PartyGongjiVO;


@WebServlet("/gongjiInsert.do")
public class GongjiInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
		 int party_no = Integer.parseInt(request.getParameter("party_no"));
		 String party_gongji_title = request.getParameter("party_gongji_title");
		 String party_gongji_content = request.getParameter("party_gongji_content");
		 System.out.println("party_no : "+party_no);
		 System.out.println("party_gongji_title : "+party_gongji_title);
		 System.out.println("party_gongji_content : "+party_gongji_content);
		PartyGongjiVO vo = new PartyGongjiVO();
		vo.setParty_no(party_no);
		vo.setParty_gongji_title(party_gongji_title);
		vo.setParty_gongji_content(party_gongji_content);
		IPartyService service = PartyServiceImpl.getInstance();
		int res = service.gongjiInsert(vo);
		request.setAttribute("cnt", res);
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
