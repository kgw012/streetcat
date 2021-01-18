<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>����� �˻�</title>
</head>
<body>
	<div align="center">
		<h1>����� �˻�</h1>
		<br>
		<form name="f" action="cat_list.do" method="post">
			<select name="searchString">
				<option value="name">�̸��˻�</option>
				<option value="feature">Ư¡�˻�</option>
			</select>
				<input type="text" name="search">
				<input type="submit" value="�˻�">
		</form>
		<br>
		<h2>����� ���</h2>
		<table border="1" style="width:80%;">
			<tr>
				<td align="right" colspan="4"><a href="cat_insert.do">����� ����ϱ�</a></td>
			</tr>
			<tr>
				<th>�̸�</th>
				<th>Ư¡</th>
				<th>��ǥ����</th>
				<th>������ġ</th>
			</tr>
<c:if test="${empty catList}">	
			<tr>
				<td colspan="4">��ϵ� ����̰� �����ϴ�.</td>
			</tr>
</c:if>
<c:forEach var="dto" items="${catList}">
			<tr>
				<td align="center"><a href="cat_content.do?cnum=${dto.cnum}">${dto.name }</a></td>
				<td align="center">${dto.feature }</td>
				<td align="center"><a href="cat_content.do?cnum=${dto.cnum}"><img src="${uploadPath}/${dto.image}" width="150" height="150"></a></td>
				<td align="center">${dto.location }</td>
			</tr>
</c:forEach>
		</table>
	</div>
</body>
</html>