package com.ezen709.streetcat.model;

public class FindCatBoardDTO {
 private String type;
 private String searchString;
 private int start;
 private int end;
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}

public String getSearchString() {
	return searchString;
}
public void setSearchString(String searchString) {
	this.searchString = searchString;
}
public int getStart() {
	return start;
}
public void setStart(int start) {
	this.start = start;
}
public int getEnd() {
	return end;
}
public void setEnd(int end) {
	this.end = end;
}
 
}
