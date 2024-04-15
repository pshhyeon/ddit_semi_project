package ddit.user.service;

import java.util.List;
import java.util.Map;

import ddit.user.dao.IUserDao;
import ddit.user.dao.UserDaoImpl;
import ddit.vo.MarkVO;
import ddit.vo.Party_userVO;
import ddit.vo.UserReportVO;
import ddit.vo.UserVO;

public class UserServcieImpl implements IUserService{

	private static IUserDao dao;
	private static IUserService service;
	
	private UserServcieImpl() {
		dao = UserDaoImpl.getInstance();
	};
	public static IUserService getInstance() {
		if(service == null) service = new UserServcieImpl();
		return service;
	}
	
	@Override
	public int registerUser(UserVO paramVo) {
		return dao.registerUser(paramVo);
	}

	@Override
	public UserVO loginUser(UserVO paramVo) {
		return dao.loginUser(paramVo);
	}
	@Override
	public int chkIdDuplication(String id) {
		return dao.chkIdDuplication(id);
	}
	@Override
	public int chkNicknameDuplication(String nickname) {
		return dao.chkNicknameDuplication(nickname);
	}
	@Override
	public String findUserPass(UserVO paramVo) {
		return dao.findUserPass(paramVo);
	}
	@Override
	public UserVO findUserId(UserVO vo) {
		return dao.findUserId(vo);
	}
	@Override
	public int chkIdMail(UserVO vo) {
		return dao.chkIdMail(vo);
	}
	@Override
	public MarkVO getbookmarkStatus(MarkVO vo) {
		return dao.getbookmarkStatus(vo);
	}
	@Override
	public int insertBookmark(MarkVO vo) {
		return dao.insertBookmark(vo);
	}
	@Override
	public int delBookmark(MarkVO vo) {
		return dao.delBookmark(vo);
	}
	@Override
	public int modifyUser(UserVO vo) {
		return dao.modifyUser(vo);
	}
	@Override
	public UserVO selectUser(String id) {
		return dao.selectUser(id);
	}
	@Override
	public List<Party_userVO> selectPartyUser() {
		return dao.selectPartyUser();
	}
	@Override
	public List countPartyUserFromPartyNo() {
		return dao.countPartyUserFromPartyNo();
	}
	@Override
	public List<UserVO> selectAllUser() {
		return dao.selectAllUser();
	}
	@Override
	public List<UserReportVO> selectAllUserReport() {
		return dao.selectAllUserReport();
	}
	@Override
	public UserVO selectUserInfo(int user_no) {
		return dao.selectUserInfo(user_no);
	}
	@Override
	public int insertUserReport(Map<String, Object> map) {
		return dao.insertUserReport(map);
	}
	@Override
	public int blindUser(int userNo) {
		return dao.blindUser(userNo);
	}
	@Override
	public int reportUser(int reportNo) {
		return dao.reportUser(reportNo);
	}
	@Override
	public int resignUser(int userNo) {
		return dao.resignUser(userNo);
	}
	@Override
	public int resignPartyUserUpdate(int userNo) {
		return dao.resignPartyUserUpdate(userNo);
	}
	@Override
	public int resignPartyUserDelete(int userNo) {
		return dao.resignPartyUserDelete(userNo);
	}
	@Override
	public int acceptPartyUser(Map<String, Object> map) {
		return dao.acceptPartyUser(map);
	}
	@Override
	public int rejectPartyUser(Map<String, Object> map) {
		return dao.rejectPartyUser(map);
	}
	@Override
	public int forcePartyUser(Map<String, Object> map) {
		return dao.forcePartyUser(map);
	}
	@Override
	public int exitParty(Map<String, Object> map) {
		return dao.exitParty(map);
	}
	@Override
	public int UserReportCompanion(int reportNo) {
		return dao.UserReportCompanion(reportNo);
	}
	@Override
	public int autoChangePartyStatus(int party_no) {
		return dao.autoChangePartyStatus(party_no);
	}

}
