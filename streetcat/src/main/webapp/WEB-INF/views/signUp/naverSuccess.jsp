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
    document.getElementById("name2").value=name
    document.getElementById("userId").value=email
    document.getElementById("email2").value=email
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
                     <input type="hidden" id="userId" name="userId" >      
                  <input type="hidden" id ="name2" name="name">
                  <input type="hidden" id ="email2" name="email">
               
               <br>
               <button type="submit" class="btn btn-success">회원가입</button>
         </form>
         </div>
</body>

</html>