<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  

<!-- messageWrite.jsp -->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>


	<div class="container">
		<div class="jumbotron">
			<h2>�� �� �� ��</h2>
			<form id="f" name="f" action="messageSend.do" method="post">
	             �޴»��<input type="text" name="receiveId" class="form-control" id="userId" value="${sendId}"><br><br>
		   <textarea name="content" cols="100%" rows="20" class="form-control"></textarea><br>
		  <div align="left">
			<input type="button" class="btn btn-default" value="������" id="check">
			<input type="reset" class="btn btn-default" value="�ٽþ���">
			</div>
			</form>
			
			
			
			
			
			
			
		</div>
	</div>


	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
		
	<!-- functions -->
	<script type="text/javascript">
		$(document).ready(function(e){
			
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
							$('#userId').focus();
							alert('���� ���̵��Դϴ� �ٽ� �Է����ּ���.');
						}else{
							alert('���� ����!');
							$('#f').submit();
						}
					},
					error: function(){
						alert("��������");
					}
				});
				
	
			});
			
		});
	</script>
	
	
<%@ include file="../bottom.jsp" %>