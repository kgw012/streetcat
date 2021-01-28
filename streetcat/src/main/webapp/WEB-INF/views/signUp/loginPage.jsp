<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE script PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript">
	var naver_id_login = new naver_id_login("TXRsLBcB5PaPMOai1R6O",
			"http://localhost:8081/myhome/loginPage"); // Client ID, CallBack URL 삽입
	// 단 'localhost'가 포함된 CallBack URL
	var state = naver_id_login.getUniqState();

	naver_id_login.setButton("white", 2, 40);
	naver_id_login.setDomain("http://127.0.0.1:8081/myhome/loginPage"); //  URL
	naver_id_login.setState(state);
	naver_id_login.setPopup();
	naver_id_login.init_naver_id_login();
		</script>

		<title>login page</title>
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
		<div id="naver_id_login"></div>
	</form>

	<!-- '네이버 아이디로 로그인하기' 버튼 -->
	<!-- 원하는 곳에 넣습니다. -->

			</body>
</html>
