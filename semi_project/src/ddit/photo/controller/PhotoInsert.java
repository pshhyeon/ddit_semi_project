package ddit.photo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import ddit.photo.service.IPhotoService;
import ddit.photo.service.PhotoServiceImpl;
import ddit.vo.PhotoVO;

@WebServlet("/photoInsert.do")
@MultipartConfig
public class PhotoInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PhotoVO vo = new PhotoVO();
		IPhotoService service = PhotoServiceImpl.getInstance();
		
		String title = request.getParameter("photointitle");
		String content = request.getParameter("photoincon");
		int userNo = Integer.parseInt(request.getParameter("userno"));
		int partyNo = Integer.parseInt(request.getParameter("partyno"));
		System.out.println("유저 : "+userNo);
		System.out.println("파티넘버 : "+partyNo);
		
		Part photoPart = request.getPart("photoinfile");
		String photoName = photoPart.getSubmittedFileName();
		String savePhotoName = UUID.randomUUID().toString()+"_"+photoName;
		String photoPath = "D:\\semi_project\\semi_project\\WebContent\\photo"+File.separator+savePhotoName;
		
		try (InputStream is = photoPart.getInputStream();
					OutputStream os = new FileOutputStream(photoPath)){
			byte[] buffer = new byte[1024];
			int bytesRead;
			while((bytesRead = is.read(buffer))!= -1) {
				os.write(buffer, 0, bytesRead);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(photoName ==null) {
			photoName = "";
		}
		System.out.println("사진이름은 ? :"+photoName);
		vo.setPhoto_title(title);
		vo.setPhoto_content(content);
		vo.setPhoto_filename(savePhotoName);
		vo.setParty_no(partyNo);
		vo.setUser_no(userNo);
		
		int res = service.photoInsert(vo);
		System.out.println("집어넣기 성공 ㅋㅋ");
		request.setAttribute("cnt", res);
		request.setAttribute("selectedPartyNo",partyNo);
		
		request.getRequestDispatcher("party/partyPhoto.jsp?selectedPartyNo="+partyNo).forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
