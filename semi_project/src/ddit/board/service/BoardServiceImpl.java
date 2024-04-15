package ddit.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ddit.board.dao.BoardDaoImpl;
import ddit.vo.BoardVO;
import ddit.vo.PageVO;

public class BoardServiceImpl implements IBoardService {
	private BoardDaoImpl dao;
	private BoardServiceImpl() {
		dao = BoardDaoImpl.getInstance();
	}
	private static BoardServiceImpl service;
	public static BoardServiceImpl getInstance() {
		if(service==null) service = new BoardServiceImpl();
		return service;
	}

	@Override
	public int getBoardTotal(Map<String, Object> map) {
		return dao.getBoardTotal(map);
	}

	@Override
	public List<BoardVO> boardList(Map<String, Object> map) {
		return dao.boardList(map);
	}

	@Override
	public PageVO getPageInfo(int page, String category, String search) {
		PageVO vo = new PageVO();
		
		//전체 글 갯수 구하기
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("category", category);
		map.put("search", search);
		int count = this.getBoardTotal(map);
		//현재기준 30개 들어있음
		
		//몇개 게시물 출력할지 10개
		int perList = PageVO.getPerList();
		int totalPage = (int) Math.ceil((double)count/perList);
		
		if(page > totalPage) {
			page = totalPage;
		}
		
		int start = (page-1)* perList +1;
		int end = start + perList -1;
		
		if(end>count) end= count;
		
		//몇개 게시판 볼지 5개
		int perPage = PageVO.getPerPage();
		int startPage = ((page-1) / perPage *perPage)+1;
		int endPage = startPage +perPage -1;
		
		if(endPage > totalPage) endPage = totalPage;
		
		vo.setStart(start);
		vo.setEnd(end);
		vo.setStartPage(startPage);
		vo.setEndPage(endPage);
		vo.setTotalPage(totalPage);
		
		return vo;
	}

	@Override
	public BoardVO boardDetail(int boardNo) {
		
		return dao.boardDetail(boardNo);
	}

	@Override
	public int boardInsert(BoardVO vo) {
		// TODO Auto-generated method stub
		return dao.boardInsert(vo);
	}

	@Override
	public int boardUpdate(BoardVO vo) {
		return dao.boardUpdate(vo);
	}

	@Override
	public int boardDelete(int boardNo) {
		return dao.boardDelete(boardNo);
	}

	@Override
	public int commentDeleteWithBoard(int boardNo) {
		return dao.commentDeleteWithBoard(boardNo);
	}

	@Override
	public int boardCountUpdate(int boardNo) {
		return dao.boardCountUpdate(boardNo);
	}



}
