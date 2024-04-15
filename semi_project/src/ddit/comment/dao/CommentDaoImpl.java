package ddit.comment.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import ddit.util.MybatisUtil;
import ddit.vo.CommentVO;

public class CommentDaoImpl implements ICommentDao {
	private static CommentDaoImpl dao;
	private CommentDaoImpl() {};
	public static CommentDaoImpl getInstance() {
		if(dao==null) dao = new CommentDaoImpl();
		return dao;
	}

	@Override
	public List<CommentVO> commentList(int boardNo) {
		SqlSession session = null;
		List<CommentVO> vo = null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectList("comment.commentList",boardNo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return vo;
	}
	@Override
	public List<CommentVO> listNicknameInfo(int boardNo) {
		SqlSession session = null;
		List<CommentVO> vo= null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectList("comment.listNicknameInfo",boardNo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		
		
		return vo;
	}
	@Override
	public int insertComment(CommentVO vo) {
		SqlSession session = null;
		int res= 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("comment.insertComment",vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		
		return res;
	}
	@Override
	public int deleteComment(int commentNo) {
		SqlSession session = null;
		int res=0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("comment.deleteComment",commentNo);
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		
		return res;
	}
	@Override
	public int updateComment(CommentVO vo) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = MybatisUtil.getSqlSession();
			res = session.update("comment.updateComment",vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}

}
