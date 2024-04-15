package ddit.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.UserVO;

@WebServlet("/chkIdMail.do")
public class ChkIdMail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String mail = request.getParameter("email");		
		System.out.println("아이디"+id);
		System.out.println("메일"+mail);
		
		UserVO vo = new UserVO();
		vo.setUser_id(id);
		vo.setUser_mail(mail);
		System.out.println(vo.getUser_id());
		System.out.println(vo.getUser_mail());
		
		IUserService service = UserServcieImpl.getInstance();
		
		int res = service.chkIdMail(vo);
		
		System.out.println(res);
		
		request.setAttribute("cnt", res);
		
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
		
		
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
