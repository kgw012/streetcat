<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" import="java.util.*,com.ezen709.streetcat.model.*"%>
    
<!-- cat_board_content.jsp -->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>
    
    <!-- page access validation check -->
    <script>
	    <% if(request.getAttribute("getBoard")==null){%>
			alert("ó��/�������� �Դϴ�");
			window.history.back();
		<%}%>
		
		<c:if test="${getBoard.type == 'member'&&sessionScope.mbId==null}">
			alert("ȸ������ �Խù��Դϴ�");
			window.history.back();
		</c:if>
		<c:if test="${getBoard.type == 'private'&&sessionScope.mbId!=getBoard.writer}">
			<c:if test="${sessionScope.grade!='������'}">
				alert("����� �Խù��Դϴ�");
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
			<a href='cat_board.do'>�Ϲ� �Խ��� <span class="glyphicon glyphicon-menu-right"></span></a>
			<h2>${getBoard.subject} <small>[${count}]</small></h2>
			<h4><small>
				�ۼ��� ${getBoard.writer}<br>
				�ۼ��� ${getBoard.reg_date} ��ȸ ${getBoard.readcount}
			</small></h4>
		</div>
		<!-- �ۼ��ڿ� �α���id�� ���ų�, �����ڷ� �α����� �� ����|���� ��� --> 
		<c:if test="${getBoard.writer==sessionScope.mbId || sessionScope.grade=='������'}">
			<h4 align="right" style="margin-top: 0px;"><small>
				<a href="cat_board_edit.do?bnum=${getBoard.bnum}">
					�����ϱ�
				</a> | 
				<a href="cat_board_delete.do?bnum=${getBoard.bnum}"  onclick="return confirm('���� �����Ͻðڽ��ϱ�?')">
					�����ϱ�
				</a>
			</small></h4>
		</c:if>
		
		
		<table width="100%">
			<tr>
				<td align="center" width="25%">
					��ġ : ${getBoard.location}<br>
					<br>
					�̸� : ${getBoard.name}<br>
					<br>
					Ư¡ : ${getBoard.feature}<br>
				</td>
				<td align="center" width="25%">
					<div id="demo" class="carousel slide" data-ride="carousel">
						<div class="carousel-inner" role="listbox">
							<!-- �����̵� �� -->
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
							<!-- / �����̵� �� �� -->
							
							<!-- ���� ������ ȭ��ǥ ��ư -->
							<a class="left carousel-control" href="#demo" role="button" data-slide="prev">
								<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="right carousel-control" href="#demo" role="button" data-slide="next">
							    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
							    <span class="sr-only">Next</span>
							</a>
							<!-- / ȭ��ǥ ��ư �� -->
							
							<!-- �ε������� 
							<ul class="carousel-indicators">
								<li data-target="#demo" data-slide-to="0" class="active"></li>
								-0�����ͽ���
								<li data-target="#demo" data-slide-to="1"></li>
								<li data-target="#demo" data-slide-to="2"></li>
							</ul> �ε������� �� -->
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
				 			<button onclick="isLoginUnLike('${getBoard.bnum}','${sessionScope.mbId}')">��õ��� : ${likeCount}</button>
						</td>
					</c:when>
					<c:when test="${like=='like'}">
						<td>
							<button onclick="isLoginLike('${getBoard.bnum}','${sessionScope.mbId}')">��õ : ${likeCount}</button>
						</td>
					</c:when>
				</c:choose>
				<td>
					<button onclick="window.location.href='cat_board.do'">��ϰ���</button>
				</td>
				<td>
					<a href="cat_board_content.do?bnum=${getBoard.bnum}&type=before">������</a>|
					<a href="cat_board_content.do?bnum=${getBoard.bnum}&type=next">������</a>
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
								${dto.writer}�� : ${dto.content} '${dto.reg_date}'
							</c:if>	
							<c:if test="${dto.re_level==0}">
								<c:if test="${dto.writer==getBoard.writer}">
									<img src="./resources/image/writer.jpg" width="40" height="17">
								</c:if>
								${dto.writer}�� : ${dto.content} '${dto.reg_date}'
								<a href="#" onclick="window.open('reComment.do?comment_num=${dto.comment_num}','',
																	'width=500, height=250, resizable = no, scrollbars = no')">
									[��۴ޱ�]
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
								[<a href="cat_board_content.do?pageNum=${startPage-pageBlock}&bnum=${getBoard.bnum}&type=now">����</a>]
							</c:if>
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
								[<a href="cat_board_content.do?pageNum=${i}&bnum=${getBoard.bnum}&type=now">${i}</a>]
							</c:forEach>
							<c:if test="${endPage<PageCount}">
								[<a href="cat_board_content.do?pageNum=${startPage+pageBlock}&bnum=${getBoard.bnum}&type=now">����</a>]
							</c:if>
						</c:if>
					</th>
				</tr>
				<tr>
					<td align="center">
						<!-- isLogin() ��α��ν� �α���â���� �̵�  onfocus="isLogin()" -->
						<textarea onclick="isLogin()" placeholder='����� �Է��ϼ���' name="content" rows="3" cols="100%" required></textarea>
					</td>
					<td>
						<input type="hidden" name="bnum" value="${getBoard.bnum}">
						<input type="hidden" name="type" value="normal">
						<input type="hidden" name="writer" value="${sessionScope.mbId}">
						<input type="submit" value="���">
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
		      interval: 2000 //�⺻ 5�� 
		});
		
		function isLoginLike(bnum,userId){
			<% if(session.getAttribute("mbId")==null){%>
				alert("�α��� �� �̿����ּ���")
			<%}else{%>
				alert("��õ �Ϸ�!")
				location.href = "cat_board_like.do?bnum="+bnum+"&userId="+userId;
			<%}%>
		}
		
		function isLoginUnLike(bnum,userId){
			<% if(session.getAttribute("mbId")==null){%>
				alert("�α��� �� �̿����ּ���")
			<%}else{%>
				alert("��õ ���!")
				location.href = "cat_board_unLike.do?bnum="+bnum+"&userId="+userId;
			<%}%>
		}
		
		function isLogin(){
			<% if(session.getAttribute("mbId")==null){%>
				alert("�α��� �� �̿����ּ���")
				location.href = "cat_board.do";
			<%}%>
		}
	</script>
	
<%@ include file="../bottom.jsp" %>