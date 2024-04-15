package ddit.party.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.javassist.expr.NewArray;

import ddit.party.service.IPartyService;
import ddit.party.service.PartyServiceImpl;
import ddit.vo.HashtagVO;
import ddit.vo.PartyVO;
import ddit.vo.Party_userVO;

@WebServlet("/registerParty.do")
public class RegisterParty extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 모임 등록 ==> 순서 1. 모임등록 2. 모임 번호 조회 3. 파티 유저 등록 4. 해쉬태그 등록
		request.setCharacterEncoding("utf-8");
		IPartyService service = PartyServiceImpl.getInstance();
		
		String party_name = request.getParameter("party_name");
		String party_percount = request.getParameter("party_percount"); 
		int user_no = Integer.parseInt(request.getParameter("user_no"));
		int festival_no = Integer.parseInt(request.getParameter("festival_no"));
		String party_info = request.getParameter("party_info");
		
		PartyVO pvo= new PartyVO();
		pvo.setParty_name(party_name);
		pvo.setParty_percount(party_percount);
		pvo.setUser_no(user_no);
		pvo.setFestival_no(festival_no);
		pvo.setParty_info(party_info);
		
		int res = service.insertParty(pvo);
		if (res > 0) {
			pvo.setParty_no(service.getRegisterPartyNo(pvo).getParty_no());
		}
		
		Party_userVO puvo = new Party_userVO();
		puvo.setParty_no(pvo.getParty_no());
		puvo.setUser_no(user_no);
		
		res = service.insertPartyUser(puvo);
		
		int hashtag1 = request.getParameter("hashtag1") == null || request.getParameter("hashtag1").equals("") ?
				0 : Integer.parseInt(request.getParameter("hashtag1"));
		int hashtag2 = request.getParameter("hashtag2") == null || request.getParameter("hashtag2").equals("") ?
				0 : Integer.parseInt(request.getParameter("hashtag2"));
		int hashtag3 = request.getParameter("hashtag3") == null || request.getParameter("hashtag3").equals("") ?
				0 : Integer.parseInt(request.getParameter("hashtag3"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		if (hashtag1 > 0) {
			map.put("party_no", pvo.getParty_no());
			map.put("hashtag_no", hashtag1);
			res = service.registerPartyHashtag(map);
		}
		if (hashtag2 > 0) {
			map.put("party_no", pvo.getParty_no());
			map.put("hashtag_no", hashtag2);
			res = service.registerPartyHashtag(map);
		}
		if (hashtag3 > 0) {
			map.put("party_no", pvo.getParty_no());
			map.put("hashtag_no", hashtag3);
			res = service.registerPartyHashtag(map);
		}
		
		request.setAttribute("cnt", res);
		
		request.getRequestDispatcher("view/result.jsp").forward(request, response);
		
	}

}
