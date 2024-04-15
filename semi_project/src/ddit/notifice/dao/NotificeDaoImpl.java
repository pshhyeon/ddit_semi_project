package ddit.notifice.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import ddit.util.MybatisUtil;
import ddit.vo.BoardVO;
import ddit.vo.NotificeVO;

public class NotificeDaoImpl implements INotificeDao{
	
private static NotificeDaoImpl dao;
	
	private NotificeDaoImpl() {}
	
	public static NotificeDaoImpl getInstance() {
		if(dao == null) dao = new NotificeDaoImpl();
		
		return dao;
	}

	@Override
	public int getNotiTotal(Map<String, Object> map) {
		SqlSession session = MybatisUtil.getSqlSession();
		int res = 0;
		try {
			res = session.selectOne("noti.getNotiTotal", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		return res;
	}

	@Override
	public List<NotificeVO> getAllBoard(Map<String, Object> map) {
		SqlSession session = MybatisUtil.getSqlSession();
		List<NotificeVO> list = null;
		
		try {
			list = session.selectList("noti.getAllBoard",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return list;
	}

	@Override
	public int InsertNoti(NotificeVO vo) {
		int res = 0;
		SqlSession session = MybatisUtil.getSqlSession();
		try {
			res = session.insert("noti.InsertNoti", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.commit();
			session.close();
		}
		return res;
	}

	@Override
	public NotificeVO notiDetail(int notiNo) {
		SqlSession session = null;
		NotificeVO vo = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectOne("noti.notiDetail", notiNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		return vo;
	}

	@Override
	public int deleteNoti(int notiNo) {
		int res = 0;
		SqlSession session = MybatisUtil.getSqlSession();
		
		try {
			res = session.delete("noti.deleteNoti",notiNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.commit();
			session.close();
		}
		return res;
	}

	@Override
	public int updateNoti(NotificeVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("noti.updateNoti", vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		return res;
	}

	@Override
	public int getNotiHit(int notiNo) {
		int res = 0;
		SqlSession session = null;
		
		System.out.println("getNotiHit->notiNo : " + notiNo);
		
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("noti.getNotiHit", notiNo);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		return res;
	}

}
