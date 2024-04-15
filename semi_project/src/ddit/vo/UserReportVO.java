package ddit.vo;

public class UserReportVO {

	private int user_report_no;
	private String user_report_content;
	private int user_no;
	private String check_yn;
	public int getUser_report_no() {
		return user_report_no;
	}
	public void setUser_report_no(int user_report_no) {
		this.user_report_no = user_report_no;
	}
	public String getUser_report_content() {
		return user_report_content;
	}
	public void setUser_report_content(String user_report_content) {
		this.user_report_content = user_report_content;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getCheck_yn() {
		return check_yn;
	}
	public void setCheck_yn(String check_yn) {
		this.check_yn = check_yn;
	}
	@Override
	public String toString() {
		return "UserReportVO [user_report_no=" + user_report_no + ", user_report_content=" + user_report_content
				+ ", user_no=" + user_no + ", check_yn=" + check_yn + "]";
	}
	
}
