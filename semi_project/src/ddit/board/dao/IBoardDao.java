package ddit.board.dao;

import java.util.List;
import java.util.Map;

import ddit.vo.BoardVO;

public interface IBoardDao {
	//전체 글 개수 구하기
	public int getBoardTotal(Map<String,Object> map);
	//페이지별 리스트
	public List<BoardVO> boardList(Map<String,Object> map);
	//게시물 상세보기
	public BoardVO boardDetail(int boardNo);
	//게시물 등록
	public int boardInsert(BoardVO vo);
	//게시물 업데이트
	public int boardUpdate(BoardVO vo);
	//게시물 삭제
	public int boardDelete(int boardNo);
	//게시물 삭제하면서 댓글들도 같이 삭제되기
	public int commentDeleteWithBoard(int boardNo);
	//조회수 증가
	public int boardCountUpdate(int boardNo);
	

	

}
