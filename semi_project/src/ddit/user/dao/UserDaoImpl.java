package ddit.user.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import ddit.util.MybatisUtil;
import ddit.vo.MarkVO;
import ddit.vo.Party_userVO;
import ddit.vo.UserReportVO;
import ddit.vo.UserVO;

public class UserDaoImpl implements IUserDao{

	private static IUserDao dao;
	private UserDaoImpl() {};
	public static IUserDao getInstance() {
		if(dao == null) dao = new UserDaoImpl();
		return dao;
	}
	
	@Override
	public int registerUser(UserVO paramVo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("user.registerUser", paramVo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) session.commit();
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public UserVO loginUser(UserVO paramVo) {
		SqlSession session = null;		
		UserVO vo = null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectOne("user.loginUser", paramVo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return vo;
	}
	@Override
	public int chkIdDuplication(String id) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.selectOne("user.chkIdDuplication", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return res;
	}
	@Override
	public int chkNicknameDuplication(String nickname) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.selectOne("user.chkNicknameDuplication", nickname);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return res;
	}
	@Override
	public String findUserPass(UserVO vo) {
		SqlSession session = null;
		String res = null;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.selectOne("user.findUserPass",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (session != null) session.close();
		}
		
		return res;
	}
	@Override
	public UserVO findUserId(UserVO vo) {
		SqlSession session = null;
		UserVO userVO = null;
		try {
			session = MybatisUtil.getSqlSession();
			userVO = session.selectOne("user.findUserId",vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)session.close();
		}
		return userVO;
	}
	@Override
	public int chkIdMail(UserVO vo) {
		int res = 0;
		SqlSession session = null;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.selectOne("user.chkIdMail",vo);
			System.out.println("�떎�삤�젅�뒪"+res);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session != null)session.close();
		}
		
		return res;
	}
	@Override
	public MarkVO getbookmarkStatus(MarkVO vo) {
		SqlSession session = null;
		MarkVO mvo = null;
		System.out.println("@@�쟾�떖諛쏆� dao vo ==> " + vo);
		try {
			session = MybatisUtil.getSqlSession();
			mvo = session.selectOne("user.getBookmarkStatus", vo);
			System.out.println("@@寃곌낵dao mvo ==> " + mvo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session != null)session.close();
		}
		
		return mvo;
	}
	
	@Override
	public int insertBookmark(MarkVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("user.insertBookmark", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	
	@Override
	public int delBookmark(MarkVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("user.delBookmark", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int modifyUser(UserVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.modifyUser", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public UserVO selectUser(String id) {
		SqlSession session = null;		
		UserVO vo = null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectOne("user.selectUser", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return vo;
	}
	@Override
	public List<Party_userVO> selectPartyUser() {
		SqlSession session = null;		
		List<Party_userVO> voList = new ArrayList<Party_userVO>();
		try {
			session = MybatisUtil.getSqlSession();
			voList = session.selectList("user.selectPartyUser");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return voList;
	}
	@Override
	public List countPartyUserFromPartyNo() {
		SqlSession session = null;		
		List intList = null;
		try {
			session = MybatisUtil.getSqlSession();
			intList = session.selectList("user.countPartyUserFromPartyNo");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return intList;
	}
	@Override
	public List<UserVO> selectAllUser() {
		SqlSession session = null;		
		List<UserVO> userList = null;
		try {
			session = MybatisUtil.getSqlSession();
			userList = session.selectList("user.selectAllUser");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return userList;
	}
	@Override
	public List<UserReportVO> selectAllUserReport() {
		SqlSession session = null;		
		List<UserReportVO> userReportList = null;
		try {
			session = MybatisUtil.getSqlSession();
			userReportList = session.selectList("user.selectAllUserReport");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return userReportList;
	}
	@Override
	public UserVO selectUserInfo(int user_no) {
		SqlSession session = null;		
		UserVO userinfo = null;
		try {
			session = MybatisUtil.getSqlSession();
			userinfo = session.selectOne("user.selectUserInfo", user_no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return userinfo;
	}
	
	@Override
	public int insertUserReport(Map<String, Object> map) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.insertUserReport", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int blindUser(int userNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.blindUser", userNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	
	@Override
	public int reportUser(int reportNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.reportUser", reportNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	
	@Override
	public int resignUser(int userNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.resignUser", userNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int resignPartyUserUpdate(int userNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.resignPartyUserUpdate", userNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int resignPartyUserDelete(int userNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("user.resignPartyUserDelete", userNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int acceptPartyUser(Map<String, Object> map) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.acceptPartyUser", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int rejectPartyUser(Map<String, Object> map) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("user.rejectPartyUser", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int forcePartyUser(Map<String, Object> map) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.forcePartyUser", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int exitParty(Map<String, Object> map) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.exitParty", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int UserReportCompanion(int reportNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("user.UserReportCompanion", reportNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}
	@Override
	public int autoChangePartyStatus(int party_no) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("user.autoChangePartyStatus", party_no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if(session != null)session.close();
		}
		return res;
	}

}
