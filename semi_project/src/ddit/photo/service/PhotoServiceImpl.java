package ddit.photo.service;

import java.util.List;

import ddit.photo.dao.PhotoDaoImpl;
import ddit.vo.PhotoVO;

public class PhotoServiceImpl implements IPhotoService {
	private static PhotoDaoImpl dao;
	private PhotoServiceImpl() {
		dao = PhotoDaoImpl.getInstance();
	}
	private static PhotoServiceImpl service;
	public static PhotoServiceImpl getInstance() {
		if(service==null) service = new PhotoServiceImpl();
		return service;
	}

	@Override
	public int photoInsert(PhotoVO vo) {
		return dao.photoInsert(vo);
	}

	@Override
	public List<PhotoVO> photoList(int partyNo) {
		return dao.photoList(partyNo);
	}

	@Override
	public PhotoVO getPhotoInfo(String fileName) {
		// TODO Auto-generated method stub
		return dao.getPhotoInfo(fileName);
	}

	@Override
	public PhotoVO photoDetail(int photoNo) {
		return dao.photoDetail(photoNo);
	}

	@Override
	public int findPartyAdmin(int partyNo) {
		return dao.findPartyAdmin(partyNo);
	}

	@Override
	public int photoDelete(int photoNo) {
		// TODO Auto-generated method stub
		return dao.photoDelete(photoNo);
	}

	@Override
	public int photoUpdate(PhotoVO vo) {
		return dao.photoUpdate(vo);
	}

	@Override
	public int photoCountUpdate(int photoNo) {
		// TODO Auto-generated method stub
		return dao.photoCountUpdate(photoNo);
	}

}
