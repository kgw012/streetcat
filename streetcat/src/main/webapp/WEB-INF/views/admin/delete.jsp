<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- delete.jsp -->
    <%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<html>
<head>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
	<title>회원 삭제</title>
</head>
<body>	
<div align="center">
	<b>회원 삭제</b>
	<form name="f" action="delete.do" method="post">
		<input type="hidden" name="unum" value="${param.unum}"/>
		<table border="1" width="300">
			<tr bgcolor="yellow">
				<th>정말 삭제합니까? <br> check 를 입력하면 삭제 됩니다.</th>			
			</tr>
			<tr>
				<td align="center"> 입력 : 
					<input type="text" name="check" class="box">
				</td>
			</tr>
			<tr bgcolor="yellow">
				<td align="center">
					<input type="submit" value="글삭제">
					<input type="button" value="글목록" onclick="window.location='admin_list.do'">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
