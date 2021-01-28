<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<!-- navbar.jsp-->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="home.do">우리 동네 고양이</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="cat_list.do">길냥이 검색</a></li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">게시판 <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li class="dropdown-header">길냥이 게시판</li>
							<li><a href="cat_board.do">일반 게시판</a></li>
							<li><a href="catstreet_qna.do">질문게시판</a></li>
							<li class="divider"></li>
							<li class="dropdown-header">길냥이 상품</li>
							<li><a href="product_list.do">상품추천</a></li>
						</ul>
					</li>
				</ul>
				
				<!-- not login -->
				<form class="navbar-form navbar-right" name="f" action="member_login.do" method="post">
					<c:if test="${empty mbId }">
						<div class="form-group">
							<input type="text" placeholder="아이디" class="form-control" name="userId">
						</div>
						<div class="form-group">
							<input type="password" placeholder="비밀번호" class="form-control" name="passwd">
						</div>
						<button type="submit" class="btn btn-success">로그인</button>
						<button type="button" onclick="location.href='email.do'" class="btn btn-success">회원가입</button>
						<button type="button" onclick="location.href='loginPage.do'" class="btn btn-success">로그인(임시)</button>
					</c:if>
				</form>
					
				<!-- login -->
				<c:if test="${!empty mbId }">
					<form class="navbar-form navbar-right" name="f" action="member_logout.do" method="get">
                   		<button type="button" class="btn btn-success" onclick="window.location.href='messageBox.do?mbId=${mbId}'" id="count">쪽지함</button>
						<button type="submit" class="btn btn-success">로그아웃</button>
						<button type="button" class="btn btn-success" onclick="window.open('chatting.do','','width=700, height=350, resizable = no, scrollbars = yes')">채팅방 입장</button>
					</form>
					<p class="navbar-text navbar-right">
						[${grade}] ${mbId}님 로그인 중..
						<c:if test="${grade eq '관리자' }">
							<a href="admin_list.do" class="navbar-link">(회원관리)</a>
						</c:if>
		       		</p>
	        	</c:if>
			</div>
		</div>
	</nav>
	
	
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
		<!-- sockjs.js -->
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
		
	<!-- 웹 소켓 사용해서 현재 몇개의 쪽지가 도착했는지 구해오기. --> 
    <script>
	    var websocket;
	    var nickname = '<c:out value="${mbId}"/>';
	    
    	<c:if test="${!empty mbId}">
		        websocket = new SockJS("http://localhost:8081/streetcat/chatting.do");
		        $('#guideMessage').text('연결됨');
		        
		        websocket.onopen = function(){
		        	websocket.send(nickname);
		        }
		        
		        websocket.onmessage = function(evt){
		        	if(evt.data.indexOf("readMessage")!=-1){
		        	evt.data = evt.data.replace('readMessage','')
		        	  $('#count').append('&nbsp;<span class="badge">'+evt.data+'</span>');
		        	}
		       }
		</c:if>
	</script>
