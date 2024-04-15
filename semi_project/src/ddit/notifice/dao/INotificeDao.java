package ddit.notifice.dao;

import java.util.List;
import java.util.Map;

import ddit.vo.NotificeVO;

public interface INotificeDao {
	// 공지사항 전체 글
	public int getNotiTotal(Map<String,Object> map);
	
	//페이지별 리스트
    public List<NotificeVO> getAllBoard(Map<String,Object> map);
    
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
