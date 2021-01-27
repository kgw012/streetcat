<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- index.jsp-->
<%@ include file="./top.jsp" %>
<%@ include file="./navbar.jsp" %>

<div class="container">
	<div class="jumbotron">
		<br>
		<button type="button" onclick="window.open('chatting.do')">채팅방 가기</button>
		<br>
		<img class="img-responsive center-block img-rounded" 
	 		src="./resources/image/cat.jpg" width="900" height="600">
	</div>
</div>

<%@ include file="./bottom.jsp" %>