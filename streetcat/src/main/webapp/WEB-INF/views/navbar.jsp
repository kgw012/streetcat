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
				<a class="navbar-brand" href="home.do">�츮 ���� �����</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="cat_list.do">����� �˻�</a></li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">�Խ��� <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li class="dropdown-header">����� �Խ���</li>
							<li><a href="cat_board.do">�Ϲ� �Խ���</a></li>
							<li><a href="catstreet_qna.do">�����Խ���</a></li>
							<li class="divider"></li>
							<li class="dropdown-header">����� ��ǰ</li>
							<li><a href="product_list.do">��ǰ��õ</a></li>
						</ul>
					</li>
				</ul>
				
				<!-- not login -->
				<form class="navbar-form navbar-right" name="f" action="member_login.do" method="post">
					<c:if test="${empty mbId }">
						<div class="form-group">
							<input type="text" placeholder="���̵�" class="form-control" name="userId">
						</div>
						<div class="form-group">
							<input type="password" placeholder="��й�ȣ" class="form-control" name="passwd">
						</div>
						<button type="submit" class="btn btn-success">�α���</button>
						<button type="button" onclick="location.href='email.do'" class="btn btn-success">ȸ������</button>
						<button type="button" onclick="location.href='loginPage.do'" class="btn btn-success">�α���(�ӽ�)</button>
					</c:if>
				</form>
					
				<!-- login -->
				<c:if test="${!empty mbId }">
					<form class="navbar-form navbar-right" name="f" action="member_logout.do" method="get">
                   		<button type="button" class="btn btn-success" onclick="window.location.href='messageBox.do?mbId=${mbId}'" id="count">������</button>
						<button type="submit" class="btn btn-success">�α׾ƿ�</button>
						<button type="button" class="btn btn-success" onclick="window.open('chatting.do','','width=700, height=350, resizable = no, scrollbars = yes')">ä�ù� ����</button>
					</form>
					<p class="navbar-text navbar-right">
						[${grade}] ${mbId}�� �α��� ��..
						<c:if test="${grade eq '������' }">
							<a href="admin_list.do" class="navbar-link">(ȸ������)</a>
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
		
	<!-- �� ���� ����ؼ� ���� ��� ������ �����ߴ��� ���ؿ���. --> 
    <script>
	    var websocket;
	    var nickname = '<c:out value="${mbId}"/>';
	    
    	<c:if test="${!empty mbId}">
		        websocket = new SockJS("http://localhost:8081/streetcat/chatting.do");
		        $('#guideMessage').text('�����');
		        
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
