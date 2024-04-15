package ddit.party.service;

import java.util.List;
import java.util.Map;

import ddit.vo.HashtagVO;
import ddit.vo.PageVO;
import ddit.vo.PartyGongjiVO;
import ddit.vo.PartyReportVO;
import ddit.vo.PartyVO;
import ddit.vo.Party_userVO;
import ddit.vo.UserVO;

public interface IPartyService {
	public List<Map<String, Object>> getPartyBoardList(Map<String, Object> map);
	
	public PageVO getPageInfo(int page, String stype, String sword);
	
	public int getTotalCount(Map<String, Object> map);
	
	// �쉶�썝 �냼紐⑥엫 媛��엯�긽�깭 1 ~ 4
	public int getUserPartystatus(Map<String, Object> map);
	
	// 紐⑥엫�젙蹂�
	public Map<String, Object> getPartydetail(int party_no);
	
	// 紐⑥엫 �떊泥�
	public int insertJoinParty (Party_userVO vo);
	
	// 紐⑥엫 �떊泥� 痍⑥냼
	public int delJoinParty (Party_userVO vo);
	
	// 紐⑥엫 �옱媛��엯 �떊泥�
	public int updateJoinParty (Party_userVO vo);
	
	// �빐�돩�깭洹� 由ъ뒪�듃 媛��졇�삤湲�
	public List<HashtagVO> getHashtagList ();
	
	// 紐⑥엫 �벑濡�
	public int insertParty(PartyVO vo);
	
	// �벑濡앺븳 紐⑥엫�젙蹂� 媛��졇�삤湲�
	public PartyVO getRegisterPartyNo(PartyVO vo);
	
	// 紐⑥엫�쓣 �벑濡앺븳 �쑀�� �젙蹂� insert
	public int insertPartyUser(Party_userVO vo);
	
	// 紐⑥엫�벑濡앹떆 吏��젙�븳 �빐�돩�깭洹� �벑濡�
	public int registerPartyHashtag(Map<String, Object> map);
	
	//�냼紐⑥엫 怨듭��궗�빆 由ъ뒪�듃 count
	public int getGongjiTotal(Map<String , Object> map);
	
	//�냼紐⑥엫 怨듭��궗�빆 �궘�젣
	public int gongjiDelete(int gongjino);
	
	//�냼紐⑥엫 怨듭��궗�빆 �닔�젙
	public int gongjiUpdate(PartyGongjiVO vo);
	
	//�냼紐⑥엫 湲��벐湲�
	public int gongjiInsert(PartyGongjiVO vo);

	
	public List<PartyGongjiVO> partygongjiList(Map<String, Object> map);
	
	// �빐�떦 �뙆�떚 �쑀�� 由ъ뒪�듃 媛��졇�삤湲�
	public List<UserVO> getPartyUserList(int party_no);
	
	// �냼紐⑥엫 �떊怨�
	public int insertPartyReport(Map<String, Object> map);
	
	// �냼紐⑥엫 �긽�깭 蹂�寃�
	public int updatePartyStatus(Map<String, Object> map);

	// �냼紐⑥엫 硫ㅻ쾭 愿�由� 由ъ뒪�듃
	public List<Map<String, Object>> getAllPartyUserList(int party_no);
	
	// �뙆�떚 �떊怨좊궡�뿭 媛��졇�삤湲�
	public List<PartyReportVO> selectAllPartyReport();
	
	// �뙆�떚 �떊怨� yn蹂�寃�
	public int updatePartyReport(int reportNo);
	
	//파티 신고 반려
	public int partyReportCompanion(int reportNo);
}
