package ddit.board.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/boardFileDownload.do")
public class BoardFileDownload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		
		String fileName =request.getParameter("filename");
		System.out.println(fileName);
		String UploadPath = "D:\\semi_project\\semi_project\\WebContent\\file";
		int res = 0;
		
		File f = new File(UploadPath);
		File downFile = new File(f,fileName);
		
		if(downFile.exists()) {
			response.setContentType("application/octet-stream; charset=utf-8");
			
			// Response 객체의 Header에 'content-disposition'속성을 설정한다.
			String headKey = "content-disposition";
			
			// 한글일 경우 설정
			String headValue = "attachment; filename*=UTF-8''" 
						+ URLEncoder.encode(fileName, "utf-8").replace("\\+", "%20"); // replace("\\+", "%20") >> 공백을 코드값으로 표시해라
			response.setHeader(headKey, headValue);
			
			// 서버에 저장된 파일을 읽어서 클라이언트로 전송한다.
			BufferedInputStream bin = null;
			BufferedOutputStream bout = null;
			
			try {
				bout = new BufferedOutputStream(response.getOutputStream());
				bin = new BufferedInputStream(new FileInputStream(downFile));
				byte[] temp = new byte[1024];
				int len = 0;
				while ((len = bin.read(temp)) > 0) {
					bout.write(temp, 0, len);					
				}
				bout.flush();
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if (bin != null) try { bin.close(); } catch (Exception e) { e.printStackTrace(); }
				if (bout != null) try { bin.close(); } catch (Exception e) { e.printStackTrace(); }
			}
			
		} else {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().println("<h3>" + fileName + "파일이 존재하지 않습니다.</h3>");
		}
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
