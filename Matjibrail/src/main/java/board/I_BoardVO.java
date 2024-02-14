package board;

import java.sql.Timestamp;

public class I_BoardVO {

	private int mi_num;
	private String mi_writer;
	private String mi_pass;
	private String mi_subject;
	private int mi_readcount;
	private String mi_content;
	private String mi_image;
	private Timestamp mi_postdate;
	
	public I_BoardVO() {
	
	}
	
	public int getMi_num() {
		return mi_num;
	}
	public void setMi_num(int mi_num) {
		this.mi_num = mi_num;
	}
	public String getMi_writer() {
		return mi_writer;
	}
	public void setMi_writer(String mi_writer) {
		this.mi_writer = mi_writer;
	}
	public String getMi_pass() {
		return mi_pass;
	}
	public void setMi_pass(String mi_pass) {
		this.mi_pass = mi_pass;
	}
	public String getMi_subject() {
		return mi_subject;
	}
	public void setMi_subject(String mi_subject) {
		this.mi_subject = mi_subject;
	}
	public int getMi_readcount() {
		return mi_readcount;
	}
	public void setMi_readcount(int mi_readcount) {
		this.mi_readcount = mi_readcount;
	}
	public String getMi_content() {
		return mi_content;
	}
	public void setMi_content(String mi_content) {
		this.mi_content = mi_content;
	}
	public String getMi_image() {
		return mi_image;
	}
	public void setMi_image(String mi_image) {
		this.mi_image = mi_image;
	}
	public Timestamp getMi_postdate() {
		return mi_postdate;
	}
	public void setMi_postdate(Timestamp mi_postdate) {
		this.mi_postdate = mi_postdate;
	}
	
	
}
