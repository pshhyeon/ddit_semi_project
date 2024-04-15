package ddit.festival.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ddit.festival.dao.FestivalDaoImpl;
import ddit.festival.dao.IFestivalDao;
import ddit.vo.FestivalVO;
import ddit.vo.PageVO;
import ddit.vo.PartyVO;

public class FestivalServiceImpl implements IFestivalService {

	private static IFestivalDao dao = null;
	private static IFestivalService service = null;
	
	private FestivalServiceImpl() {
		dao = FestivalDaoImpl.getInstance();
	};
	public static IFestivalService getInstance() {
		if(service == null) service = new FestivalServiceImpl();
		return service;
	}
	
	@Override
	public List<FestivalVO> getAllFestival() {
		return dao.getAllFestival();
	}

	@Override
	public FestivalVO detailFestival(int festivalNo) {
		return dao.detailFestival(festivalNo);
	}
	@Override
	public List<FestivalVO> searchFestivalName(String festivalName) {
		return dao.searchFestivalName(festivalName);
	}
	@Override
	public List<FestivalVO> searchFestivalLocation(Map<String, String> locationMap) {
		return dao.searchFestivalLocation(locationMap);
	}
	
	@Override
	public int getTotalCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<PartyVO> partyFromFestivalNo(int festivalNo) {
		return dao.partyFromFestivalNo(festivalNo);
	}
	@Override
	public List<PartyVO> getAllParty() {
		return dao.getAllParty();
	}
	@Override
	public int addFestival(FestivalVO fvo) {
		return dao.addFestival(fvo);
	}
	@Override
	public int deleteFestival(int fesNo) {
		return dao.deleteFestival(fesNo);
	}
	@Override
	public int updateFestival(FestivalVO fvo) {
		return dao.updateFestival(fvo);
	}

}
