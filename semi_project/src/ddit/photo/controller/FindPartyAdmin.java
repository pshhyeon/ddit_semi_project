package ddit.photo.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.photo.service.IPhotoService;
import ddit.photo.service.PhotoServiceImpl;

/**
 * Servlet implementation class FindPartyAdmin
 */
@WebServlet("/findPartyAdmin.do")
public class FindPartyAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int partyNo = Integer.parseInt(request.getParameter("partyNo"));
		
		IPhotoService service = PhotoServiceImpl.getInstance();
		
		int res = service.findPartyAdmin(partyNo);
		System.out.println("소모임 관리자 유저의 값은 ? "+res);
		
		request.setAttribute("partyAdminNo", res);
		request.getRequestDispatcher("view/findPartyAdmin.jsp").forward(request, response);
		
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
