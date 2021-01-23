<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>길냥이 검색</title>
	<script type="text/javascript">
		function open_serachCat(){
			var width = 700;
			var height = 600;
			var left = window.screen.width / 2 - width / 2;
			var top = window.screen.height / 2 - height / 2;
			window.open("searchCat.do", "고양이 위치로찾기", "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
		}
		function isLogin(unum){
			if(unum == null){
				alert("로그인 후 이용해주세요");
				return;
			}
			document.reg.submit();
		}
	</script>
</head>
<body>
    <h2><a href="home.do">CATSTREET</a></h2>
	<div align="center">
		<h1>길냥이 검색</h1>
		<br>
		<form name="f" action="cat_list.do" method="post">
			<select name="searchString">
				<option value="name">이름검색</option>
				<option value="feature">특징검색</option>
			</select>
				<input type="text" name="search">
				<input type="button" value="위치로 찾기" onclick="open_serachCat();">
				<input type="submit" value="검색">
		</form>
		<br>
		<h2>길냥이 목록</h2>
		<table border="1" style="width:80%;">
			<tr>
				<td align="right" colspan="4">
					<form name="reg" action="cat_insert.do" method="post">
						<input type="hidden" name="unum" value="${sessionScope.unum}">
						<a href="javascript:isLogin(${sessionScope.unum})">길냥이 등록하기</a>
					</form>
				
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<th>특징</th>
				<th>대표사진</th>
				<th>출현위치</th>
			</tr>
<c:if test="${empty catList}">	
			<tr>
				<td colspan="4">등록된 길냥이가 없습니다.</td>
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