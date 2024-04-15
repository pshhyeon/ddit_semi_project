package ddit.request.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ddit.request.dao.RequestDaoImple;
import ddit.vo.PageVO;
import ddit.vo.ReplyVO;
import ddit.vo.RequestVO;

public class RequestServiceImpl implements IRequestService{
	private static RequestDaoImple dao;
	private RequestServiceImpl() {
		dao = RequestDaoImple.getInstance();
	}
	private  static RequestServiceImpl service;
	public static RequestServiceImpl getInstance() {
		if(service==null) service = new RequestServiceImpl();
		return service;
	}
	


	@Override
	public int getRequestTotal(Map<String, Object> map) {
		
		return dao.getRequestTotal(map);
	}



	@Override
	public List<RequestVO> requestList(Map<String, Object> map) {
	
		return dao.requestList(map);
	}



	@Override
	public PageVO getPageInfo(int page, String category, String search) {
		PageVO vo = new PageVO();
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("category", category);
		map.put("search", search);
		int count = this.getRequestTotal(map);
		
		int perList = PageVO.getPerList();
		int totalPage = (int) Math.ceil((double)count/perList);
		
		if(page > totalPage) {
			page = totalPage;
		}
		
		int start = (page-1)* perList +1;
		int end = start + perList -1;
		
		if(end>count) end= count;
		
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
	public int requestInsert(Map<String , Object> map) {
		
		return dao.requestInsert(map);
	}



	@Override
	public RequestVO requestDetail(int requestNo) {
		// TODO Auto-generated method stub
		return dao.requestDetail(requestNo);
	}



	@Override
	public int requestDelete(int boardNo) {
		// TODO Auto-generated method stub
		return dao.requestDelete(boardNo);
	}



	@Override
	public int secretInsert(Map<String, Object> map) {
		return dao.secretInsert(map);
	}



	@Override
	public List<ReplyVO> replyList(int requestNo) {
		return dao.replyList(requestNo);
	}



	@Override
	public int replyInsert(ReplyVO vo) {
		// TODO Auto-generated method stub
		return dao.replyInsert(vo);
	}



	@Override
	public int replyDelete(int requestNo) {
		// TODO Auto-generated method stub
		return dao.replyDelete(requestNo);
	}



	@Override
	public int replyUpdate(ReplyVO vo) {
		// TODO Auto-generated method stub
		return dao.replyUpdate(vo);
	}

}
