<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- product_content.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	
	<title>글내용</title>
</head>
<body>
<div align="center">
	<b>글내용 보기</b>
	<table border="1" width="600">
		<tr>
			<th bgcolor="yellow" width="20%">글번호</th>
			<td width="30%" align="center">${getProduct.pnum}</td>
			<th bgcolor="yellow" width="20%">추천수</th>
			<td width="30%" align="center">${getProduct.plike}</td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">상품명</th>
			<td width="30%" align="center">${getProduct.pname}</td>
			<th bgcolor="yellow" width="20%">판매점 이름</th>
			<td width="30%" align="center">${getProduct.shopname}</td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">종류</th>
			<td width="30%" align="center" colspan="3">
			<c:if test= "${getProduct.type eq 'snack'}" >
			간식
			</c:if>
			<c:if test= "${getProduct.type eq 'toy'}" >
			장난감
			</c:if>
			<c:if test= "${getProduct.type eq 'feed'}" >
			사료
			</c:if>
			<c:if test= "${getProduct.type eq 'sand'}" >
			모래
			</c:if></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">상품 사진</th>
			<td width="30%" align="center" colspan="3"><img src="${uploadPath}/${getProduct.image1}" width="300" height="300"></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">기타 사진</th>
			<td width="30%" align="center" colspan="3"><img src="${uploadPath}/${getProduct.image2}" width="300" height="300"></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">글내용</th>
			<td width="80%" align="center" colspan="3">${getProduct.content}</td>
		</tr>
		<tr>
			<td width="80%" align="right" colspan="4">
			<c:if test="${grade eq '관리자' }">
				<input type="button" value="글수정" onclick="window.location='product_update.do?pnum=${getProduct.pnum}'">
				<input type="button" value="글삭제" onclick="window.location='product_delete.do?pnum=${getProduct.pnum}'">
			</c:if>	
				<input type="button" value="글목록" onclick="window.location='product_list.do?unum=${unum}'">
			</td>
		</tr>
	</table>
</div>
</body>
</html>










