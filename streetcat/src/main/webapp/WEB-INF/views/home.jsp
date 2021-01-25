<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- home.jsp-->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>


<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
	<title>CatStreet</title>
</head>
 <h3></h3>
<body>
<h2 align="center">Street Cat</h2>
	<div align ="center">
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
			<table border="1" width="100%">
	        <tr>
	        <td valign="top">
	        <c:if test="${!empty mbId }">
	   		 [${grade}] <br>
	   		  ${mbId}님 로그인 중.. 
	   		   <c:if test="${grade eq '관리자' }">
				<br><br><br><a href="admin_list.do">회원관리</a>
				<br><br><br>
				</c:if>
	       
	        <form name="f" action="member_logout.do" method="get">
	        <input type="submit" value="로그아웃">
	        </form>
	        </c:if>
	        <c:if test="${empty mbId}">
	        <br><br><br><br>
	                 회원 로그인<br>
	        <form name="f" action="member_login.do" method="post">
	        <input type="text" name="id" ><br>
	        <input type="password" name="passwd"><br>
	        <input type="submit" value="로그인">
	        <button type="button" onclick="window.open('member.do','회원가입', 'width=570, height=350, resizable = no, scrollbars = no')">회원가입</button>
	        </form>
	        </c:if>
	        </td>
			<c:choose>
				<c:when test="${empty boardList }" >
			
					<td align="center">
					<table>
					<tr>
					<td><%@ include file="./chatting.jsp"%></td>
					</tr>
					<tr>
					<td>
					<img src="./resources/image/cat.jpg" width="900" height="600">
					</td>
					</tr>
					</table>
					</td>
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
	</div>
</body>
</html>