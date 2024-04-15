package ddit.mark.service;

import java.util.List;
import java.util.Map;

import ddit.board.dao.BoardDaoImpl;
import ddit.board.service.BoardServiceImpl;
import ddit.mark.dao.MarkDaoImpl;
import ddit.vo.MarkVO;
import ddit.vo.ZzimVO;

public class MarkServiceImpl implements IMarkService{
	
	private MarkDaoImpl dao;
	private MarkServiceImpl() {
		dao = MarkDaoImpl.getInstance();
	}
	private static MarkServiceImpl service;
	public static MarkServiceImpl getInstance() {
		if(service==null) service = new MarkServiceImpl();
		return service;
	}
	
	@Override
	public List<ZzimVO> getAllMark(int zzimVO) {
		return dao.getAllMark(zzimVO);
	}


	

}
