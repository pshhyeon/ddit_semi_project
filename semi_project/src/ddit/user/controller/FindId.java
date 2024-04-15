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


@WebServlet("/findId.do")
public class FindId extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		 String userName = request.getParameter("username");
	     String userMail = request.getParameter("usermail");
	     
	     System.out.println(userName);
	     System.out.println(userMail);
	     
	     IUserService service = UserServcieImpl.getInstance();
	     
	     UserVO Vo = new UserVO();
	     Vo.setUser_name(userName);
	     Vo.setUser_mail(userMail);
	     
	     String id = "";
	     UserVO tempVo = service.findUserId(Vo);
	     if (tempVo != null) id = tempVo.getUser_id();
	     System.out.println("vo설정 후 id => " + tempVo);
	     
	     
	     //결거값을 request에 저자 ㅇ
	     request.setAttribute("idvalue", id);
	     
	     //view펭;ㅈ;로 이동 
	     request.getRequestDispatcher("/view/findUserId.jsp").forward(request, response);
	     
	     
	     
	     
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
