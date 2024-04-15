package ddit.vo;

public class HashtagVO {
	private int hashtag_no;
	private String hashtag_name;
	public int getHashtag_no() {
		return hashtag_no;
	}
	public void setHashtag_no(int hashtag_no) {
		this.hashtag_no = hashtag_no;
	}
	public String getHashtag_name() {
		return hashtag_name;
	}
	public void setHashtag_name(String hashtag_name) {
		this.hashtag_name = hashtag_name;
	}
	@Override
	public String toString() {
		return "HashtagVO [hashtag_no=" + hashtag_no + ", hashtag_name=" + hashtag_name + "]";
	}
	
	
}
