<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Insert title here</title>
	
	
</head>
<body>
	<h1>회원가입</h1>
	<hr>
	<form id="signFrm" name="signFrm" action="signUp.do">
		<table>
			<tbody>
				<tr>
					<td>아이디</td>
					<td><input type="text" id="userId" name="userId" ></td>
					<td><input type="button" id="check" value="중복체크"></td><td id="id_check"></td>
				</tr>
				<tr>
					<td colspan=3 id="idCheck"></td>
					
				</tr>
				<tr>
					<td>패스워드</td>
					<td colspan="2"><input id="passwd" name="passwd" type="password"></td><td id="pw_check"></td>
				</tr>
				<tr>
					<td>패스워드 확인</td>
					<td colspan="2"><input id="passwdCheck" name="passwdCheck" type="password"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" id="name" name="name" ></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" id="email" name="email" value="${email}" readOnly ></td>
				</tr>
				<tr>
					<td colspan="3"><input type="button" id="signUp" value="회원가입"></td>
				</tr>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
			</tbody>
		</table>
	</form>
</body>

<script type="text/javascript">
var empJ = /\s/g; //공백 체크 정규식

var idJ = /^[a-z0-9]{4,12}$/; //아이디 정규식

var pwJ = /^[A-Za-z0-9]{4,12}$/;  // 비밀번호 정규식




	$('#userId').blur(function() {
		var userId = $('#userId').val();
		if(idJ.test(userId)){
		
			$("#id_check").text("");
			$("#reg_submit").attr("disabled", false);

		} else if(userId == ""){
			
			$('#id_check').text('아이디를 입력해주세요 :)');
			$('#id_check').css('color', 'red');
			$("#reg_submit").attr("disabled", true);				
			
		} else {
			
			$('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다 :) :)");
			$('#id_check').css('color', 'red');
			$("#reg_submit").attr("disabled", true);
		}
	});
	$('#passwd').blur(function() {
		var passwd = $('#passwd').val();
		if(pwJ.test(passwd)){
		
			$("#pw_check").text("");
			$("#reg_submit").attr("disabled", false);

		} else if(passwd == ""){
			
			$('#pw_check').text('패스워드를 입력해주세요 :)');
			$('#pw_check').css('color', 'red');
			$("#reg_submit").attr("disabled", true);				
			
		} else {
			
			$('#pw_check').text("패스워드는 영 대,소문자와 숫자를 이용하여 4~12자리만 가능합니다.");
			$('#pw_check').css('color', 'red');
			$("#reg_submit").attr("disabled", true);
		}
	});

	$(document).ready(function(e){
		
		var idx = false;
		
		$('#signUp').click(function(){
			if($.trim($('#userId').val()) == '' ){
				alert("아이디 입력.");
				$('#userId').focus();
				return;
			}else if($.trim($('#passwd').val()) == ''){
				alert("패스워드 입력.");
				$('#passwd').focus();
				return;
			}
			
			//패스워드 확인
			else if($('#passwd').val() != $('#passwdCheck').val()){
				alert('패스워드가 다릅니다.');
				$('#passwd').focus();
				return;
			}
			
			if(idx==false){
				alert("아이디 중복체크를 해주세요.");
				return;
			}else{
				$('#signFrm').submit();
			}
		});
		
		$('#check').click(function(){
			$.ajax({
				url: "${pageContext.request.contextPath}/idCheck.do",
				type: "GET",
				data:{
					"userId":$('#userId').val()
				},
				success: function(data){
					if(data == 0 && $.trim($('#userId').val()) != '' ){
						idx=true;
						$('#userId').attr("readonly",true);
						var html="<tr><td colspan='3' style='color: green'>사용가능</td></tr>";
						$('#idCheck').empty();
						$('#idCheck').append(html);		
					}else{

						var html="<tr><td colspan='3' style='color: red'>이미 가입된 아이디 입니다.</td></tr>";
						$('#idCheck').empty();
						$('#idCheck').append(html);
					}
				},
				error: function(){
					alert("서버에러");
				}
			});
			

		});
		
	});
</script>
</html>