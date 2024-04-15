package ddit.vo;

public class Party_userVO {
	private int party_no;
	private int user_no;
	private int party_user_delyn;
	public int getParty_no() {
		return party_no;
	}
	public void setParty_no(int party_no) {
		this.party_no = party_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getParty_user_delyn() {
		return party_user_delyn;
	}
	public void setParty_user_delyn(int party_user_delyn) {
		this.party_user_delyn = party_user_delyn;
	}
	@Override
	public String toString() {
		return "Party_userVO [party_no=" + party_no + ", user_no=" + user_no + ", party_user_delyn=" + party_user_delyn
				+ "]";
	}
	
}
