package ddit.mark.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import ddit.board.dao.BoardDaoImpl;
import ddit.util.MybatisUtil;
import ddit.vo.BoardVO;
import ddit.vo.MarkVO;
import ddit.vo.ZzimVO;

public class MarkDaoImpl implements IMarkDao{
	
	private static MarkDaoImpl dao;
	private MarkDaoImpl() {};
	public static MarkDaoImpl getInstance() {
		if(dao==null) dao= new MarkDaoImpl();
		
		return dao;
	}
	
	@Override
	public List<ZzimVO> getAllMark(int zzimVO) {
		SqlSession session = null;
		List<ZzimVO> zzimList = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			zzimList = session.selectList("mark.getAllMark", zzimVO);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}
		return zzimList;
	}
		
	
}
