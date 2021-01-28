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
		<!-- header -->
		<div class="page-header" style="margin-bottom: 5px;">
			<a href='cat_board.do'>일반 게시판 <span class="glyphicon glyphicon-menu-right"></span></a>
			<h2>${getBoard.subject} <small>[${count}]</small></h2>
			<h4><small>
				작성자 ${getBoard.writer}<br>
				작성일 ${getBoard.reg_date} 조회 ${getBoard.readcount}
			</small></h4>
		</div>
		
		<!-- edit/delete -->
		<div class="pull-right">
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
		</div>

		<!-- cat information -->
		<div class="media">
			<div class="media-left media-middle">
				<img class="media-object" src="./resources/upload/cat/${getBoard.cat_image }" style="height:64px; max-width:64px;">
			</div>
			<div class="media-body">
				<div class="media-heading">
					<h5>
						${getBoard.name}&nbsp;&nbsp;
						<small style="font-size:4px;"><a href="cat_content.do?cnum=${getBoard.cnum }">상세정보  <span class="glyphicon glyphicon-menu-right"></span></a></small>
					</h5>
				</div>
				<h5><small>
					특징 : ${getBoard.feature}<br>
					출현위치 : ${getBoard.location}
				</small></h5>
			</div>
		</div>
		
		<!-- image slide(carousel) -->
		<div id="demo" class="carousel slide" data-ride="carousel" align="center" style="margin:10px 0 10px 0;">
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
		
		<!-- content -->
		<div class="container" style="min-height:100px;">
			<p>${getBoard.content}</p>
		</div>
		
		<!-- like button -->
		<c:choose>
			<c:when test="${like=='unlike'}">
				<button type="button" class="btn btn-default btn-sm" onclick="isLoginUnLike('${getBoard.bnum}','${sessionScope.mbId}')">
					<span class="glyphicon glyphicon-heart" style="color:#f53535;"></span> 추천 ${likeCount}
				</button>
			</c:when>
			<c:when test="${like=='like'}">
				<button type="button" class="btn btn-default btn-sm" onclick="isLoginLike('${getBoard.bnum}','${sessionScope.mbId}')">
					<span class="glyphicon glyphicon-heart-empty" style="color:#f53535;"></span> 추천 ${likeCount}
				</button>
			</c:when>
		</c:choose>
		
		<!-- comment -->
		<div class="panel panel-success" style="margin-top:15px;">
			<div class="panel-heading">
				<span class="glyphicon glyphicon-comment"></span>
				댓글
			</div>
			<table class="table">
				<c:forEach var="dto" items="${boardComment}">
					<tr>
						<c:if test="${dto.re_level>0}">
							<td style="width:5%; min-width:40px;">
							</td>
							<td>
						</c:if>
						<c:if test="${dto.re_level==0}">
							<td colspan="2" style="padding:12px 12px 12px 20px;">
						</c:if>
								<p style="margin-bottom:0px;">
									<strong>${dto.writer}&nbsp;</strong>
									<c:if test="${dto.writer==getBoard.writer}">
										<span class="label label-info">작성자</span>
									</c:if>
									<br>
								</p>
								<p style="margin-bottom:5px;">${dto.content}<br></p>
								<p style="margin-bottom:0px; color:gray;"><small>
										${dto.reg_date}&nbsp;&nbsp;
										<a href="#"
											onclick="window.open('reComment.do?comment_num=${dto.comment_num}','',
													'width=500, height=250, resizable = no, scrollbars = no')">
											답글달기
										</a>
								</small></p>
							</td>
					</tr>
				</c:forEach>
			</table>
			
			<!-- comment pagination -->
			<div align="center">
				<c:if test="${count>0}">
					<nav>
						<ul class="pagination pagination-sm">
							<c:choose>
								<c:when test="${startPage > pageBlock}">
									<li><a href="cat_board_content.do?pageNum=${startPage-pageBlock}&bnum=${getBoard.bnum}&type=now">
										<span>&laquo;</span>
									</a></li>
								</c:when>
								<c:otherwise>
									<li class="disabled"><a href="#"><span>&laquo;</span></a></li>
								</c:otherwise>
							</c:choose>
							
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
								<li><a href="cat_board_content.do?pageNum=${i}&bnum=${getBoard.bnum}&type=now">${i}</a></li>
							</c:forEach>
							
							<c:choose>
								<c:when test="${endPage < pageCount}">
									<li><a href="cat_board_content.do?pageNum=${startPage+pageBlock}&bnum=${getBoard.bnum}&type=now">
										<span>&raquo;</span>
									</a></li>
								</c:when>
								<c:otherwise>
									<li class="disabled"><a href="#"><span>&raquo;</span></a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</nav>
				</c:if>
			</div>
			
			<!-- write comment -->
			<div class="container" style="width:100%;">
				<div class="row" style="margin-bottom:20px;">
					<form name="f" action="cat_board_comment_write.do" method="post">
						<input type="hidden" name="bnum" value="${getBoard.bnum}">
						<input type="hidden" name="type" value="normal">
						<input type="hidden" name="writer" value="${sessionScope.mbId}">
						<c:choose>
							<c:when test="${empty mbId }">
								<div class="col-xs-8 col-xs-offset-2">
									<textarea class="form-control" placeholder='로그인 후 이용가능합니다.' name="content" rows="3" readonly required></textarea>
								</div>
								<div class="col-xs-2">
									<input type="submit" class="btn btn-success" disabled="disabled" value="등록">
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-xs-8 col-xs-offset-2">
									<textarea class="form-control" placeholder='댓글을 입력하세요' name="content" rows="3" required></textarea>
								</div>
								<div class="col-xs-2">
									<input type="submit" class="btn btn-success" value="등록">
								</div>
							</c:otherwise>
						</c:choose>
					</form>
				</div>
			</div>
		</div>  <!-- comment caption end-->
		
		<!-- prev/next page -->
		<div class="pull-right">
			<div class="btn-group" role="group" aria-label="...">
				<button type="button" class="btn btn-default" onclick="goTop()"><span class="glyphicon glyphicon-triangle-top"></span> TOP</button>
				<button type="button" class="btn btn-default" onclick="location.href='cat_board_content.do?bnum=${getBoard.bnum}&type=before'">
					<span class="glyphicon glyphicon-triangle-left"></span>이전
				</button>
				<button type="button" class="btn btn-default" onclick="location.href='cat_board_content.do?bnum=${getBoard.bnum}&type=next'">
					<span class="glyphicon glyphicon-triangle-right"></span>다음
				</button>
			</div>
		</div>
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
				alert("로그인 후 이용해주세요");
			<%}else{%>
				alert("추천 완료!");
				location.href = "cat_board_like.do?bnum="+bnum+"&userId="+userId;
			<%}%>
		}
		
		function isLoginUnLike(bnum,userId){
			<% if(session.getAttribute("mbId")==null){%>
				alert("로그인 후 이용해주세요");
			<%}else{%>
				alert("추천 취소!");
				location.href = "cat_board_unLike.do?bnum="+bnum+"&userId="+userId;
			<%}%>
		}
		
		function goTop(){
			$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
			return false;
		}
	</script>
	
<%@ include file="../bottom.jsp" %>