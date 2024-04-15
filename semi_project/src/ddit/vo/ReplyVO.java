package ddit.vo;

public class ReplyVO {
	private int request_no;
	private String reply_title;
	private String reply_content;
	private String request_date;
	private String reply_delyn;
	public int getRequest_no() {
		return request_no;
	}
	public void setRequest_no(int request_no) {
		this.request_no = request_no;
	}
	public String getReply_title() {
		return reply_title;
	}
	public void setReply_title(String reply_title) {
		this.reply_title = reply_title;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getRequest_date() {
		return request_date;
	}
	public void setRequest_date(String request_date) {
		this.request_date = request_date;
	}
	public String getReply_delyn() {
		return reply_delyn;
	}
	public void setReply_delyn(String reply_delyn) {
		this.reply_delyn = reply_delyn;
	}
	@Override
	public String toString() {
		return "ReplyVO [request_no=" + request_no + ", reply_title=" + reply_title + ", reply_content=" + reply_content
				+ ", request_date=" + request_date + ", reply_delyn=" + reply_delyn + "]";
	}
	
	
}
