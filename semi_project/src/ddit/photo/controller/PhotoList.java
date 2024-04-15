package ddit.photo.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.photo.service.IPhotoService;
import ddit.photo.service.PhotoServiceImpl;
import ddit.vo.PhotoVO;

/**
 * Servlet implementation class PhotoList
 */
@WebServlet("/photoList.do")
public class PhotoList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int partyNo = Integer.parseInt(request.getParameter("partyNo"));
		
		IPhotoService service = PhotoServiceImpl.getInstance();
		
		List<PhotoVO> list = service.photoList(partyNo);
		
		
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("/view/photoList.jsp").forward(request, response);
	
				
				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
