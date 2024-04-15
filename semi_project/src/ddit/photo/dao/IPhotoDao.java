package ddit.photo.dao;

import java.util.List;

import ddit.vo.PhotoVO;

public interface IPhotoDao {
	//사진첩 사진 추가
	public int photoInsert(PhotoVO vo);
	//사진첩 리스트 출력
	public List<PhotoVO> photoList(int partyNo);
	//사진 출력하기 위한 사진vo에 저장된 정보 가져오기
	public PhotoVO getPhotoInfo(String fileName);
	//photo디테일 정보 가져오기
	public PhotoVO photoDetail(int photoNo);
	//partyNo로 소모임 파티장 찾기
	public int findPartyAdmin(int partyNo);
	//photo 삭제하기
	public int photoDelete(int photoNo);
	//photo 게시판 업데이트
	public int photoUpdate(PhotoVO vo);
	//photo 조회수 증가
	public int photoCountUpdate(int photoNo);
}
