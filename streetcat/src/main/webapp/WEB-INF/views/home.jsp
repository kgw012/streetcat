<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- home.jsp-->
<%@ include file="./top.jsp" %>
<%@ include file="./navbar.jsp" %>

	<div class="container">
		<div class="jumbotron">
			<img class="img-responsive center-block img-rounded" 
		 		src="./resources/image/cat.jpg" width="900" height="600">
		</div>
	</div>
	
	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<%@ include file="./bottom.jsp" %>