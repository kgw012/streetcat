<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>

	<div class="container">
		<div class="jumbotron">
			<h2>�� �� �� �� ��</h2>
			<div align="right">
			<button type="button" class="btn btn-default" onclick="window.location.href('messageWrite.do')">��������</button>
			<button type="button" class="btn btn-default" onclick="window.location.href('messageSendBox.do')">����������</button>
			</div>
		<table border="1" width="100%" class="table table-hover">
		 <tr>
		  <td width="8%">
		     �� ��
		  </td>
		  <td width="12%">
		   �������
		  </td>
		  <td>
		  �� ��
		  </td>
		  <td width="16%">
		  �� ¥
		  </td >
		 </tr>
		 <tr>
		 <c:if test="${empty getMessage }">
		  <td colspan="4">
		  ���� ������ �����ϴ�
		  </td>
		  </c:if>
		  <c:forEach var="dto" items="${getMessage}">
		  <td width="8%">
		     �� ��
		  </td>
		  <td width="12%">
		   ${dto.sendId}
		  </td>
		  <td>
		   ${dto.content}
		  </td>
		  <td width="16%">
		   ${dto.reg_date}
		  </td>  
 		  </c:forEach>
		 </tr>
		</table>
			
			
			
			
			
			
			
			
		</div>
	</div>

<%@ include file="../bottom.jsp" %>