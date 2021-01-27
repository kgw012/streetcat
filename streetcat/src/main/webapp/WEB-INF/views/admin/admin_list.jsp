<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"  %>
<!-- memberAll.jsp -->
    <%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">

<%@include file ="top.jsp" %>


<div align="center">

	<hr color="green" width="300">

	<c:if test = "${mode == 'all'}">
	<h2>회 원 목 록 보 기</h2>
	</c:if>
	<c:if test ="${mode== 'find'}">
	<h2>회 원 찾 기</h2>
	<form name="f"  action="find.do" method="post">
	<input type="hidden" name="mode" value="find"/>
		<select name="search">
			<option value="userId">아이디</option>
			<option value="name">이름</option>
		</select>
		<input type="text" name="searchString" class="box">
		<input type="submit" value="찾기">
	</form>
	</c:if>

	<hr color="green" width="300">
	<table width="100%" class="outline" >
		<tr>
			<th class="m3">번호</th>
			<th class="m3">이름</th>
			<th class="m3">아이디</th>
			<th class="m3">이메일</th>
			<th class="m3">가입일</th>
			<th class="m3">등급</th>
			<th class="m3">등급수정|삭제</th>
		</tr>
		 

<c:if test ="${empty listMember }" >
		<tr>
			<td colspan="8">등록된 회원이 없습니다.</td>
		</tr>
		</c:if>
<c:forEach var="dto" items="${listMember}">
		<tr>
			<td>${dto.unum }</td>
			<td>${dto.name }</td>
			<td>${dto.userId }</td>
			<td>${dto.email }</td>
			<td align="center">${dto.joindate }</td>
			<td align="center">
			<c:if test="${empty dto.grade}">	
			일반회원
			</c:if>
			<c:if test= "${dto.grade eq '0'}" >
			일반회원
			</c:if>
			<c:if test= "${dto.grade eq '1'}" >
			준회원
			</c:if>
			<c:if test= "${dto.grade eq '2'}" >
			우수회원
			</c:if>
			<c:if test= "${dto.grade eq '3'}" >
			관리자
			</c:if>
			
			</td>
			<td align="center"><a href="upgrade.do?unum=${dto.unum}">수정</a> |
										<a href="delete.do?unum=${dto.unum}">삭제</a></td>
				
			</tr>	
		</c:forEach>
	</table>
</div>




<%@include file ="bottom.jsp" %>






