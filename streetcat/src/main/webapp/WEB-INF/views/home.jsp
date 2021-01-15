<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- home.jsp-->

<html>

<head>
<meta charset="UTF-8">
	<title>CatStreet</title>
</head>
 <h3></h3>
<body>
<h2 align="center">Street Cat</h2>
	<table width="100%">
	
		<colgroup>
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
		</colgroup>
		
			<tr>
				<th><a href="cat_board.do">길냥이 일반 게시판</a></th>
				<th><a href="cat_list.do">길냥이 검색</a></th>
				<th><a href="catstreet_qna.do">Q&A</a></th>
				<th><a href="product_list.do">상품추천</a></th>
				
			</tr>
			</table>
			<br>
			<table width="100%">
	        <tr>
	        <td valign="top">
	        <c:if test="${!empty mbId and mbId ne admin }">
	        ${mbId}님 로그인 중...
	        <c:set var="mbId" value="${mbId}" scope="session"/>

	        </c:if>
	        <c:if test="${mbId eq admin }"> <!--회원등급으로 불러와서 보여줄수있도록 수정예정 -->
	        관리자 계정 접속 중
	        <c:set var="mbId" value="${mbId}" scope="session"/>
	        </c:if>
	        <c:if test="${empty mbId}">
	        <br><br><br><br>
	                 회원 로그인<br>
	        <form name="f" action="member_login.do" method="post">
	        <input type="text" name="id" ><br>
	        <input type="text" name="passwd"><br>
	        <input type="submit" value="로그인">
	        <button type="button" onclick="window.open('member.do','회원가입', 'width=570, height=350, resizable = no, scrollbars = no')">회원가입</button>
	        </form>
	        </c:if>
	        </td>
			<c:choose>
				<c:when test="${empty boardList }" >
					<td colspan="4" align="center"> <img src="./resources/image/cat.jpg" width="900" height="600"></td>
				</c:when> 
				<c:when test="${!empty boardList}">
					<c:forEach var="list" items="${boardList}">
						
							<td><c:out value="${list.name}"/></td>
							<td><c:out value="${list.title}"/></td>
							<td><c:out value="${list.reg_id}"/></td>
							<td><c:out value="${list.view_cnt}"/></td>
							<td><c:out value="${list.reg_dt}"/></td>
						
					</c:forEach>
				</c:when>
			</c:choose>
		</tr>
	</table>
	<li><a href="admin_list.do">관리자 회원목록(삭제예정)</a></li>  
</body>
</html>