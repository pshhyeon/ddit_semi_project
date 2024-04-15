package ddit.photo.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.photo.service.IPhotoService;
import ddit.photo.service.PhotoServiceImpl;
import ddit.vo.PhotoVO;

/**
 * Servlet implementation class PhotoUpdate
 */
@WebServlet("/photoUpdate.do")
public class PhotoUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int photoNo = Integer.parseInt(request.getParameter("photoNo"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		System.out.println("포토넘버 : "+photoNo);
		System.out.println("타이틀 : "+title);
		System.out.println("내용 : "+content);
		
		PhotoVO vo = new PhotoVO();
		vo.setPhoto_no(photoNo);
		vo.setPhoto_title(title);
		vo.setPhoto_content(content);
		
		IPhotoService service = PhotoServiceImpl.getInstance();
		
		int res = service.photoUpdate(vo);
		
		request.setAttribute("cnt", res);
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
		
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
