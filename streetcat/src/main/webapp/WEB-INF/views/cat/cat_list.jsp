<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- cat_list.jsp-->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>
	
	<div class="container">
		<h1 class="page-header">길냥이 검색</h1>
		<form name="f" action="cat_list.do" method="post">
			<div class="row">
				<div class="col-lg-8">
					<div class="input-group">
						<div id="myDropdown" class="input-group-btn">
							<button type="button" class="btn btn-default dropdown-toggle"
								data-toggle="dropdown" aria-expanded="false">
									이름
							<span class="caret"></span></button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="javascript:void(0)">이름</a></li>
								<li><a href="javascript:void(0)">특징</a></li>
							</ul>
							<input type="hidden" name="searchString" value="name">
						</div>
						<input type="text" name="search" class="form-control">
						<span class="input-group-btn">
							<input type="button" class="btn btn-default" value="위치로 찾기" onclick="open_searchCat();">
							<input type="submit" class="btn btn-primary" value="검색">
						</span>
					</div>
				</div>
			</div>
		</form>
		<form name="reg" action="cat_insert.do" method="post">
			<input type="hidden" name="unum" value="${sessionScope.unum}">
			<div class="pull-right">
				<h3><small>
					 <a href="javascript:isLogin(${sessionScope.unum})">길냥이 등록하기</a>
				</small></h3>
			</div>
			<div class="page-header">
				<h2>길냥이 목록</h2>
			</div>
		</form>
		
		<div class="table-responsive">
			<table class="table table-bordered">
				<tr>
					<th>이름</th>
					<th>특징</th>
					<th>대표사진</th>
					<th>출현위치</th>
				</tr>
				<c:if test="${empty catList}">	
					<tr>
						<td colspan="4">등록된 길냥이가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="dto" items="${catList}">
					<tr>
						<td><a href="cat_content.do?cnum=${dto.cnum}">${dto.name }</a></td>
						<td>${dto.feature }</td>
						<td><a href="cat_content.do?cnum=${dto.cnum}"><img src="./resources/upload/cat/${dto.image}" height="150"></a></td>
						<td>${dto.location }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	
	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	
	<!-- functions -->
	<script type="text/javascript">
		//open searchCat.jsp
		function open_searchCat(){
			var width = 700;
			var height = 600;
			var left = window.screen.width / 2 - width / 2;
			var top = window.screen.height / 2 - height / 2;
			window.open("searchCat.do", "고양이 위치로찾기", "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
		}
		
		//check login
		function isLogin(unum){
			if(unum == null){
				alert("로그인 후 이용해주세요");
				return;
			}
			document.reg.submit();
		}
		
		//dropdown-menu function
		$("#myDropdown .dropdown-menu li > a").on("click", function(){
			var html = $(this).html();
			$('#myDropdown button.dropdown-toggle').html(html + ' <span class="caret"></span>');
			if(html == "이름"){
				$('input[name=searchString]').val("name");
			}else if(html == "특징"){
				$('input[name=searchString]').val("feature");
			}
		});
	</script>

<%@ include file="../bottom.jsp" %>