package ddit.festival.service;

import java.util.List;
import java.util.Map;

import ddit.vo.FestivalVO;
import ddit.vo.PageVO;
import ddit.vo.PartyVO;

public interface IFestivalService {
	// 축제 리스트 전체 가져오기
	public List<FestivalVO> getAllFestival();
	
	// 소모임 리스트 전체 가져오기
	public List<PartyVO> getAllParty();
	
	// 축제 상세 정보
	public FestivalVO detailFestival(int festivalNo);
	
	// 축제 제목 검색
	public List<FestivalVO> searchFestivalName(String festivalName);
	
	// 축제 지역선택 후 제목 검색
	public List<FestivalVO> searchFestivalLocation(Map<String,String> locationMap);
	
	// 축제 전체 갯수 카운트
	public int getTotalCount(Map<String, Object> map);
	
	// 축제 번호로 모임 가져오기
	public List<PartyVO> partyFromFestivalNo(int festivalNo);
	
	// 축제 등록
	public int addFestival (FestivalVO fvo);
	
	// 축제 수정
	public int updateFestival (FestivalVO fvo);
	
	// 축제 삭제
	public int deleteFestival(int fesNo);
}
