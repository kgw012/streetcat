<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- delete.jsp -->
    <%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<html>
<head>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
	<title>ȸ�� ����</title>
</head>
<body>	
<div align="center">
	<b>ȸ�� ����</b>
	<form name="f" action="delete.do" method="post">
		<input type="hidden" name="unum" value="${param.unum}"/>
		<table border="1" width="300">
			<tr bgcolor="yellow">
				<th>���� �����մϱ�? <br> check �� �Է��ϸ� ���� �˴ϴ�.</th>			
			</tr>
			<tr>
				<td align="center"> �Է� : 
					<input type="text" name="check" class="box">
				</td>
			</tr>
			<tr bgcolor="yellow">
				<td align="center">
					<input type="submit" value="�ۻ���">
					<input type="button" value="�۸��" onclick="window.location='admin_list.do'">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
