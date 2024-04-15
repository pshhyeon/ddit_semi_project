package ddit.vo;

public class PartyVO {
	private int party_no;
	private String party_name;
	private String party_percount;
	private String party_delyn;
	private String party_date;
	private int user_no;
	private int festival_no;
	private String party_info;
	public int getParty_no() {
		return party_no;
	}
	public void setParty_no(int party_no) {
		this.party_no = party_no;
	}
	public String getParty_name() {
		return party_name;
	}
	public void setParty_name(String party_name) {
		this.party_name = party_name;
	}
	public String getParty_percount() {
		return party_percount;
	}
	public void setParty_percount(String party_percount) {
		this.party_percount = party_percount;
	}
	public String getParty_delyn() {
		return party_delyn;
	}
	public void setParty_delyn(String party_delyn) {
		this.party_delyn = party_delyn;
	}
	public String getParty_date() {
		return party_date;
	}
	public void setParty_date(String party_date) {
		this.party_date = party_date;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getFestival_no() {
		return festival_no;
	}
	public void setFestival_no(int festival_no) {
		this.festival_no = festival_no;
	}
	public String getParty_info() {
		return party_info;
	}
	public void setParty_info(String party_info) {
		this.party_info = party_info;
	}
	@Override
	public String toString() {
		return "PartyVO [party_no=" + party_no + ", party_name=" + party_name + ", party_percount=" + party_percount
				+ ", party_delyn=" + party_delyn + ", party_date=" + party_date + ", user_no=" + user_no
				+ ", festival_no=" + festival_no + "]";
	}
	
	
}
