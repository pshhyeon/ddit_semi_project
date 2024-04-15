package ddit.comment.service;

import java.util.List;

import ddit.comment.dao.CommentDaoImpl;
import ddit.vo.CommentVO;

public class CommentServiceImpl implements ICommentService {
	private CommentDaoImpl dao;
	private CommentServiceImpl() {
		dao = CommentDaoImpl.getInstance();
	}
	private static CommentServiceImpl service;
	public static CommentServiceImpl getInstance() {
		if(service==null) service = new CommentServiceImpl();
		return service;
	}
	

	@Override
	public List<CommentVO> commentList(int boardNo) {
		// TODO Auto-generated method stub
		return dao.commentList(boardNo);
	}


	@Override
	public List<CommentVO> listNicknameInfo(int boardNo) {
		return dao.listNicknameInfo(boardNo);
	}


	@Override
	public int insertComment(CommentVO vo) {
		return dao.insertComment(vo);
	}


	@Override
	public int deleteComment(int commentNo) {
		return dao.deleteComment(commentNo);
	}


	@Override
	public int updateComment(CommentVO vo) {
		return dao.updateComment(vo);
	}

}
