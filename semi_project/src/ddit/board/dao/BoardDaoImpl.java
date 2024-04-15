package ddit.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import ddit.util.MybatisUtil;
import ddit.vo.BoardVO;

public class BoardDaoImpl implements IBoardDao {
	private static BoardDaoImpl dao;
	private BoardDaoImpl() {};
	public static BoardDaoImpl getInstance() {
		if(dao==null) dao= new BoardDaoImpl();
		
		return dao;
	}

	@Override
	public int getBoardTotal(Map<String, Object> map) {
		SqlSession session = null;
				
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.selectOne("board.getBoardTotal",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		return res;
	}

	@Override
	public List<BoardVO> boardList(Map<String, Object> map) {
		SqlSession session = null;
		List<BoardVO> list = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("board.boardList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return list;
	}
	@Override
	public BoardVO boardDetail(int boardNo) {
		SqlSession session = null;
		BoardVO vo = null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectOne("board.boardDetail",boardNo);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		
		return vo;
	}
	@Override
	public int boardInsert(BoardVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("board.boardInsert",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		return res;
	}
	@Override
	public int boardUpdate(BoardVO vo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("board.boardUpdate",vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		
		return res;
	}
	@Override
	public int boardDelete(int boardNo) {
		SqlSession session = null;
		int res = 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("board.boardDelete",boardNo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}
	@Override
	public int commentDeleteWithBoard(int boardNo) {
		SqlSession session = null;
		int res= 0;
		try {
			session = MybatisUtil.getSqlSession();
			res = session.delete("board.commentDeleteWithBoard",boardNo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}
	@Override
	public int boardCountUpdate(int boardNo) {
		SqlSession session = null;
		int res=0;
		try {
			session =MybatisUtil.getSqlSession();
			res = session.update("board.boardCountUpdate",boardNo);
					
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.commit();
			if(session!=null) session.close();
		}
		
		return res;
	}


}
