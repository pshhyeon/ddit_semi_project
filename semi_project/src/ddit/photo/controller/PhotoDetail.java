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

@WebServlet("/photoDetail.do")
public class PhotoDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int photoNo = Integer.parseInt(request.getParameter("photoNo"));
		System.out.println("포토번호  :ㅣ "+photoNo);
		IPhotoService service = PhotoServiceImpl.getInstance();
		
		PhotoVO pvo = service.photoDetail(photoNo);
		System.out.println(" 파티넘버"+pvo.getParty_no());
		System.out.println("포토넘버"+pvo.getPhoto_content());
		System.out.println("찐포토넘버"+pvo.getPhoto_no());
		System.out.println("닉네임 : "+pvo.getNickname());
		
		request.setAttribute("pvo", pvo);
		request.getRequestDispatcher("/view/photoDetail.jsp").forward(request, response);;
				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
