<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" %>
<!-- upgrade.jsp -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">

<%@include file ="top.jsp" %>


<form name="f" method="POST" action="upgrade.do">
	<input type="hidden" name="unum" value="${getMember.unum }"/>
	<table width="600" align="center" class="outline">
  		<tr>
			<td colspan="2" align=center class="m2">회원수정</td>
 		</tr>
		<tr>
			<td width="150" class="m3">이름</td>
			<td class="m3">
				<input type="text" name="name" class="box" 
												value="${getMember.name}" readOnly>
			</td>
		</tr>
		<tr>
			<td width="150" class="m3">아이디</td>
			<td class="m3">
				<input type="text" name="id" class="box"
												value="${getMember.id}" readOnly>
			</td>
  		</tr>
  	
  	
  		</tr>
  		<tr>
			<td width="150" class="m3">이메일</td>
			<td class="m3">
				<input type="text" name="email" class="box"
											value="${getMember.email}" readOnly>
			</td>
  		</tr>
  		<tr>
			<td width="150" class="m3">회원 등급</td>

				<td class="m3"><select name ="grade">
						<option>:::등급:::</option>
						<option value="0">일반회원</option>
						<option value="1">준회원</option>
						<option value="2">우수회원</option>
						<option value="3">관리자</option>
						
				</select>
			</td>
  		</tr>
  		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="등급 수정">
				<a href="#">[취소]</a>
			</td>
  		</tr>
  	</table>
</form>	




<%@include file ="bottom.jsp" %>










