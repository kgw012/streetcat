<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" import="java.util.*,com.ezen709.streetcat.model.*"%>
    
<!-- cat_board_content.jsp -->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>
    
    <!-- page access validation check -->
    <script>
	    <% if(request.getAttribute("getBoard")==null){%>
			alert("처음/마지막글 입니다");
			window.history.back();
		<%}%>
		
		<c:if test="${getBoard.type == 'member'&&sessionScope.mbId==null}">
			alert("회원공개 게시물입니다");
			window.history.back();
		</c:if>
		<c:if test="${getBoard.type == 'private'&&sessionScope.mbId!=getBoard.writer}">
			<c:if test="${sessionScope.grade!='관리자'}">
				alert("비공개 게시물입니다");
				window.history.back();
			</c:if>
		</c:if>
    </script>
    
    <!-- set carousel img css -->
	<style>
		.carousel-inner > .item > img{ height: 300px; max-width: 300px;}
	</style>
	
	
	<div class="container">
		<div class="page-header" style="margin-bottom: 5px;">
			<a href='cat_board.do'>일반 게시판 <span class="glyphicon glyphicon-menu-right"></span></a>
			<h2>${getBoard.subject} <small>[${count}]</small></h2>
			<h4><small>
				작성자 ${getBoard.writer}<br>
				작성일 ${getBoard.reg_date} 조회 ${getBoard.readcount}
			</small></h4>
		</div>
		<!-- 작성자와 로그인id가 같거나, 관리자로 로그인할 시 수정|삭제 띄움 --> 
		<c:if test="${getBoard.writer==sessionScope.mbId || sessionScope.grade=='관리자'}">
			<h4 align="right" style="margin-top: 0px;"><small>
				<a href="cat_board_edit.do?bnum=${getBoard.bnum}">
					수정하기
				</a> | 
				<a href="cat_board_delete.do?bnum=${getBoard.bnum}"  onclick="return confirm('정말 삭제하시겠습니까?')">
					삭제하기
				</a>
			</small></h4>
		</c:if>
		
		
		<table width="100%">
			<tr>
				<td align="center" width="25%">
					위치 : ${getBoard.location}<br>
					<br>
					이름 : ${getBoard.name}<br>
					<br>
					특징 : ${getBoard.feature}<br>
				</td>
				<td align="center" width="25%">
					<div id="demo" class="carousel slide" data-ride="carousel">
						<div class="carousel-inner" role="listbox">
							<!-- 슬라이드 쇼 -->
							<div class="item active">
								<c:choose>
									<c:when test='${empty getBoard.image1}'>
										<img class="d-block w-100" src="./resources/upload/catBoard/${getBoard.image2}" alt="1st slide" >
									</c:when>
									<c:otherwise>
										<img class="d-block w-100" src="./resources/upload/catBoard/${getBoard.image1}" alt="1st slide" >
									</c:otherwise>
								</c:choose>
					  
								<div class="carousel-caption d-none d-md-block">
								
								</div>
							</div>
							<c:if test="${getBoard.image2!=null}">
								<div class="item">
									<img class="d-block w-100" src="./resources/upload/catBoard/${getBoard.image2}" alt="2nd slide">
								</div>
							</c:if>
							<c:if test="${getBoard.image3!=null}">
								<div class="item">
									<img class="d-block w-100" src="./resources/upload/catBoard/${getBoard.image3}" alt="3nd slide"> 
								</div>
							</c:if> 
							<c:if test="${getBoard.image4!=null}">
								<div class="item">
									<img class="d-block w-100" src="./resources/upload/catBoard/${getBoard.image4}" alt="4nd slide">
								</div>
							</c:if>
							<c:if test="${getBoard.image5!=null}">
								<div class="item">
									<img class="d-block w-100" src="./resources/upload/catBoard/${getBoard.image5}" alt="5nd slide">
								</div>
							</c:if>
							<!-- / 슬라이드 쇼 끝 -->
							
							<!-- 왼쪽 오른쪽 화살표 버튼 -->
							<a class="left carousel-control" href="#demo" role="button" data-slide="prev">
								<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="right carousel-control" href="#demo" role="button" data-slide="next">
							    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
							    <span class="sr-only">Next</span>
							</a>
							<!-- / 화살표 버튼 끝 -->
							
							<!-- 인디케이터 
							<ul class="carousel-indicators">
								<li data-target="#demo" data-slide-to="0" class="active"></li>
								-0번부터시작
								<li data-target="#demo" data-slide-to="1"></li>
								<li data-target="#demo" data-slide-to="2"></li>
							</ul> 인디케이터 끝 -->
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td algin="center">
					${getBoard.content}
				</td>
			</tr>
		</table>
		<br>
		<table align="center">
			<tr>
				<c:choose>
					<c:when test="${like=='unlike'}">
						<td>
				 			<button onclick="isLoginUnLike('${getBoard.bnum}','${sessionScope.mbId}')">추천취소 : ${likeCount}</button>
						</td>
					</c:when>
					<c:when test="${like=='like'}">
						<td>
							<button onclick="isLoginLike('${getBoard.bnum}','${sessionScope.mbId}')">추천 : ${likeCount}</button>
						</td>
					</c:when>
				</c:choose>
				<td>
					<button onclick="window.location.href='cat_board.do'">목록가기</button>
				</td>
				<td>
					<a href="cat_board_content.do?bnum=${getBoard.bnum}&type=before">이전글</a>|
					<a href="cat_board_content.do?bnum=${getBoard.bnum}&type=next">다음글</a>
				</td>
			</tr>
		</table>
		 
		<form name="f" action="cat_board_comment_write.do" method="post">
			<table width="100%">
				<c:forEach var="dto" items="${boardComment}">
					<tr>
						<td colspan="2">
							<c:if test="${dto.re_level>0}">
								<img src="./resources/image/reComment.jpg" width="20" height="20">
								<c:if test="${dto.writer==getBoard.writer}">
									<img src="./resources/image/writer.jpg" width="40" height="20">
								</c:if>
								${dto.writer}님 : ${dto.content} '${dto.reg_date}'
							</c:if>	
							<c:if test="${dto.re_level==0}">
								<c:if test="${dto.writer==getBoard.writer}">
									<img src="./resources/image/writer.jpg" width="40" height="17">
								</c:if>
								${dto.writer}님 : ${dto.content} '${dto.reg_date}'
								<a href="#" onclick="window.open('reComment.do?comment_num=${dto.comment_num}','',
																	'width=500, height=250, resizable = no, scrollbars = no')">
									[답글달기]
								</a>
							</c:if>
							<br>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<th>
						<c:if test="${count>0}">
							<c:if test="${startPage > pageBlock}">
								[<a href="cat_board_content.do?pageNum=${startPage-pageBlock}&bnum=${getBoard.bnum}&type=now">이전</a>]
							</c:if>
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
								[<a href="cat_board_content.do?pageNum=${i}&bnum=${getBoard.bnum}&type=now">${i}</a>]
							</c:forEach>
							<c:if test="${endPage<PageCount}">
								[<a href="cat_board_content.do?pageNum=${startPage+pageBlock}&bnum=${getBoard.bnum}&type=now">다음</a>]
							</c:if>
						</c:if>
					</th>
				</tr>
				<tr>
					<td align="center">
						<!-- isLogin() 비로그인시 로그인창으로 이동  onfocus="isLogin()" -->
						<textarea onclick="isLogin()" placeholder='댓글을 입력하세요' name="content" rows="3" cols="100%" required></textarea>
					</td>
					<td>
						<input type="hidden" name="bnum" value="${getBoard.bnum}">
						<input type="hidden" name="type" value="normal">
						<input type="hidden" name="writer" value="${sessionScope.mbId}">
						<input type="submit" value="등록">
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	
	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
		<!-- popper.js -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
			integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
			crossorigin="anonymous"></script>

	
	<!-- functions -->
	<script>
		$('.carousel').carousel({
		      interval: 2000 //기본 5초 
		});
		
		function isLoginLike(bnum,userId){
			<% if(session.getAttribute("mbId")==null){%>
				alert("로그인 후 이용해주세요")
			<%}else{%>
				alert("추천 완료!")
				location.href = "cat_board_like.do?bnum="+bnum+"&userId="+userId;
			<%}%>
		}
		
		function isLoginUnLike(bnum,userId){
			<% if(session.getAttribute("mbId")==null){%>
				alert("로그인 후 이용해주세요")
			<%}else{%>
				alert("추천 취소!")
				location.href = "cat_board_unLike.do?bnum="+bnum+"&userId="+userId;
			<%}%>
		}
		
		function isLogin(){
			<% if(session.getAttribute("mbId")==null){%>
				alert("로그인 후 이용해주세요")
				location.href = "cat_board.do";
			<%}%>
		}
	</script>
	
<%@ include file="../bottom.jsp" %>