package ddit.party.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import ddit.util.MybatisUtil;
import ddit.vo.HashtagVO;
import ddit.vo.PartyGongjiVO;
import ddit.vo.PartyReportVO;
import ddit.vo.PartyVO;
import ddit.vo.Party_userVO;
import ddit.vo.UserVO;

public class PartyDaoImpl implements IPartyDao {
	
	private static IPartyDao dao = null;

	private PartyDaoImpl() { };

	public static IPartyDao getInstance() {
		return dao = dao == null ? new PartyDaoImpl() : dao;
	}

	@Override
	public List<Map<String, Object>> getPartyBoardList(Map<String, Object> map) {
		SqlSession session = null;
		List<Map<String, Object>> list = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("party.getPartyBoardList", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) { session.close(); }
		}
		return list;
	}

	@Override
	public int getTotalCount(Map<String, Object> map) {
		SqlSession session = MybatisUtil.getSqlSession();
		int res = 0;
		try {
			res = session.selectOne("party.getTotalCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public int getUserPartystatus(Map<String, Object> map) {
		SqlSession session = MybatisUtil.getSqlSession();
		int res = 0;
		try {
			res = session.selectOne("party.getUserPartystatus", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public Map<String, Object> getPartydetail(int party_no) {
		SqlSession session = null;
		Map<String, Object> map = null;
		try {
			session = MybatisUtil.getSqlSession();
			map = session.selectOne("party.getPartydetail", party_no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return map;
	}

	@Override
	public int insertJoinParty(Party_userVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("party.insertJoinParty", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public int delJoinParty(Party_userVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("party.delJoinParty", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public int updateJoinParty(Party_userVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("party.updateJoinParty", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public List<HashtagVO> getHashtagList() {
		SqlSession session = null;
		List<HashtagVO> list = null;
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("party.getHashtagList");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return list;
	}

	@Override
	public int insertParty(PartyVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("party.insertParty", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public PartyVO getRegisterPartyNo(PartyVO vo) {
		SqlSession session = null;
		PartyVO pvo = null;
		try {
			session = MybatisUtil.getSqlSession();
			pvo = session.selectOne("party.getRegisterPartyNo", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return pvo;
	}

	@Override
	public int insertPartyUser(Party_userVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("party.insertPartyUser", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public int registerPartyHashtag(Map<String, Object> map) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("party.registerPartyHashtag", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit();}
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public int getGongjiTotal(Map<String, Object> map) {
		SqlSession session  = MybatisUtil.getSqlSession();
		int res = 0;
		try {
			res = session.selectOne("party-gongji.getGongjiTotal",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		return res;
	}

	@Override
	public int gongjiDelete(int gongjino) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("party-gongji.gongjiDelete", gongjino);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}

	@Override
	public int gongjiUpdate(PartyGongjiVO vo) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("party-gongji.gongjiUpdate",vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
		
	}

	@Override
	public List<UserVO> getPartyUserList(int party_no) {
		SqlSession session  = MybatisUtil.getSqlSession();
		List<UserVO> list = null;
		try {
			list = session.selectList("party.getPartyUserList",party_no);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		return list;
	}

	@Override
	public int gongjiInsert(PartyGongjiVO vo) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("party-gongji.gongjiInsert",vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;

	}
	
	@Override
	public List<PartyGongjiVO> partygongjiList(Map<String, Object> map) {
		SqlSession session = null;
		List<PartyGongjiVO> list = null;
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("party-gongji.gongjiList",map );
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return list;
	}

	@Override
	public int insertPartyReport(Map<String, Object> map) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("party.insertPartyReport", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit(); }
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public int updatePartyStatus(Map<String, Object> map) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("party.updatePartyStatus", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit(); }
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public List<Map<String, Object>> getAllPartyUserList(int party_no) {
		SqlSession session = null;
		List<Map<String, Object>> list = null;
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("party.getAllPartyUserList", party_no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return list;
	}

	@Override
	public List<PartyReportVO> selectAllPartyReport() {
		SqlSession session = null;
		List<PartyReportVO> list = null;
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("party.selectAllPartyReport");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return list;
	}

	@Override
	public int updatePartyReport(int reportNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("party.updatePartyReport", reportNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit(); }
			if (session != null) session.close();
		}
		return res;
	}

	@Override
	public int partyReportCompanion(int reportNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("party.partyReportCompanion", reportNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (res > 0) { session.commit(); }
			if (session != null) session.close();
		}
		return res;
	}
}
