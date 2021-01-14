<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <h2><a href="home.do">CATSTREET</a></h2>
<h3 align="center"> 게 시 글 목 록</h3><br>
<h4 align="right"><a href="cat_board_write.do?name=${sessioScope.name}">글 쓰 기</a></h4>

<%int count=0; %>
 	<c:if test="${empty cat_listBoard}">
	<h3>등록된 게시글이 없습니다</h3>
	</c:if>
	<table width="100%" align="center">
	<tr>
	<c:forEach var="dto" items="${cat_listBoard}">
	<%count++;%>
				<td align="center">
				
				<a href="cat_board_content.do?bnum=${dto.bnum}&type='now'">
				<c:choose>
				    <c:when test="${dto.type eq 'private'}">
				    <img src="./resources/image/private.jpg" width="150" height="150">
				    </c:when>
				    <c:when test="${empty dto.image1}">
				    <img src="./resources/image/cat.jpg" width="150" height="150">
				    </c:when>
				    <c:otherwise>
					<img src="${upPath}/${dto.image1}" width="150" height="150">
					</c:otherwise>
			    </c:choose>
				</a><br>
				${dto.bnum}|${dto.subject}[${dto.commentcount}]<br>
				</td>
				<%if(count%4==0){%>
				</tr><tr>
                <%}%>
     </c:forEach>
     </tr>
     </table>
     	<br>
     	<div align="center">
<c:if test="${count>0}">
            <c:if test="${startPage > pageBlock}">
			[<a href="cat_board.do?pageNum=${startPage-pageBlock}">이전</a>]
</c:if>
<c:forEach var="i" begin="${startPage}" end="${endPage}">
			[<a href="cat_board.do?pageNum=${i}">${i}</a>]
</c:forEach>

<c:if test="${endPage<PageCount}">
			[<a href="cat_board.do?pageNum=${startPage+pageBlock}">다음</a>]
</c:if>
</c:if>
</div>
<div align="center">
<form name="f" action="find_cat_board.do">

<select name="type">
<option value="subject">제목</option>
<option value="content">내용</option>
<option value="writer">작성자</option>
</select>
<input type="text" name="searchString">
<input type="submit" value="검색">
</form>
</div>

