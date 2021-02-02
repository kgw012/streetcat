<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- myPage.jsp-->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>

	<div class="container">
		<h1 class="page-header">My Page</h1>
		<p>${mbId }님의 정보입니다</p>
		<p>unum : ${unum }</p>
		<p>가입일자 : ${joindate }</p>
		<p>회원등급 : ${grade }</p>
		<br>
		
		<!-- 작성글 조회 탭 -->
		<ul class="nav nav-tabs" role="tablist" id="myTab">
			<li role="presentation" class="active"><a href="#board" aria-controls="board" role="tab" data-toggle="tab">작성글</a></li>
			<li role="presentation"><a href="#comment" aria-controls="comment" role="tab" data-toggle="tab">작성댓글</a></li>
			<li role="presentation"><a href="#board_comment" aria-controls="board_comment" role="tab" data-toggle="tab">댓글단 글</a></li>
		</ul>
		
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="board">
				<p>내가 쓴 글 : ${countBoard }개</p>
				<table class="table">
					<tr>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<c:choose>
						<c:when test="${empty memberBoardList }">
							<tr>
								<td colspan="3">
									<p>작성하신 게시글이 없습니다</p>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="dto" items="${memberBoardList }">
								<tr>
									<td><a href="cat_board_content.do?bnum=${dto.bnum}&type='now'">${dto.subject }</a></td>
									<td>${dto.reg_date }</td>
									<td>${dto.readcount }</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<div role="tabpanel" class="tab-pane" id="comment">
				<p>내가 쓴 댓글 : ${countComment }개</p>
				<table class="table">
					<tr>
						<th>댓글</th>
						<th>작성일</th>
					</tr>
					<c:choose>
						<c:when test="${empty memberCommentList }">
							<tr>
								<td colspan="2">
									<p>작성하신 게시글이 없습니다</p>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="dto" items="${memberCommentList }">
								<tr>
									<td><a href="cat_board_content.do?bnum=${dto.bnum}&type='now'">${dto.content }</a></td>
									<td>${dto.reg_date }</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<div role="tabpanel" class="tab-pane" id="board_comment">
			</div>
		</div>
						
	</div>

	
	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<%@ include file="../bottom.jsp" %>