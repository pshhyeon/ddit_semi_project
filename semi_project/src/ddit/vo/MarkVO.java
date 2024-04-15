package ddit.vo;

public class MarkVO {
	private int mark_no;
	private int user_no;
	private int party_no;
	
	public int getMark_no() {
		return mark_no;
	}
	public void setMark_no(int mark_no) {
		this.mark_no = mark_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getParty_no() {
		return party_no;
	}
	public void setParty_no(int party_no) {
		this.party_no = party_no;
	}
	@Override
	public String toString() {
		return "MarkVO [mark_no=" + mark_no + ", user_no=" + user_no + ", party_no=" + party_no + "]";
	}
	
}
