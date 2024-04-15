package ddit.request.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import ddit.board.dao.BoardDaoImpl;
import ddit.util.MybatisUtil;
import ddit.vo.CommentVO;
import ddit.vo.ReplyVO;
import ddit.vo.RequestVO;

public class RequestDaoImple implements IRequestDao{
	
	private static RequestDaoImple dao;
	private  RequestDaoImple() {}; 
	public static RequestDaoImple getInstance() {
		if(dao==null) dao= new RequestDaoImple();
		
		return dao;
	}
	
	
	@Override
	public int getRequestTotal(Map<String, Object> map) {
		SqlSession session  = MybatisUtil.getSqlSession();
		int res = 0;
		try {
			res = session.selectOne("request.getRequestTotal",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		return res;
	}
	@Override
	public List<RequestVO> requestList(Map<String, Object> map) {
		SqlSession session = MybatisUtil.getSqlSession();
		List<RequestVO> list = null;
		try {
			list = session.selectList("request.requestList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return list;
	}
	public int requestInsert(Map<String, Object> map) {
		int res = 0;
		SqlSession session = MybatisUtil.getSqlSession();
		try {
			res = session.insert("request.requestInsert",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		
		return res;
		
	}
	@Override
	public RequestVO requestDetail(int requestNo) {
		SqlSession session = null;
		RequestVO vo = null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectOne("request.requestDetail",requestNo );
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return vo;
	}
	@Override
	public int requestDelete(int boardNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("request.requestDelete", boardNo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}
	@Override
	public int secretInsert(Map<String, Object> map) {
		int res = 0;
		SqlSession session = MybatisUtil.getSqlSession();
		try {
			res = session.insert("request.secretInsert",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		
		return res;
	}
	@Override
	public List<ReplyVO> replyList(int requestNo) {
		SqlSession session = null;
		List<ReplyVO> vo = null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectList("request.replyList" , requestNo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return vo;

	}
	@Override
	public int replyInsert(ReplyVO vo) {
		SqlSession session = null;
		int res= 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("request.replyInsert",vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		
		return res;
	}
	@Override
	public int replyDelete(int requestNo) {
		SqlSession session = null;
		int res=0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("request.replyDelete",requestNo);
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		
		return res;
	}
	@Override
	public int replyUpdate(ReplyVO vo) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("request.replyUpdate",vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}


}
