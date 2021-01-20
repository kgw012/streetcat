<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- product_delete.jsp -->


<c:if test ="${param.pnum ==null }">
<c:redirect url="product_list.jsp"/>
</c:if>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">


<div align="center">
<form name ="f" action ="product_delete.do" method ="post">

<table align ="center" width ="400" border="1"> <caption>글삭제</caption>
<tr bgcolor ="yellow" align ="center"> <td>삭제를 원하시면 'delete'를 입력해 주세요. </td> </tr>
<tr align ="center"> <td> 입력 : <input type ="text" name ="pname" size="10"></td></tr>
<tr align ="center"> <td> 
<input type="hidden" name="pnum" value="${param.pnum}"/>
		<a href="product_delete.do">	<input type ="submit" name= "delete" value="글삭제"></a>
				<input type ="button" name= "list" value="글목록" onclick = "window.location='product_list.do'"> 
</table>
</form>
</div>




