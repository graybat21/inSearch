package com.insearch.vo;

import java.util.Date;

public class UserVO {
	private int no;
	private String id;
	private String pw;
	private String email;
	private int gender;
	private int agerange;
	private int emailflag;
	private Date createdate;
	private Date lastaccessdate;
		
	public UserVO() {
		super();
	}

	public UserVO(int no, String id, String pw, String email, int gender, 
			int agerange, int emailflag, Date createdate, Date lastaccessdate) {
		super();
		this.no = no;
		this.id = id;
		this.pw = pw;
		this.email = email;
		this.gender = gender;
		this.agerange = agerange;
		this.emailflag = emailflag;
		this.createdate = createdate;
		this.lastaccessdate = lastaccessdate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public int getAgerange() {
		return agerange;
	}

	public void setAgerange(int agerange) {
		this.agerange = agerange;
	}

	public int getEmailflag() {
		return emailflag;
	}

	public void setEmailflag(int emailflag) {
		this.emailflag = emailflag;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public Date getLastaccessdate() {
		return lastaccessdate;
	}

	public void setLastaccessdate(Date lastaccessdate) {
		this.lastaccessdate = lastaccessdate;
	}

	@Override
	public String toString() {
		return "UserVO [no=" + no + ", id=" + id + ", pw=" + pw + ", email=" + email + ", gender=" + gender
				+ ", agerange=" + agerange + ", emailflag=" + emailflag + ", createdate=" + createdate
				+ ", lastaccessdate=" + lastaccessdate + "]";
	}
}
