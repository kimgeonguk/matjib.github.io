package board;

import java.sql.Timestamp;

public class F_BoardVO {

	private int mf_num;
	private String mf_writer;
	private String mf_pass;
	private String mf_subject;
	private int mf_readcount;
	private String mf_content;
	private String mf_image;
	private Timestamp mf_postdate;
	
	public F_BoardVO() {
	
	}

	public int getMf_num() {
		return mf_num;
	}

	public void setMf_num(int mf_num) {
		this.mf_num = mf_num;
	}

	public String getMf_writer() {
		return mf_writer;
	}

	public void setMf_writer(String mf_writer) {
		this.mf_writer = mf_writer;
	}

	public String getMf_pass() {
		return mf_pass;
	}

	public void setMf_pass(String mf_pass) {
		this.mf_pass = mf_pass;
	}

	public String getMf_subject() {
		return mf_subject;
	}

	public void setMf_subject(String mf_subject) {
		this.mf_subject = mf_subject;
	}

	public int getMf_readcount() {
		return mf_readcount;
	}

	public void setMf_readcount(int mf_readcount) {
		this.mf_readcount = mf_readcount;
	}

	public String getMf_content() {
		return mf_content;
	}

	public void setMf_content(String mf_content) {
		this.mf_content = mf_content;
	}

	public String getMf_image() {
		return mf_image;
	}

	public void setMf_image(String mf_image) {
		this.mf_image = mf_image;
	}

	public Timestamp getMf_postdate() {
		return mf_postdate;
	}

	public void setMf_postdate(Timestamp mf_postdate) {
		this.mf_postdate = mf_postdate;
	}

	
}
