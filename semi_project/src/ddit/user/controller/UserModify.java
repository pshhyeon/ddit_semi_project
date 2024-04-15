package ddit.user.controller;


import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.JsonElement;

import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.UserVO;

@WebServlet("/userModify.do")
@MultipartConfig
public class UserModify extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// 업데이트 할 vo
		UserVO vo = new UserVO();
		
		// 세션
		HttpSession session = request.getSession();
		// 서비스
		IUserService service = UserServcieImpl.getInstance();
		
		try {
			BeanUtils.populate(vo, request.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
		// 프로필사진을 가져오기 위한 유저, 기존 것 사용하지 않은 이유는 비밀번호 바뀔 수 있기 때문
		UserVO thisUser = service.selectUser(vo.getUser_id());
		
		String uploadPath = "D:/semi_project/semi_project/WebContent/photo";

		File f = new File(uploadPath);
		
		String saveFileName = "";
		
		// 저장될 폴더가 없으면 새로 만들어 줌
		if(!f.exists()) {
			f.mkdirs();
		}
		
		for(Part part : request.getParts()) {
			// Upload한 파일명 구하기
			String fileName = extractFileName(part);
			// 찾는 파일명이 ""(blankSpace)이면 파일이 아닌 일반 데이터로 처리
			if(!"".equals(fileName)) { // 파일인지 검사
				
				saveFileName = UUID.randomUUID().toString() + "_" + fileName;
				
				try {
					// Part객체의 write() 메서드로 파일을 저장한다
					part.write(uploadPath + File.separator + saveFileName);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			} // if문 끝
		}
		
		if(saveFileName != "") {
			System.out.println("확인용 fileName "+saveFileName);
			vo.setUser_profile_name(saveFileName);
		} else {
			vo.setUser_profile_name(thisUser.getUser_profile_name());
		}
		
		session.invalidate();
		
		int res = service.modifyUser(vo);
		response.sendRedirect("index.jsp");
	}
	
	private String extractFileName(Part part) {
		String fileName = "";
		
		// 헤더의 키값이 'content-disposition'인 헤더의 value값 구하기
		String headerValue = part.getHeader("content-disposition");
		// content-disposition(header) : form-data; name="upFile1"; filename="test1.txt"라고 했을 때 ;를 기준으로 하나 씩 나눠 줌
		String[] itemArr = headerValue.split(";");
		// itemArr의 결과값 ["name='upFile1'" ,...]
		
		for(String item : itemArr) {
			// 공백 날리고 filename으로 시작하는 item을 찾는다
			if(item.trim().startsWith("filename")) {
				fileName = item.substring(item.indexOf('=') + 2, item.length() - 1);
			}
		}
		
		return fileName;
	}
}
