<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- home.jsp-->
<%@ include file="./top.jsp" %>
<%@ include file="./navbar.jsp" %>

	<div class="container">
		<div class="jumbotron">
			<br>
			<a href="chatting.do">ä�ù� ����</a>
			<button type="button" onclick="window.open('chatting.do')">ä�ù� ����</button>
			<button type="button" onclick="window.open('chatting.do')">ä�ù� ����!</button>
			<br>
			<img class="img-responsive center-block img-rounded" 
		 		src="./resources/image/cat.jpg" width="900" height="600">
		</div>
	</div>

<%@ include file="./bottom.jsp" %>