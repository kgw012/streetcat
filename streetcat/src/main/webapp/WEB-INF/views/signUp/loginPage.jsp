<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE script PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>login page</title>
		<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
  <style type="text/css">
  html, div, body,h3{
      margin: 0;
      padding: 0;
  }
  h3{
      display: inline-block;
      padding: 0.6em;
  }
  </style>
  
	</head>
			<body>




	<form class="navbar-form navbar-right" name="f"
		action="member_login.do" method="post">

		<div class="form-group">
			<input type="text" placeholder="아이디" class="form-control"
				name="userId">
		</div>
		<br>
		<div class="form-group">
			<input type="password" placeholder="비밀번호" class="form-control"
				name="passwd">
		</div>
		<br>
		<button type="submit" class="btn btn-success">로그인</button>
		<br>
		
<!-- 네이버 로그인 화면으로 이동 시키는 URL -->
<!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
<div id="naver_id_login" style="text-align:center"><a href="${url}"><img width="223" src="${pageContext.request.contextPath}/resources/image/naver_Bn_Green.png"/></a></div>
<br>
	</form>



			</body>
</html>
