package ddit.festival.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import ddit.util.MybatisUtil;
import ddit.vo.FestivalVO;
import ddit.vo.PartyVO;

public class FestivalDaoImpl implements IFestivalDao {

	private static IFestivalDao dao = null;
	private FestivalDaoImpl() {};
	public static IFestivalDao getInstance() {
		if(dao == null) dao = new FestivalDaoImpl();
		return dao;
	}
	
	
	@Override
	public List<FestivalVO> getAllFestival() {
		SqlSession session = null;
		List<FestivalVO> festivalList = new ArrayList<FestivalVO>();
		try {
			session = MybatisUtil.getSqlSession();
			festivalList = session.selectList("festival.getAllFestival");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return festivalList;
	}

	@Override
	public FestivalVO detailFestival(int festivalNo) {
		SqlSession session = null;
		FestivalVO fesVo = new FestivalVO();
		try {
			session = MybatisUtil.getSqlSession();
			fesVo = session.selectOne("festival.detailFestival", festivalNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return fesVo;
	}
	
	@Override
	public List<FestivalVO> searchFestivalName(String festivalName) {
		SqlSession session = null;
		List<FestivalVO> festivalList = new ArrayList<FestivalVO>();
		try {
			session = MybatisUtil.getSqlSession();
			festivalList = session.selectList("festival.searchFestivalName",festivalName);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return festivalList;
	}
	@Override
	public List<FestivalVO> searchFestivalLocation(Map<String, String> locationMap) {
		SqlSession session = null;
		List<FestivalVO> festivalList = new ArrayList<FestivalVO>();
		try {
			session = MybatisUtil.getSqlSession();
			festivalList = session.selectList("festival.searchFestivalLocation",locationMap);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return festivalList;
	}
	@Override
	public int getTotalCount(Map<String, Object> map) {
		return 0;
	}
	@Override
	public List<PartyVO> partyFromFestivalNo(int festivalNo) {
		SqlSession session = null;
		List<PartyVO> partyList = new ArrayList<PartyVO>();
		try {
			session = MybatisUtil.getSqlSession();
			partyList = session.selectList("festival.partyFromFestivalNo",festivalNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return partyList;
	}
	@Override
	public List<PartyVO> getAllParty() {
		SqlSession session = null;
		List<PartyVO> partyList = new ArrayList<PartyVO>();
		try {
			session = MybatisUtil.getSqlSession();
			partyList = session.selectList("festival.getAllParty");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return partyList;
	}
	
	@Override
	public int addFestival(FestivalVO fvo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("festival.addFestival",fvo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.commit();
			if (session != null) session.close();
		}
		return res;
	}
	
	@Override
	public int deleteFestival(int fesNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("festival.deleteFestival",fesNo);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return res;
	}
	@Override
	public int updateFestival(FestivalVO fvo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("festival.updateFestival",fvo);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		return res;
	}
	

}
