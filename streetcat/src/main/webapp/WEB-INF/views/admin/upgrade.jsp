<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" %>
<!-- upgrade.jsp -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">

<%@include file ="top.jsp" %>


<form name="f" method="POST" action="upgrade.do">
	<input type="hidden" name="unum" value="${getMember.unum }"/>
	<table width="600" align="center" class="outline">
  		<tr>
			<td colspan="2" align=center class="m2">ȸ������</td>
 		</tr>
		<tr>
			<td width="150" class="m3">�̸�</td>
			<td class="m3">
				<input type="text" name="name" class="box" 
												value="${getMember.name}" readOnly>
			</td>
		</tr>
		<tr>
			<td width="150" class="m3">���̵�</td>
			<td class="m3">
				<input type="text" name="id" class="box"
												value="${getMember.id}" readOnly>
			</td>
  		</tr>
  	
  	
  		</tr>
  		<tr>
			<td width="150" class="m3">�̸���</td>
			<td class="m3">
				<input type="text" name="email" class="box"
											value="${getMember.email}" readOnly>
			</td>
  		</tr>
  		<tr>
			<td width="150" class="m3">ȸ�� ���</td>

				<td class="m3"><select name ="grade">
						<option>:::���:::</option>
						<option value="0">�Ϲ�ȸ��</option>
						<option value="1">��ȸ��</option>
						<option value="2">���ȸ��</option>
						<option value="3">������</option>
						
				</select>
			</td>
  		</tr>
  		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="��� ����">
				<a href="#">[���]</a>
			</td>
  		</tr>
  	</table>
</form>	




<%@include file ="bottom.jsp" %>










