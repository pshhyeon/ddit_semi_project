package ddit.mark.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import ddit.mark.service.IMarkService;
import ddit.mark.service.MarkServiceImpl;
import ddit.vo.MarkVO;
import ddit.vo.UserVO;
import ddit.vo.ZzimVO;


@WebServlet("/markList.do")
public class MarkList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		response.setContentType("application/json; charset=utf-8");

		int userNo = Integer.parseInt(request.getParameter("userno"));
		
		IMarkService service = MarkServiceImpl.getInstance();
		
		List<ZzimVO> zzimList = service.getAllMark(userNo);
		
		for (ZzimVO zzimVO : zzimList) {
			System.out.println("@@markList.java ==> " + zzimVO);
		}
		
		Gson gson = new Gson();
		String zzimVoJson = gson.toJson(zzimList);
		
		response.getWriter().write(zzimVoJson);
		
		response.flushBuffer();

		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
