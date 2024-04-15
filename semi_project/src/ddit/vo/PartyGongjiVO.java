package ddit.vo;

public class PartyGongjiVO {
	private int party_gongji_no;
	private String party_gongji_title;
	private String party_gongji_content;
	private String party_gongji_date;
	private int party_no;
	public int getParty_gongji_no() {
		return party_gongji_no;
	}
	public void setParty_gongji_no(int party_gongji_no) {
		this.party_gongji_no = party_gongji_no;
	}
	public String getParty_gongji_title() {
		return party_gongji_title;
	}
	public void setParty_gongji_title(String party_gongji_title) {
		this.party_gongji_title = party_gongji_title;
	}
	public String getParty_gongji_content() {
		return party_gongji_content;
	}
	public void setParty_gongji_content(String party_gongji_content) {
		this.party_gongji_content = party_gongji_content;
	}
	public String getParty_gongji_date() {
		return party_gongji_date;
	}
	public void setParty_gongji_date(String party_gongji_date) {
		this.party_gongji_date = party_gongji_date;
	}
	public int getParty_no() {
		return party_no;
	}
	public void setParty_no(int party_no) {
		this.party_no = party_no;
	}
	@Override
	public String toString() {
		return "PartyGongji [party_gongji_no=" + party_gongji_no + ", party_gongji_title=" + party_gongji_title
				+ ", party_gongji_content=" + party_gongji_content + ", party_gongji_date=" + party_gongji_date
				+ ", party_no=" + party_no + "]";
	}
	
	

}
