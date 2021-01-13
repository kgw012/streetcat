package com.ezen709.streetcat.model;

public class CatBoardCommentDTO {
 private int comment_num;
 private int bnum;
 private String writer;
 private String content;
 private String reg_date;
 private int re_step;
 private int re_level;

public int getComment_num() {
	return comment_num;
}
public void setComment_num(int comment_num) {
	this.comment_num = comment_num;
}
public int getBnum() {
	return bnum;
}
public void setBnum(int bnum) {
	this.bnum = bnum;
}
public String getWriter() {
	return writer;
}
public void setWriter(String writer) {
	this.writer = writer;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}

public String getReg_date() {
	return reg_date;
}
public void setReg_date(String reg_date) {
	this.reg_date = reg_date;
}
public int getRe_step() {
	return re_step;
}
public void setRe_step(int re_step) {
	this.re_step = re_step;
}
public int getRe_level() {
	return re_level;
}
public void setRe_level(int re_level) {
	this.re_level = re_level;
}
 
}
