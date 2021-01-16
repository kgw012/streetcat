<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- product_content.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	
	<title>�۳���</title>
</head>
<body>
<div align="center">
	<b>�۳��� ����</b>
	<table border="1" width="600">
		<tr>
			<th bgcolor="yellow" width="20%">�۹�ȣ</th>
			<td width="30%" align="center">${getProduct.pnum}</td>
			<th bgcolor="yellow" width="20%">��õ��</th>
			<td width="30%" align="center">${getProduct.plike}</td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">��ǰ��</th>
			<td width="30%" align="center">${getProduct.pname}</td>
			<th bgcolor="yellow" width="20%">�Ǹ��� �̸�</th>
			<td width="30%" align="center">${getProduct.shopname}</td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">����</th>
			<td width="30%" align="center" colspan="3">
			<c:if test= "${getProduct.type eq 'snack'}" >
			����
			</c:if>
			<c:if test= "${getProduct.type eq 'toy'}" >
			�峭��
			</c:if>
			<c:if test= "${getProduct.type eq 'feed'}" >
			���
			</c:if>
			<c:if test= "${getProduct.type eq 'sand'}" >
			��
			</c:if></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">��ǰ ����</th>
			<td width="30%" align="center" colspan="3"><img src="${uploadPath}/${getProduct.image1}" width="300" height="300"></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">��Ÿ ����</th>
			<td width="30%" align="center" colspan="3"><img src="${uploadPath}/${getProduct.image2}" width="300" height="300"></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">�۳���</th>
			<td width="80%" align="center" colspan="3">${getProduct.content}</td>
		</tr>
		<tr>
			<td width="80%" align="right" colspan="4">
			<c:if test="${grade eq '������' }">
				<input type="button" value="�ۼ���" onclick="window.location='product_update.do?pnum=${getProduct.pnum}'">
				<input type="button" value="�ۻ���" onclick="window.location='product_delete.do?pnum=${getProduct.pnum}'">
			</c:if>	
				<input type="button" value="�۸��" onclick="window.location='product_list.do?unum=${unum}'">
			</td>
		</tr>
	</table>
</div>
</body>
</html>










