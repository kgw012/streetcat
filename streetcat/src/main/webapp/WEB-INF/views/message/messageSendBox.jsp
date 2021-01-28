<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!-- messageSendBox.jsp -->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>

	<div class="container">
		<div class="jumbotron">
			<h2>보 낸 쪽 지 함</h2>
			<div align="right">
			<button type="button" class="btn btn-default" onclick="window.location.href = 'messageWrite.do'">쪽지쓰기</button>
			<button type="button" class="btn btn-default" onclick="window.location.href = 'messageBox.do'">받은쪽지함</button>
			</div>
			            <form name="f" action="messageSendDelete.do" method="post">
            <div align="left">
            <input type="submit" class="btn btn-default" value="삭제">
            </div>
		<table border="1" width="100%" class="table table-hover">
		 <tr>
		  <td width="8%">
		     선 택
		  </td>
		  <td width="12%">
		   받은사람
		  </td>
		  <td>
		  내 용
		  </td>
		  <td width="16%">
		  날 짜
		  </td >
		  <td width="16%">
		 열람
		  </td >
		 </tr>
		 <tr>
		  <c:if test="${empty getMessage }">
		  <td colspan="5">
		  보낸 쪽지가 없습니다
		  </td>
		  </c:if>
		    <% int i = 0;%>
          <c:forEach var="dto" items="${getMessage}">
          <%i++; %>
          <tr>
          <td width="8%">
          <input type="checkbox" name="checkbox<%=i%>" value="${dto.mnum}">
          </td>
          <td width="12%">
           ${dto.receiveId}
          </td>
          <td width="16%" style="text-overflow:ellipsis; overflow:hidden;">
          <nobr><a href="messageContent.do?mnum=${dto.mnum}">${dto.content}</a></nobr>
		  </td> 
		  <td>
		   ${dto.reg_date}
		  </td> 
		  <td width="16%">
		  <c:if test="${dto.read==0}">
		     미</c:if>열람
		  </td>  
		  </tr>
 		  </c:forEach>
		 </tr>
		</table>
		</form>
		</div>
	</div>


	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
		
<%@ include file="../bottom.jsp" %>