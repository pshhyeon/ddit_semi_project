package ddit.vo;

public class BoardVO {
	private int board_no;
	private String board_title;
	private String board_content;
	private String board_date;
	private int board_count;
	private int user_no;
	private String board_file_name;
	private String nickname;
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public int getBoard_count() {
		return board_count;
	}
	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getBoard_file_name() {
		return board_file_name;
	}
	public void setBoard_file_name(String board_file_name) {
		this.board_file_name = board_file_name;
	}
	@Override
	public String toString() {
		return "BoardVO [board_no=" + board_no + ", board_title=" + board_title + ", board_content=" + board_content
				+ ", board_date=" + board_date + ", board_count=" + board_count + ", user_no=" + user_no
				+ ", board_file_name=" + board_file_name + "]";
	}
	
	
}
