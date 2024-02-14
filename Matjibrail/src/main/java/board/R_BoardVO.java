package board;

import java.sql.Timestamp;

public class R_BoardVO {

	private int mr_num;
	private String mr_writer;
	private String mr_pass;
	private String mr_subject;
	private int mr_readcount;
	private String mr_content;
	private String mr_image;
	private int mr_up;
	private String mr_header;
	private int mr_bcheck;
	private Timestamp mr_postdate;
	
	public R_BoardVO() {
	
	}

	public int getMr_num() {
		return mr_num;
	}

	public void setMr_num(int mr_num) {
		this.mr_num = mr_num;
	}

	public String getMr_writer() {
		return mr_writer;
	}

	public void setMr_writer(String mr_writer) {
		this.mr_writer = mr_writer;
	}

	public String getMr_pass() {
		return mr_pass;
	}

	public void setMr_pass(String mr_pass) {
		this.mr_pass = mr_pass;
	}

	public String getMr_subject() {
		return mr_subject;
	}

	public void setMr_subject(String mr_subject) {
		this.mr_subject = mr_subject;
	}

	public int getMr_readcount() {
		return mr_readcount;
	}

	public void setMr_readcount(int mr_readcount) {
		this.mr_readcount = mr_readcount;
	}

	public String getMr_content() {
		return mr_content;
	}

	public void setMr_content(String mr_content) {
		this.mr_content = mr_content;
	}

	public String getMr_image() {
		return mr_image;
	}

	public void setMr_image(String mr_image) {
		this.mr_image = mr_image;
	}

	public int getMr_up() {
		return mr_up;
	}

	public void setMr_up(int mr_up) {
		this.mr_up = mr_up;
	}

	public String getMr_header() {
		return mr_header;
	}

	public void setMr_header(String mr_header) {
		this.mr_header = mr_header;
	}

	public int getMr_bcheck() {
		return mr_bcheck;
	}

	public void setMr_bcheck(int mr_bcheck) {
		this.mr_bcheck = mr_bcheck;
	}

	public Timestamp getMr_postdate() {
		return mr_postdate;
	}

	public void setMr_postdate(Timestamp mr_postdate) {
		this.mr_postdate = mr_postdate;
	}
	
	
	
	
	
}
