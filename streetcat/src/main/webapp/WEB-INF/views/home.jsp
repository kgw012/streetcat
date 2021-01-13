<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- home.jsp-->

<html>
<head>
<meta charset="UTF-8">
	<title>CatStreet</title>
</head>
<body>
	<div class="login_area">
		<div class="login_button">
			<a href="member_login.do">로그인</a>
		</div>
		<span>
			<a href="member.do">회원가입</a>
		</span>
	</div>
	<div class="clearfix">
	</div>	
<h2>Street Cat</h2>
	<table>
		<colgroup>
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
		</colgroup>
		<thead>
			<tr>
				<th><a href="catstreet_info.do">길냥이 정보 게시판</a></th>
				<th><a href="cat_list.do">길냥이 검색</a></th>
				<th><a href="catstreet_qna.do">Q&A</a></th>
				<th><a href="product_list.do">상품추천</a></th>
				<th><a href="admin_list.do">관리자 회원목록(삭제예정)</a></th>  
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty boardList }" >
					<tr><td colspan="4" align="center"> <img src="./resources/image/cat.jpg" width="900" height="600"></td></tr>
				</c:when> 
				<c:when test="${!empty boardList}">
					<c:forEach var="list" items="${boardList}">
						<tr>
							<td><c:out value="${list.name}"/></td>
							<td><c:out value="${list.title}"/></td>
							<td><c:out value="${list.reg_id}"/></td>
							<td><c:out value="${list.view_cnt}"/></td>
							<td><c:out value="${list.reg_dt}"/></td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</tbody>
	</table>
</body>
</html>