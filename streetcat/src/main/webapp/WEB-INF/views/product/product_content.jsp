<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- product_content.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	  <script>
   
   function isLoginLike(pnum,mbNo){
  	 <% if(session.getAttribute("mbId")==null){%>
  	 alert("로그인 후 이용해주세요")
  	 <%}else{%>
  	 alert("추천 완료!")
  	 location.href = "product_like.do?pnum="+pnum+"&mbNo="+mbNo;
  	 <%}%>
   }
   function isLoginUnLike(pnum,mbNo){
	  	 <% if(session.getAttribute("mbId")==null){%>
	  	 alert("로그인 후 이용해주세요")
	  	 <%}else{%>
	  	 alert("추천 취소!")
	  	 location.href = "product_unLike.do?pnum="+pnum+"&mbNo="+mbNo;
	  	 <%}%>
	   }
   </script>
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
			<c:if test= "${getProduct.type eq 'tuna'}" >
			참치
			</c:if>
			<c:if test= "${getProduct.type eq 'toy'}" >
			장난감
			</c:if>
			<c:if test= "${getProduct.type eq 'feed'}" >
			사료
			</c:if>
			<c:if test= "${getProduct.type eq 'sand'}" >
			모래
			</c:if>
			<c:if test= "${getProduct.type eq 'etc'}" >
			기타
			</c:if></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">상품 사진</th>
			<td width="30%" align="center" colspan="3"><img src="./resources/upload/product/${getProduct.image1}" width="300" height="300"></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">기타 사진</th>
			<td width="30%" align="center" colspan="3"><img src="./resources/upload/product/${getProduct.image2}" width="300" height="300"></td>
		</tr>
		<tr>
			<th bgcolor="yellow" width="20%">글내용</th>
			<td width="80%" align="center" colspan="3">${getProduct.content}</td>
		</tr>
		<tr>
			<c:choose>
  <c:when test="${like=='like'}">
  <td>
   <button onclick="isLoginUnLike('${getProduct.pnum}','${mbNo}')" >좋아ing : ${getProduct.plike}</button>
  </td>
  </c:when>
  <c:when test="${like=='unlike'}">
  <td>
   <button onclick="isLoginLike('${getProduct.pnum}','${mbNo}')"  >좋아? : ${getProduct.plike}</button>
   </td>
  </c:when>
  			</c:choose>
			<td width="80%" align="right" colspan="3">
			<c:if test="${grade eq '관리자' or unum eq getProduct.unum}">
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










