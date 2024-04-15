package ddit.request.dao;

import java.util.List;
import java.util.Map;

import ddit.vo.ReplyVO;
import ddit.vo.RequestVO;

public interface IRequestDao {
	//��ü �� ���� ���ϱ�
	public int getRequestTotal(Map<String,Object> map);
	//��ü 1��1���� ����Ʈ���ϱ� + (ȸ���̸��� ������ ����)
	public List<RequestVO> requestList(Map<String,Object> map);
	//1��1���� �����
	public int requestInsert(Map<String,Object> map);
	//��б� �����
	public int secretInsert(Map<String,Object> map);
	//1��1���� �ڼ�������
	public RequestVO requestDetail (int requestNo);
	//1��1���Ǳ� ����(�ۼ��ڸ� ����)
	public int requestDelete(int boardNo);
	//1��1���� ������ �亯 ����Ʈ
	public List<ReplyVO> replyList(int requestNo);
	//1대1요청사항 삭제 
	public int replyInsert (ReplyVO vo);
	//�亯 ����
	public int replyDelete (int requestNo);
	//1대1답변 수정
	public int replyUpdate(ReplyVO vo);
}
