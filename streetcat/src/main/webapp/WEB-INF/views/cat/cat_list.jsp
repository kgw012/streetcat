<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>����� �˻�</title>
	<script type="text/javascript">
		function open_serachCat(){
			var width = 700;
			var height = 600;
			var left = window.screen.width / 2 - width / 2;
			var top = window.screen.height / 2 - height / 2;
			window.open("searchCat.do", "����� ��ġ��ã��", "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
		}
		function isLogin(unum){
			if(unum == null){
				alert("�α��� �� �̿����ּ���");
				return;
			}
			document.reg.submit();
		}
	</script>
</head>
<body>
    <h2><a href="home.do">CATSTREET</a></h2>
	<div align="center">
		<h1>����� �˻�</h1>
		<br>
		<form name="f" action="cat_list.do" method="post">
			<select name="searchString">
				<option value="name">�̸��˻�</option>
				<option value="feature">Ư¡�˻�</option>
			</select>
				<input type="text" name="search">
				<input type="button" value="��ġ�� ã��" onclick="open_serachCat();">
				<input type="submit" value="�˻�">
		</form>
		<br>
		<h2>����� ���</h2>
		<table border="1" style="width:80%;">
			<tr>
				<td align="right" colspan="4">
					<form name="reg" action="cat_insert.do" method="post">
						<input type="hidden" name="unum" value="${sessionScope.unum}">
						<a href="javascript:isLogin(${sessionScope.unum})">����� ����ϱ�</a>
					</form>
				
				</td>
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
				<td align="center"><a href="cat_content.do?cnum=${dto.cnum}"><img src="./resources/upload/${dto.image}" width="150" height="150"></a></td>
				<td align="center">${dto.location }</td>
			</tr>
</c:forEach>
		</table>
	</div>
</body>
</html>