package ddit.request.service;

import java.util.List;
import java.util.Map;

import ddit.vo.CommentVO;
import ddit.vo.PageVO;
import ddit.vo.ReplyVO;
import ddit.vo.RequestVO;

public interface IRequestService {
	//��ü �� ���� ���ϱ�
	public int getRequestTotal(Map<String,Object> map);
	//��ü 1��1���� ����Ʈ���ϱ� + (ȸ���̸��� ������ ����)
	public List<RequestVO> requestList(Map<String,Object> map);
	//���������̼�(������ ���� ��������)
	public PageVO getPageInfo(int page, String category, String search);
	//1��1���� �����
	
	public int requestInsert(Map<String,Object> map);
	//��б� �����
	public int secretInsert(Map<String,Object> map);
	//1��1���� �󼼺���
	public RequestVO requestDetail (int requestNo);
	//1��1���Ǳ� ����(�ۼ��ڸ� ����)
	public int requestDelete(int boardNo);
	//1��1���� ������ �亯 ����Ʈ
	public List<ReplyVO> replyList(int requestNo);
	//1��1���� �����ڴ亯 ���
	public int replyInsert (ReplyVO vo);
	//�亯 ����
	public int replyDelete (int requestNo);
	//�亯 ����
	public int replyUpdate(ReplyVO vo);
}
