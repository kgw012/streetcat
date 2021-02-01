<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript"
    src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style type="text/css">
html, div, body, h3 {
    margin: 0;
    padding: 0;
}
 
h3 {
    display: inline-block;
    padding: 0.6em;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
    var name = ${result}.response.name;
    var email = ${result}.response.email;
    $("#name").html("환영합니다. "+name+"님");
    $("#email").html(email);
    
  });
</script>

</head>
<body>
    <div style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
        <h3>네아로 성공 -> 비밀번호 입력으로 회원가입 절차</h3>
    </div>
    <br>
    <h2 style="text-align: center" id="name"></h2>
    <h4 style="text-align: center" id="email"></h4>
 <div align="center">
 <form id="signFrm" name="signFrm" action="signUp.do" >
			
					<input type="hidden" id="userId" name="userId" value="${email}" readOnly>
			<tr>
					<td>패스워드</td>
					<td colspan="2"><input id="passwd" name="passwd" type="password"></td>
					<br>
					<td id="pw_check"></td>
				</tr>
				<br>
				<tr>
					<td>패스워드 확인</td>
					<td colspan="2"><input id="passwdCheck" name="passwdCheck" type="password"></td>
				</tr>
	
				
					<td>	<input type="hidden" id="name2" name="name" value="${name}" readOnly></td>
					<td>	<input type="hidden" id="email2" name="email" value="${email}" readOnly ></td>
					<br>
					<input type="button" id="signUp" value="회원가입">
			</form>
			</div>
</body>
<script type="text/javascript">

var pwJ = /^[A-Za-z0-9]{4,12}$/;  // 비밀번호 정규식

$(document).ready(function(e){
	var passwd = $('#passwd').val();
	$('#signUp').click(function(){
		if(pwJ.test(passwd)){
			
			$("#pw_check").text("");
			$("#signFrm").attr("disabled", false);

		} else if(passwd == ""){
			
			$('#pw_check').text('패스워드를 입력해주세요 :)');
			$('#pw_check').css('color', 'red');
			$("#signFrm").attr("disabled", true);				
			return;
		} else if($('#passwd').val() != $('#passwdCheck').val()){
			$("#pw_check").text("패스워드가 다릅니다.");
			$('#passwd').focus();
			return;
		
		}else if(pwJ.text(passwd)== false) {
			$('#pw_check').text("패스워드는 영 대,소문자와 숫자를 이용하여 4~12자리만 가능합니다.");
			$('#pw_check').css('color', 'red');
			$("#signFrm").attr("disabled", true);
			return;
		}else{
			$('#signFrm').submit();
		}
		
	});
	
});

	</script>
</html>
