package ddit.photo.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.photo.service.IPhotoService;
import ddit.photo.service.PhotoServiceImpl;

/**
 * Servlet implementation class ImageView
 */
@WebServlet("/imageView.do")
public class ImageView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getParameter("utf-8");
		String fileName = request.getParameter("filename");
		
		IPhotoService service = PhotoServiceImpl.getInstance();
		
		String uploadPath = "D:\\semi_project\\semi_project\\WebContent\\photo";
		
		File f= new File(uploadPath);
		
		File photoFile = new File(f, fileName);
		if(photoFile.exists()) {
			BufferedInputStream bin = null;
			BufferedOutputStream bout = null;
			try {
				bout = new BufferedOutputStream(response.getOutputStream());
				bin = new BufferedInputStream(new FileInputStream(photoFile));
				
				byte[] temp = new byte[1024];
				int len =0;
				while ((len=bin.read(temp))>0) {
					bout.write(temp,0,len);
				}
				bout.flush();
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if (bin != null) try { bin.close(); } catch (Exception e) { e.printStackTrace(); }
				if (bout != null) try { bin.close(); } catch (Exception e) { e.printStackTrace(); }
			}
			
		}
		
	
	
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
