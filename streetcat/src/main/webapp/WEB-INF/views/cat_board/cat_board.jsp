<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- cat_board.jsp -->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>

	<div class="container">
		<form>
			<div class="pull-right">
				<h3><small>
					<a href="javascript:isLogin(${sessionScope.name})">글쓰기</a>
				</small></h3>
			</div>
			<div class="page-header">
				<h2>일반 게시판</h2>
			</div>
		</form>
		
	 	<c:if test="${empty cat_listBoard}">
	 		<h3>등록된 게시글이 없습니다.</h3>
	 	</c:if>
	 	
		<div class="row">
			<c:forEach var="dto" items="${cat_listBoard}">
				<div class="col-xs-6 col-sm-4 col-md-3">
					<div class="thumbnail">
						<a href="cat_board_content.do?bnum=${dto.bnum}&type='now'">
							<c:choose>
							    <c:when test="${dto.type eq 'private'}">
							    	<img src="./resources/image/private.jpg" class="img-responsive" style="height:180px;">
							    </c:when>
							    <c:when test="${dto.type eq 'member'}">
							    	<img src="./resources/image/cat.jpg" class="img-responsive" style="height:180px;">
							    </c:when>
							    <c:when test="${empty dto.image1}">
							    	<img src="./resources/upload/catBoard/${dto.image2}" class="img-responsive" style="height:180px;">
							    </c:when>
							    <c:otherwise>
									<img src="./resources/upload/catBoard/${dto.image1}" class="img-responsive" style="height:180px;">
								</c:otherwise>
						    </c:choose>
						</a>
						<div class="caption">
							<h3><a href="cat_board_content.do?bnum=${dto.bnum}&type='now'">
								${dto.subject}<small>&nbsp;[${dto.commentcount}]</small>
								</a>
							</h3>
							<p style="width:100%; text-overflow: ellipsis; overflow:hidden; white-space:nowrap;">
								<a href="cat_board_content.do?bnum=${dto.bnum}&type='now'">
									${dto.content }
								</a>
							</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div align="center">
			<c:if test="${count>0}">
				<nav>
					<ul class="pagination">
						<c:choose>
							<c:when test="${startPage > pageBlock}">
								<li><a href="cat_board.do?pageNum=${startPage-pageBlock}">
									<span>&laquo;</span>
								</a></li>
							</c:when>
							<c:otherwise>
								<li class="disabled"><a href="#"><span>&laquo;</span></a></li>
							</c:otherwise>
						</c:choose>
						
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<li><a href="cat_board.do?pageNum=${i}">${i}</a></li>
						</c:forEach>
						
						<c:choose>
							<c:when test="${endPage < pageCount}">
								<li><a href="cat_board.do?pageNum=${startPage+pageBlock}">
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
		
		<div class="row">
			<div class="col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1">
				<form name="f" action="find_cat_board.do">
					<div class="input-group">
						<div id="myDropdown" class="input-group-btn">
							<button type="button" class="btn btn-default dropdown-toggle"
								data-toggle="dropdown" aria-expanded="false">
									제목
							<span class="caret"></span></button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="javascript:void(0)">제목</a></li>
								<li><a href="javascript:void(0)">내용</a></li>
								<li><a href="javascript:void(0)">작성자</a></li>
							</ul>
							<input type="hidden" name="type" value="subject">
						</div>
						<input type="text" name="searchString" class="form-control">
						<span class="input-group-btn">
							<input type="submit" class="btn btn-primary" value="검색">
						</span>
					</div>
				</form>
			</div>
		</div>	
	</div>
	
	
	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

	<!-- functions -->
	<script>
		//login check
		function isLogin(name){
			 <% if(session.getAttribute("mbId")==null){%>
			 alert("로그인 후 이용해주세요")
			 return
			 <%}%>
			 location.href = "cat_board_write.do?name="+name;
		}
		
		//dropdown-menu function
		$("#myDropdown .dropdown-menu li > a").on("click", function(){
			var html = $(this).html();
			$('#myDropdown button.dropdown-toggle').html(html + ' <span class="caret"></span>');
			if(html == "제목"){
				$('input[name=type]').val("subject");
			}else if(html == "내용"){
				$('input[name=type]').val("content");
			}else if(html == "작성자"){
				$('input[name=type]').val("writer");
			}
		});
	</script>

<%@ include file="../bottom.jsp" %>