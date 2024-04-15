package ddit.comment.service;

import java.util.List;

import ddit.vo.CommentVO;

public interface ICommentService {
	//댓글 리스트
	public List<CommentVO> commentList(int boardNo);
	//USER_NO를 보고 USER_NICKNAME을 가져오는거 /리스트 출력용
	public List<CommentVO> listNicknameInfo(int boardNo);
	//댓글 입력
	public int insertComment(CommentVO vo);
	//댓글 삭제
	public int deleteComment(int commentNo);
	//댓글 수정
	public int updateComment(CommentVO vo);
}
