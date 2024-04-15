package ddit.photo.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import ddit.util.MybatisUtil;
import ddit.vo.PhotoVO;

public class PhotoDaoImpl implements IPhotoDao {
	private static PhotoDaoImpl dao;
	private PhotoDaoImpl() {
	}
	public static PhotoDaoImpl getInstance() {
		if(dao==null) dao = new PhotoDaoImpl();
		return dao;
	}

	@Override
	public int photoInsert(PhotoVO vo) {
		int res = 0;
		SqlSession session = null;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("photo.photoInsert",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}
	@Override
	public List<PhotoVO> photoList(int partyNo) {
		List<PhotoVO> list = null;
		SqlSession session = null;
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("photo.photoList", partyNo);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return list;
	}
	@Override
	public PhotoVO getPhotoInfo(String fileName) {
		PhotoVO vo = null;
		SqlSession session = null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectOne("photo.getPhotoInfo",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return vo;
	}
	@Override
	public PhotoVO photoDetail(int photoNo) {
		PhotoVO vo = null;
		SqlSession session = null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectOne("photo.photoDetail",photoNo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return vo;
	}
	@Override
	public int findPartyAdmin(int partyNo) {
		int res = 0;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			res = session.selectOne("photo.findPartyAdmin",partyNo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return res;
	}
	@Override
	public int photoDelete(int photoNo) {
		int res = 0;
		SqlSession session = null;
		try {
			session = MybatisUtil.getSqlSession();
			res= session.delete("photo.photoDelete",photoNo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}
	@Override
	public int photoUpdate(PhotoVO vo) {
		int res = 0;
		SqlSession session = null;
		try {
			session = MybatisUtil.getSqlSession();
			res= session.update("photo.photoUpdate",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}
	@Override
	public int photoCountUpdate(int photoNo) {
		int res = 0;
		SqlSession session = null;
		try {
			session = MybatisUtil.getSqlSession();
			res= session.update("photo.photoCountUpdate",photoNo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}

}
