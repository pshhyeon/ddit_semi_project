package ddit.vo;

public class NotificeVO {
	private int notifice_no;
	private String notifice_title;
	private String notifice_content;
	private String notifice_date;
	private String notifice_count;
	public int getNotifice_no() {
		return notifice_no;
	}
	public void setNotifice_no(int notifice_no) {
		this.notifice_no = notifice_no;
	}
	public String getNotifice_title() {
		return notifice_title;
	}
	public void setNotifice_title(String notifice_title) {
		this.notifice_title = notifice_title;
	}
	public String getNotifice_content() {
		return notifice_content;
	}
	public void setNotifice_content(String notifice_content) {
		this.notifice_content = notifice_content;
	}
	public String getNotifice_date() {
		return notifice_date;
	}
	public void setNotifice_date(String notifice_date) {
		this.notifice_date = notifice_date;
	}
	public String getNotifice_count() {
		return notifice_count;
	}
	public void setNotifice_count(String notifice_count) {
		this.notifice_count = notifice_count;
	}
	@Override
	public String toString() {
		return "Notifice [notifice_no=" + notifice_no + ", notifice_title=" + notifice_title + ", notifice_content="
				+ notifice_content + ", notifice_date=" + notifice_date + ", notifice_count=" + notifice_count + "]";
	}
	
}
