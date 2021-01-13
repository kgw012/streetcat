<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>고양이 검색</title>
</head>
<body>
	<div align="center">
		<h1>고양이 검색</h1>
		<br>
		<script type="text/javascript">  
			function openSearchCat(){  
			    window.open("searchCat.do", "고양이 찾아보기", "width=800, height=500, resizable=no" );  
			}
		</script>
		<form name="f" action="cat_list.do" method="post">
			<select name="searchString">
				<option value="name">이름검색</option>
				<option value="location">지역검색</option>
				<option value="feature">특징검색</option>
			</select>
				<input type="text" name="search">
				<input type="button" value="위치로 찾기" onclick="javascript:openSearchCat();">
				<input type="submit" value="검색">
		</form>
		<br>
		<h2>고양이 목록</h2>
		<table border="1" style="width:80%;">
			<tr>
				<td align="right" colspan="4"><a href="cat_insert.do">고양이 등록하기</a></td>
			</tr>
			<tr>
				<th>이름</th>
				<th>특징</th>
				<th>대표사진</th>
				<th>출현위치</th>
			</tr>
<c:if test="${empty catList}">		
			<tr>
				<td colspan="4">등록된 고양이가 없습니다.</td>
			</tr>
</c:if>
<c:forEach var="dto" items="${catList}">
			<tr>
				<td>${dto.cname }</td>
				<td>${dto.feature }</td>
				<td>${dto.image }</td>
				<td>${dto.location }</td>
			</tr>
</c:forEach>
		</table>
	</div>
</body>
</html>