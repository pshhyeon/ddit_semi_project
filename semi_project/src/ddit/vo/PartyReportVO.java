package ddit.vo;

public class PartyReportVO {

	private int party_report_no;
	private String party_report_content;
	private int party_no;
	private String party_check_yn;
	private String party_report_count;
	private int user_no;
	public int getParty_report_no() {
		return party_report_no;
	}
	public void setParty_report_no(int party_report_no) {
		this.party_report_no = party_report_no;
	}
	public String getParty_report_content() {
		return party_report_content;
	}
	public void setParty_report_content(String party_report_content) {
		this.party_report_content = party_report_content;
	}
	public int getParty_no() {
		return party_no;
	}
	public void setParty_no(int party_no) {
		this.party_no = party_no;
	}
	public String getParty_check_yn() {
		return party_check_yn;
	}
	public void setParty_check_yn(String party_check_yn) {
		this.party_check_yn = party_check_yn;
	}
	public String getParty_report_count() {
		return party_report_count;
	}
	public void setParty_report_count(String party_report_count) {
		this.party_report_count = party_report_count;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	@Override
	public String toString() {
		return "PartyReportVO [party_report_no=" + party_report_no + ", party_report_content=" + party_report_content
				+ ", party_no=" + party_no + ", party_check_yn=" + party_check_yn + ", party_report_count="
				+ party_report_count + ", user_no=" + user_no + "]";
	}
}
