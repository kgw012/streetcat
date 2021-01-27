<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"  %>
<!-- memberAll.jsp -->
    <%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">

<%@include file ="top.jsp" %>


<div align="center">

	<hr color="green" width="300">

	<c:if test = "${mode == 'all'}">
	<h2>ȸ �� �� �� �� ��</h2>
	</c:if>
	<c:if test ="${mode== 'find'}">
	<h2>ȸ �� ã ��</h2>
	<form name="f"  action="find.do" method="post">
	<input type="hidden" name="mode" value="find"/>
		<select name="search">
			<option value="userId">���̵�</option>
			<option value="name">�̸�</option>
		</select>
		<input type="text" name="searchString" class="box">
		<input type="submit" value="ã��">
	</form>
	</c:if>

	<hr color="green" width="300">
	<table width="100%" class="outline" >
		<tr>
			<th class="m3">��ȣ</th>
			<th class="m3">�̸�</th>
			<th class="m3">���̵�</th>
			<th class="m3">�̸���</th>
			<th class="m3">������</th>
			<th class="m3">���</th>
			<th class="m3">��޼���|����</th>
		</tr>
		 

<c:if test ="${empty listMember }" >
		<tr>
			<td colspan="8">��ϵ� ȸ���� �����ϴ�.</td>
		</tr>
		</c:if>
<c:forEach var="dto" items="${listMember}">
		<tr>
			<td>${dto.unum }</td>
			<td>${dto.name }</td>
			<td>${dto.userId }</td>
			<td>${dto.email }</td>
			<td align="center">${dto.joindate }</td>
			<td align="center">
			<c:if test="${empty dto.grade}">	
			�Ϲ�ȸ��
			</c:if>
			<c:if test= "${dto.grade eq '0'}" >
			�Ϲ�ȸ��
			</c:if>
			<c:if test= "${dto.grade eq '1'}" >
			��ȸ��
			</c:if>
			<c:if test= "${dto.grade eq '2'}" >
			���ȸ��
			</c:if>
			<c:if test= "${dto.grade eq '3'}" >
			������
			</c:if>
			
			</td>
			<td align="center"><a href="upgrade.do?unum=${dto.unum}">����</a> |
										<a href="delete.do?unum=${dto.unum}">����</a></td>
				
			</tr>	
		</c:forEach>
	</table>
</div>




<%@include file ="bottom.jsp" %>






