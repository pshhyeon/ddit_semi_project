package ddit.vo;

public class RequestVO {
	private int request_no;
	private String request_title;
	private String request_content;
	private String request_date;
	private String request_delyn;
	private int user_no;
	private String nickName;
	private String request_secret;
	public String getRequest_secret() {
		return request_secret;
	}
	public void setRequest_secret(String request_secret) {
		this.request_secret = request_secret;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getRequest_no() {
		return request_no;
	}
	public void setRequest_no(int request_no) {
		this.request_no = request_no;
	}
	public String getRequest_title() {
		return request_title;
	}
	public void setRequest_title(String request_title) {
		this.request_title = request_title;
	}
	public String getRequest_content() {
		return request_content;
	}
	public void setRequest_content(String request_content) {
		this.request_content = request_content;
	}
	public String getRequest_date() {
		return request_date;
	}
	public void setRequest_date(String request_date) {
		this.request_date = request_date;
	}
	public String getRequest_delyn() {
		return request_delyn;
	}
	public void setRequest_delyn(String request_delyn) {
		this.request_delyn = request_delyn;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	@Override
	public String toString() {
		return "RequestVO [request_no=" + request_no + ", request_title=" + request_title + ", request_content="
				+ request_content + ", request_date=" + request_date + ", request_delyn=" + request_delyn + ", user_no="
				+ user_no + ", nickName=" + nickName + "]";
	}
	

}
