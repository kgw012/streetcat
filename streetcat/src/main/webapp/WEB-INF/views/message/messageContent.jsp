<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!-- messageContent.jsp -->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>

	<div class="container">
		<div class="jumbotron">
			<h2>쪽 지 보 기</h2>
			<div align="right">
			<button type="button" class="btn btn-default" onclick="window.location.href = 'messageWrite.do?sendId=${getMessage.sendId}'">답장</button>
			<button type="button" class="btn btn-default" onclick="history.back()">뒤로가기</button>
			</div>
		<table border="1" width="100%" class="table table-hover">
		 <tr>
		  <td>
		    받은사람 : ${getMessage.receiveId}<br>
		    보낸사람 : ${getMessage.sendId}<br>
		    작성일자 : ${getMessage.reg_date}
		  </td>
		 </tr>
		  <tr>
		  <td>
		   <br>
		   ${getMessage.content}<p>
		   </td>
		  </tr>
		</table>
		</div>
	</div>


	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
		
<%@ include file="../bottom.jsp" %>