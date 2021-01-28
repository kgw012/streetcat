package com.ezen709.streetcat.model;

public class MemberDTO {
	private int unum;
	private String name;
	private String userId;
	private String passwd;
	private String email;
	private String joindate;
	private int grade;

	
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getUnum() {
		return unum;
	}
	public void setUnum(int unum) {
		this.unum = unum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	@Override
    public String toString() {
        return "MemberDTO [userId=" + userId + ", passwd=" + passwd + ", email=" + email + ", joindate="
                + joindate + "]";
    }
}
