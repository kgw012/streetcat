<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
<!-- message2.jsp -->
<%
		String msg = (String)request.getAttribute("msg");
		String url = (String)request.getAttribute("url");
		%>
			<script type="text/javascript">
				alert("<%=msg%>")
				location.href="<%=url%>"
				self.close()
			</script>

