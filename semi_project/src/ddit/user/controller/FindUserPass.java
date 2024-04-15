package ddit.user.controller;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ddit.user.service.IUserService;
import ddit.user.service.UserServcieImpl;
import ddit.vo.UserVO;

@WebServlet("/findUserPass.do")
public class FindUserPass extends HttpServlet {
	static Properties prop;
	static Session session; //이메일을 보내고 받기 위한 세션 ,인증 정보와 프로퍼티 설정
	static MimeMessage message; //이메일의 내용 표시 / 제목,본문,수신자,발신자 등 설정 가능
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		System.out.println("받는사람 아이디 : "+id);
		String mail = request.getParameter("email");
		System.out.println("받는사람 메일주소 : "+mail);
		
		//받는사람이 될거임
		
		IUserService service = UserServcieImpl.getInstance();
		UserVO vo = new UserVO();
		vo.setUser_id(id);
		vo.setUser_mail(mail);
		
		
		String pass = service.findUserPass(vo);
		
		int res = 0;
		if(pass!=null) {
			res = 1;
			
			//네이버 smtp 정보
			final String user = "pgt8122@gmail.com";
			final String password = "obrs vfcn vhia jmzg";
			prop = new Properties();
			//gmail을 사용할 대는 "smtp.gmail.com", 네이버를 사용할 대는 "smtp.naver.com"
			prop.put("mail.smtp.host", "smtp.gmail.com");
			//"mail.smtp.port"는 SMTP서버와 통신하는 포트를 말함
			prop.put("mail.smtp.port", 465);
			//auth는 이메일을 보내기 위해 smtp서버에 사용자 인증이 필요한지 나타내는것.
			prop.put("mail.smtp.auth", "true");
			//ssl.enable ssl을ㅇ 사용하여 smtp서버와 통신을 활성화할지 여부,
			//gmail같은경우 true 해야함.
			prop.put("mail.smtp.ssl.enable","true");
			//ssl연결을 수립할 대 신뢰할 수 있는 smtp서버의 호스트 지정,
			//주로 호스트의 인증서를 신뢰할지 여부 결정하기 위해 사용.
			prop.put("mail.smtp.ssl.trust","smtp.gmail.com");
			
			Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(user, password);
				}
			});
			
			
				//MimeMessage 객체 생성
				MimeMessage message = new MimeMessage(session);
			try {
				//발신자 설정
				message.setFrom(new InternetAddress(user));
				
				//수신자 메일주소 입력
				// Message.RecipientType.TO 는 받는 사람을 나타내는 상수임.
				message.addRecipient(Message.RecipientType.TO,
						new InternetAddress(mail));
				
				// 제목 입력 (subject)
				message.setSubject("비밀번호 찾기 결과 발송");
				
				// 내용 입력 (text)
				message.setText(id+"님의 비밀번호는 "+pass+" 입니다.");
				
				Transport.send(message);
				
				
			} catch (Exception e) {
				// TODO: handle exception
			}	
				//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
				

			
			
		}
		request.setAttribute("cnt", res);
		
		request.getRequestDispatcher("/view/result.jsp").forward(request, response);
		
		
		
		
		
		
		
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
