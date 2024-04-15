package ddit.vo;

public class PhotoVO {
	private int photo_no;
	private String photo_title;
	private String photo_content;
	private String photo_date;
	private String photo_count;
	private String photo_filename;
	private int party_no;
	private int user_no;
	private String nickname;
	
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getPhoto_no() {
		return photo_no;
	}
	public void setPhoto_no(int photo_no) {
		this.photo_no = photo_no;
	}
	public String getPhoto_title() {
		return photo_title;
	}
	public void setPhoto_title(String photo_title) {
		this.photo_title = photo_title;
	}
	public String getPhoto_content() {
		return photo_content;
	}
	public void setPhoto_content(String photo_content) {
		this.photo_content = photo_content;
	}
	public String getPhoto_date() {
		return photo_date;
	}
	public void setPhoto_date(String photo_date) {
		this.photo_date = photo_date;
	}
	public String getPhoto_count() {
		return photo_count;
	}
	public void setPhoto_count(String photo_count) {
		this.photo_count = photo_count;
	}
	public String getPhoto_filename() {
		return photo_filename;
	}
	public void setPhoto_filename(String photo_filename) {
		this.photo_filename = photo_filename;
	}
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
	@Override
	public String toString() {
		return "PhotoVO [photo_no=" + photo_no + ", photo_title=" + photo_title + ", photo_content=" + photo_content
				+ ", photo_date=" + photo_date + ", photo_count=" + photo_count + ", photo_filename=" + photo_filename
				+ ", party_no=" + party_no + ", user_no=" + user_no + "]";
	}
	
	

}
