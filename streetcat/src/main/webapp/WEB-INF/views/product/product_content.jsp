<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- product_content.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	  <script>
   
   function isLoginLike(pnum,mbNo){
  	 <% if(session.getAttribute("mbId")==null){%>
  	 alert("�α��� �� �̿����ּ���")
  	 <%}else{%>
  	 alert("��õ �Ϸ�!")
  	 location.href = "product_like.do?pnum="+pnum+"&mbNo="+mbNo;
  	 <%}%>
   }
   function isLoginUnLike(pnum,mbNo){
	  	 <% if(session.getAttribute("mbId")==null){%>
	  	 alert("�α��� �� �̿����ּ���")
	  	 <%}else{%>
	  	 alert("��õ ���!")
	  	 location.href = "product_unLike.do?pnum="+pnum+"&mbNo="+mbNo;
	  	 <%}%>
	   }
   </script>
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
			<c:if test= "${getProduct.type eq 'tuna'}" >
			��ġ
			</c:if>
			<c:if test= "${getProduct.type eq 'toy'}" >
			�峭��
			</c:if>
			<c:if test= "${getProduct.type eq 'feed'}" >
			���
			</c:if>
			<c:if test= "${getProduct.type eq 'sand'}" >
			��
			</c:if>
			<c:if test= "${getProduct.type eq 'etc'}" >
			��Ÿ
			</c:if></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">��ǰ ����</th>
			<td width="30%" align="center" colspan="3"><img src="./resources/upload/product/${getProduct.image1}" width="300" height="300"></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">��Ÿ ����</th>
			<td width="30%" align="center" colspan="3"><img src="./resources/upload/product/${getProduct.image2}" width="300" height="300"></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">�۳���</th>
			<td width="80%" align="center" colspan="3">${getProduct.content}</td>
		</tr>
		<tr>
			<c:choose>
  <c:when test="${like=='like'}">
  <td>
   <button onclick="isLoginUnLike('${getProduct.pnum}','${mbNo}')" >����ing : ${getProduct.plike}</button>
  </td>
  </c:when>
  <c:when test="${like=='unlike'}">
  <td>
   <button onclick="isLoginLike('${getProduct.pnum}','${mbNo}')"  >����? : ${getProduct.plike}</button>
   </td>
  </c:when>
  			</c:choose>
			<td width="80%" align="right" colspan="3">
			<c:if test="${grade eq '������' or unum eq getProduct.unum}">
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










