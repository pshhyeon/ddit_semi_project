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
 * Servlet implementation class PhotoCountUpdate
 */
@WebServlet("/photoCountUpdate.do")
public class PhotoCountUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	
		IPhotoService service = PhotoServiceImpl.getInstance();
		
		int res = service.photoCountUpdate(photoNo);
		
		request.setAttribute("cnt", res);
		
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
