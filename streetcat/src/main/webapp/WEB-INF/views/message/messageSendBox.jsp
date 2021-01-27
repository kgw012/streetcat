<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>

	<div class="container">
		<div class="jumbotron">
			<h2>보 낸 쪽 지 함</h2>
			<div align="right">
			<button type="button" class="btn btn-default" onclick="window.location.href('messageWrite.do')">쪽지쓰기</button>
			<button type="button" class="btn btn-default" onclick="window.location.href('messageBox.do')">받은쪽지함</button>
			</div>
		<table border="1" width="100%" class="table table-hover">
		 <tr>
		  <td width="8%">
		     선 택
		  </td>
		  <td width="12%">
		   받은사람
		  </td>
		  <td>
		  내 용
		  </td>
		  <td width="16%">
		  날 짜
		  </td >
		  <td width="16%">
		 열람
		  </td >
		 </tr>
		 <tr>
		  <c:if test="${empty getMessage }">
		  <td colspan="4">
		  보낸 쪽지가 없습니다
		  </td>
		  </c:if>
		  <c:forEach var="dto" items="${getMessage}">
		  <tr>
		  <td width="8%">
		     선 택
		  </td>
		  <td width="12%">
		   ${dto.receiveId}
		  </td>
		  <td>
		   ${dto.content}
		  </td>
		  <td width="16%">
		   ${dto.reg_date}
		  </td>  
		  <td width="16%">
		  <c:if test="${dto.read==0}">
		     미</c:if>열람
		  </td>  
		  </tr>
 		  </c:forEach>
		 </tr>
		</table>
		</div>
	</div>

<%@ include file="../bottom.jsp" %>