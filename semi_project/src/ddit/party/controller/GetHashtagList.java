package ddit.party.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;
import ddit.vo.HashtagVO;

@WebServlet("/getHashtagList.do")
public class GetHashtagList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		IPartyService service = PartyServiceImpl.getInstance();
		List<HashtagVO> list = service.getHashtagList();
		request.setAttribute("list", list);
		request.getRequestDispatcher("/view/getHashtagList.jsp").forward(request, response);
		
	}

}
