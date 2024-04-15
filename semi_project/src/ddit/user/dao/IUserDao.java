package ddit.user.dao;

import java.util.List;
import java.util.Map;

import ddit.vo.MarkVO;
import ddit.vo.Party_userVO;
import ddit.vo.UserReportVO;
import ddit.vo.UserVO;

public interface IUserDao {
	
	// �쉶�썝媛��엯
	public int registerUser(UserVO paramVo);

	// 濡쒓렇�씤
	public UserVO loginUser(UserVO paramVo);
	
	// id以묐났泥댄겕
	public int chkIdDuplication(String id);

	// �땳�꽕�엫 以묐났泥댄겕
	public int chkNicknameDuplication(String nickname);
	
	// 鍮꾨�踰덊샇 李얘린
	public String findUserPass(UserVO vo); 
	
	// 鍮꾨�踰덊샇 李얘린瑜� �쐞�븳 �븘�씠�뵒, �씠硫붿씪 �씪移섏뿬遺�
	public int chkIdMail(UserVO vo);
	
	// �븘�씠�뵒 李얘린
	public UserVO findUserId(UserVO vo);
	
	// 李쒕ぉ濡� 議댁옱�뿬遺� 寃��궗
	public MarkVO getbookmarkStatus(MarkVO vo);
	
	// 李� 紐⑸줉 異붽�
	public int insertBookmark(MarkVO vo);
	
	// 李� 紐⑸줉 �궘�젣
	public int delBookmark(MarkVO vo);
	
	// �쑀�� �닔�젙
	public int modifyUser(UserVO vo);
	
	// �쑀�� id濡� 媛��졇�삤湲�
	public UserVO selectUser(String id);
	
	// �쑀�� �긽�깭 媛��졇�삤湲�
	public List<Party_userVO> selectPartyUser();
	
	// 媛��엯 移댁슫�듃 媛��졇�삤湲�
	public List countPartyUserFromPartyNo();
	
	// 紐⑤뱺 �쑀�� 媛��졇�삤湲�
	public List<UserVO> selectAllUser();
	
	// �쑀�� 由ы룷�듃 �쟾泥� 媛��졇�삤湲�
	public List<UserReportVO> selectAllUserReport();
	
	// �쑀�� �젙蹂� 媛��졇�삤湲�
	public UserVO selectUserInfo(int user_no);
	
	// �쑀�� �떊怨� 異붽�
	public int insertUserReport(Map<String, Object> map);
	
	// �쑀�� 釉붾씪�씤�뱶
	public int blindUser(int userNo);
	
	// �쑀�� 寃쎄퀬
	public int reportUser(int reportNo);
	
	// �쑀�� �깉�눜
	public int resignUser(int userNo);
	
	// �쑀�� �깉�눜�떆 �쑀���뙆�떚 �긽�깭 2 -> 3 蹂�寃�
	public int resignPartyUserUpdate(int userNo);

	// �쑀�� �깉�눜 �쑀���뙆�떚 �긽�깭 1�씤嫄� �긽�깭�궘�젣
	public int resignPartyUserDelete(int userNo);
	
	// 硫ㅻ쾭 �닔�씫
	public int acceptPartyUser(Map<String, Object> map);
	
	// 硫ㅻ쾭 嫄곗젅
	public int rejectPartyUser(Map<String, Object> map);
	
	// 硫ㅻ쾭 媛뺥눜
	public int forcePartyUser(Map<String, Object> map);
	
	// �뙆�떚 �깉�눜
	public int exitParty(Map<String, Object> map);
	
	//유저 신고 반려
	public int UserReportCompanion(int reportNo);
	
	// 자동 파티 상태 변경
	public int autoChangePartyStatus(int party_no);
}
