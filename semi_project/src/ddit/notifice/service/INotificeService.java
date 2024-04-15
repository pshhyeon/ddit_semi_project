package ddit.notifice.service;

import java.util.List;
import java.util.Map;

import ddit.vo.NotificeVO;
import ddit.vo.PageVO;
import ddit.vo.UserVO;

public interface INotificeService {
	//전체 글 개수 구하기
    public int getNotiTotal(Map<String,Object> map);
    
    //페이지별 리스트
	public List<NotificeVO> getAllBoard(Map<String,Object> map);
	
	//페이지네이션(페이지 정보 가져오기)
	public PageVO getPageInfo(int page, String category, String search);
	
	// 글쓰기
    public int InsertNoti(NotificeVO vo);
    
    // 게시물 상세보기
    public NotificeVO notiDetail(int notiNo);
    
    // 삭제
    public int deleteNoti(int notiNo);
 
    // 수정
    public int updateNoti(NotificeVO vo);
    
    // 조회수
    public int getNotiHit(int notiNo);

}
