package ddit.party.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ddit.party.dao.IPartyDao;
import ddit.party.dao.PartyDaoImpl;
import ddit.vo.HashtagVO;
import ddit.vo.PageVO;
import ddit.vo.PartyGongjiVO;
import ddit.vo.PartyReportVO;
import ddit.vo.PartyVO;
import ddit.vo.Party_userVO;
import ddit.vo.UserVO;

public class PartyServiceImpl implements IPartyService {

	private static IPartyDao dao;
	private static IPartyService service;

	private PartyServiceImpl() {
		dao = PartyDaoImpl.getInstance();
	}

	public static IPartyService getInstance() {
		return service = service == null ? new PartyServiceImpl() : service;
	}

	@Override
	public List<Map<String, Object>> getPartyBoardList(Map<String, Object> map) {
		return dao.getPartyBoardList(map);
	}

	@Override
	public int getTotalCount(Map<String, Object> map) {
		return dao.getTotalCount(map);
	}
	
	@Override
	public PageVO getPageInfo(int page, String stype, String sword) {
		PageVO pvo = new PageVO();

		// �쟾泥� 湲� 媛��닔 援ы븯湲�
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stype", stype);
		map.put("sword", sword);
		int count = this.getTotalCount(map);
		
		// �쟾泥� �럹�씠吏��닔 援ы븯湲�
		int plist = PageVO.getPerList(); 
		int totalPage = (int)Math.ceil((double)count / plist);
		
		if (page > totalPage) page = totalPage;
		
		int start = (page-1) * plist + 1; // start踰덊샇 援ы븯�뒗 怨듭떇
		int end = start + plist - 1; // end踰덊샇 援ы븯�뒗 怨듭떇
		
		if (end > count) end = count;
		
		// startPage, endPage
		int ppage = PageVO.getPerPage(); 
		int startPage = ((page-1) / ppage * ppage) + 1;
		int endPage = startPage + ppage - 1;
		
		if (endPage > totalPage) endPage = totalPage;
		
		pvo.setStart(start);
		pvo.setEnd(end);
		pvo.setStartPage(startPage);
		pvo.setEndPage(endPage);
		pvo.setTotalPage(totalPage);
		
		return pvo;
	}

	@Override
	public int getUserPartystatus(Map<String, Object> map) {
		return dao.getUserPartystatus(map);
	}

	@Override
	public Map<String, Object> getPartydetail(int party_no) {
		return dao.getPartydetail(party_no);
	}

	@Override
	public int insertJoinParty(Party_userVO vo) {
		return dao.insertJoinParty(vo);
	}

	@Override
	public int delJoinParty(Party_userVO vo) {
		return dao.delJoinParty(vo);
	}

	@Override
	public int updateJoinParty(Party_userVO vo) {
		return dao.updateJoinParty(vo);
	}

	@Override
	public List<HashtagVO> getHashtagList() {
		return dao.getHashtagList();
	}

	@Override
	public int insertParty(PartyVO vo) {
		return dao.insertParty(vo);
	}

	@Override
	public PartyVO getRegisterPartyNo(PartyVO vo) {
		return dao.getRegisterPartyNo(vo);
	}

	@Override
	public int insertPartyUser(Party_userVO vo) {
		return dao.insertPartyUser(vo);
	}

	@Override
	public int registerPartyHashtag(Map<String, Object> map) {
		return dao.registerPartyHashtag(map);
	}

	@Override
	public List<PartyGongjiVO> partygongjiList(Map<String, Object> map) {
		return dao.partygongjiList(map);
	}

	@Override
	public int getGongjiTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.getGongjiTotal(map);
	}

	@Override
	public List<UserVO> getPartyUserList(int party_no) {
		return dao.getPartyUserList(party_no);
	}
	@Override
	public int gongjiDelete(int gongjino) {
		// TODO Auto-generated method stub
		return dao.gongjiDelete(gongjino);
	}

	@Override
	public int gongjiUpdate(PartyGongjiVO vo) {
		// TODO Auto-generated method stub
		return dao.gongjiUpdate(vo);
	}

	@Override
	public int gongjiInsert(PartyGongjiVO vo) {
		// TODO Auto-generated method stub
		return dao.gongjiInsert(vo);
	}

	@Override
	public int insertPartyReport(Map<String, Object> map) {
		return dao.insertPartyReport(map);
	}

	@Override
	public int updatePartyStatus(Map<String, Object> map) {
		return dao.updatePartyStatus(map);
	}

	@Override
	public List<Map<String, Object>> getAllPartyUserList(int party_no) {
		return dao.getAllPartyUserList(party_no);
	}

	@Override
	public List<PartyReportVO> selectAllPartyReport() {
		return dao.selectAllPartyReport();
	}

	@Override
	public int updatePartyReport(int reportNo) {
		return dao.updatePartyReport(reportNo);
	}

	@Override
	public int partyReportCompanion(int reportNo) {
		return dao.partyReportCompanion(reportNo);
	}
	
}
