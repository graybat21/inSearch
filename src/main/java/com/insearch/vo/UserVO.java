package com.insearch.vo;

import java.sql.Date;

public class UserVO {
	private int no;
	private String email;
	private String pw;
	private int gender;
	private int agerange;
	private int emailflag;
	private Date createdate;
	private Date lastaccessdate;
		
	public UserVO() {
		super();
	}
		
	public UserVO(int no, String email, String pw, int gender, int agerange, int emailflag, Date createdate,
			Date lastaccessdate) {
		super();
		this.no = no;
		this.email = email;
		this.pw = pw;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
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
		return "UserVO [no=" + no + ", email=" + email + ", pw=" + pw + ", gender=" + gender + ", agerange=" + agerange
				+ ", emailflag=" + emailflag + ", createdate=" + createdate + ", lastaccessdate=" + lastaccessdate
				+ "]";
	}
	
	
}
