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


@WebServlet("/gongjiUpdate.do")
public class GongjiUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        request.setCharacterEncoding("UTF-8");
	        response.setCharacterEncoding("utf-8");
	        // 클라이언트로부터 전송된 데이터 가져오기
	        int party_gongji_no = Integer.parseInt(request.getParameter("party_gongji_no"));
	        String party_gongji_title = request.getParameter("party_gongji_title");
	        String party_gongji_content = request.getParameter("party_gongji_content");
	        System.out.println("party_gongji_no : "+party_gongji_no);
	        System.out.println("party_gongji_title : "+party_gongji_title);
	        System.out.println("party_gongji_content : "+party_gongji_content);
	        PartyGongjiVO vo = new PartyGongjiVO();
	        vo.setParty_gongji_no(party_gongji_no);
	        vo.setParty_gongji_title(party_gongji_title);
	        vo.setParty_gongji_content(party_gongji_content);
	        IPartyService service = PartyServiceImpl.getInstance();
	        int res = service.gongjiUpdate(vo);
	        request.setAttribute("cnt", res);
	        request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
