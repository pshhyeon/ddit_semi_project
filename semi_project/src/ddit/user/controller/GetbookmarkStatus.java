package ddit.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.MarkVO;

@WebServlet("/getbookmarkStatus.do")
public class GetbookmarkStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		int party_no = Integer.parseInt(request.getParameter("party_no"));
		System.out.println("파라미터 유저번호 : " + user_no);
		System.out.println("파라미터 파티번호 : " + party_no);
		MarkVO vo = new MarkVO();
		vo.setUser_no(user_no);
		vo.setParty_no(party_no);
		System.out.println("@@@GetbookmarkStatus 파라미터로 설정한vo ==> " + vo);
		
		IUserService service = UserServcieImpl.getInstance();
		
		MarkVO mvo = service.getbookmarkStatus(vo);
		System.out.println("@@@GetbookmarkStatus 결과 받은mvo ==> " + mvo);
		request.setAttribute("vo", mvo);
		
		request.getRequestDispatcher("/view/getbookmarkStatus.jsp").forward(request, response);
	}

}
