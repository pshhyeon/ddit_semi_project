package ddit.notifice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ddit.notifice.dao.INotificeDao;
import ddit.notifice.dao.NotificeDaoImpl;
import ddit.vo.NotificeVO;
import ddit.vo.PageVO;
import ddit.vo.UserVO;

public class NotificeServiceImpl implements INotificeService{
	
	 private INotificeDao dao;
		
		private static NotificeServiceImpl service;
		
		private NotificeServiceImpl() {
			dao = NotificeDaoImpl.getInstance();
		}
		
		public static NotificeServiceImpl getInstance(){
			if(service == null) service = new NotificeServiceImpl();
			return service;
		}

		@Override
		public int getNotiTotal(Map<String, Object> map) {
			return dao.getNotiTotal(map);
		}

		@Override
		public List<NotificeVO> getAllBoard(Map<String, Object> map) {
			return dao.getAllBoard(map);
		}


		@Override
		public PageVO getPageInfo(int page, String category, String search) {
			PageVO vo = new PageVO();
			
			//전체 글 갯수 구하기
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("category", category);
			map.put("search", search);
			int count = this.getNotiTotal(map);
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
		public int InsertNoti(NotificeVO vo) {
			return dao.InsertNoti(vo);
		}

		@Override
		public NotificeVO notiDetail(int notiNo) {
			return dao.notiDetail(notiNo);
		}

		@Override
		public int deleteNoti(int notiNo) {
			return dao.deleteNoti(notiNo);
		}

		@Override
		public int updateNoti(NotificeVO vo) {
			return dao.updateNoti(vo);
		}

		@Override
		public int getNotiHit(int notiNo) {
			return dao.getNotiHit(notiNo);
		}
		
}
