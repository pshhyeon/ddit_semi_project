package ddit.vo;

public class CommentVO {
	private int comments_no;
	private String comments_con;
	private String comments_date;
	private int board_no;
	private int user_no;
	private String nickname;
	
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getComments_no() {
		return comments_no;
	}
	public void setComments_no(int comments_no) {
		this.comments_no = comments_no;
	}
	public String getComments_con() {
		return comments_con;
	}
	public void setComments_con(String comments_con) {
		this.comments_con = comments_con;
	}
	public String getComments_date() {
		return comments_date;
	}
	public void setComments_date(String comments_date) {
		this.comments_date = comments_date;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	@Override
	public String toString() {
		return "CommentVO [comments_no=" + comments_no + ", comments_con=" + comments_con + ", comments_date="
				+ comments_date + ", board_no=" + board_no + ", user_no=" + user_no + "]";
	}
	
}
