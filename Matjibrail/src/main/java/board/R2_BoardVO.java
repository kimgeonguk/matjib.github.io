package board;

import java.sql.Timestamp;

public class R2_BoardVO {

	private int mr2_num;
	private String mr2_writer;
	private String mr2_pass;
	private String mr2_subject;
	private int mr2_readcount;
	private String mr2_content;
	private String mr2_image;
	private int mr2_up;
	private String mr2_header;
	private Timestamp mr2_postdate;
	
	public R2_BoardVO() {
	
	}

	public int getMr2_num() {
		return mr2_num;
	}

	public void setMr2_num(int mr2_num) {
		this.mr2_num = mr2_num;
	}

	public String getMr2_writer() {
		return mr2_writer;
	}

	public void setMr2_writer(String mr2_writer) {
		this.mr2_writer = mr2_writer;
	}

	public String getMr2_pass() {
		return mr2_pass;
	}

	public void setMr2_pass(String mr2_pass) {
		this.mr2_pass = mr2_pass;
	}

	public String getMr2_subject() {
		return mr2_subject;
	}

	public void setMr2_subject(String mr2_subject) {
		this.mr2_subject = mr2_subject;
	}

	public int getMr2_readcount() {
		return mr2_readcount;
	}

	public void setMr2_readcount(int mr2_readcount) {
		this.mr2_readcount = mr2_readcount;
	}

	public String getMr2_content() {
		return mr2_content;
	}

	public void setMr2_content(String mr2_content) {
		this.mr2_content = mr2_content;
	}

	public String getMr2_image() {
		return mr2_image;
	}

	public void setMr2_image(String mr2_image) {
		this.mr2_image = mr2_image;
	}

	public int getMr2_up() {
		return mr2_up;
	}

	public void setMr2_up(int mr2_up) {
		this.mr2_up = mr2_up;
	}

	public String getMr2_header() {
		return mr2_header;
	}

	public void setMr2_header(String mr2_header) {
		this.mr2_header = mr2_header;
	}

	public Timestamp getMr2_postdate() {
		return mr2_postdate;
	}

	public void setMr2_postdate(Timestamp mr2_postdate) {
		this.mr2_postdate = mr2_postdate;
	}
	
	
}
