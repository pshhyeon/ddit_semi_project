package ddit.board.controller;

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

import ddit.board.service.BoardServiceImpl;
import ddit.board.service.IBoardService;
import ddit.vo.BoardVO;

/**
 * Servlet implementation class BoardInsert
 */
@WebServlet("/boardInsert.do")
@MultipartConfig
public class BoardInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		BoardVO vo = new BoardVO();
		IBoardService service = BoardServiceImpl.getInstance();
		
		String title = request.getParameter("boardTitle");
		String content = request.getParameter("boardContent");
		int userNo = Integer.parseInt(request.getParameter("user"));
		//파일 파트 가져오기
		
		
		
		Part filePart = request.getPart("file");
		String fileName = filePart.getSubmittedFileName();
		String saveFileName = "";
		if(fileName !=null && !fileName.isEmpty()) {
			
			saveFileName = UUID.randomUUID().toString()+"_"+fileName;
			String filePath = "D:\\semi_project\\semi_project\\WebContent\\file"+File.separator+saveFileName;
			
			try 
			(InputStream is = filePart.getInputStream();
					OutputStream os = new FileOutputStream(filePath))
			{byte[] buffer = new byte[1024];
			int bytesRead;
			while((bytesRead = is.read(buffer)) != -1) {
				os.write(buffer, 0, bytesRead);
			}
			
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		System.out.println("파일이름은?"+saveFileName);
		vo.setBoard_title(title);
		vo.setBoard_content(content);
		vo.setBoard_file_name(saveFileName);
		vo.setUser_no(userNo);
		System.out.println("vo저장된파일명"+vo.getUser_no());
		System.out.println("제목"+vo.getBoard_title());
		System.out.println("내용"+vo.getBoard_content());
		System.out.println("제목"+vo.getBoard_file_name());
		System.out.println("유저"+vo.getUser_no());
		
		
		int res = service.boardInsert(vo);
		
		
//		request.getRequestDispatcher("/board/freeBoard.jsp").forward(request, response);
		
			
		response.sendRedirect(request.getContextPath()+"/board/freeBoard.jsp");
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
