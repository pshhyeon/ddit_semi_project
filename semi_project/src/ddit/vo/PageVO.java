package ddit.vo;

public class PageVO {
	private int start; //페이지 시작 인덱스
	private int end;	//페이지 끝 인덱스
	private int totalPage;	//전체 페이지 수
	private int startPage;	//페이지 처리에서 시작 페이지 번호
	private int endPage;	//페이지 처리에서 끝 페이지 번호
	private static int perList =10;//한페이지당 항목 수
	private static int perPage =5;//한번에 몇개의 페이지를 나타낼수 있는지
	
	
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public static int getPerList() {
		return perList;
	}
	public static void setPerList(int perList) {
		PageVO.perList = perList;
	}
	public static int getPerPage() {
		return perPage;
	}
	public static void setPerPage(int perPage) {
		PageVO.perPage = perPage;
	}
	@Override
	public String toString() {
		return "PageVO [start=" + start + ", end=" + end + ", totalPage=" + totalPage + ", startPage=" + startPage
				+ ", endPage=" + endPage + "]";
	}
	
}
