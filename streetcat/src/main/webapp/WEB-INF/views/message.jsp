<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
<!-- message.jsp -->
<%
		String msg = (String)request.getAttribute("msg");
		String url = (String)request.getAttribute("url");
		if (url.equals("popup")){%>
			<script type="text/javascript">
			    opener.location.reload()
				alert("<%=msg%>")
				self.close()
			</script>
			<%}else if(url.equals("haveId")){ %>
			<script type="text/javascript">
				alert("<%=msg%>")
				self.close()
			</script>
<% 	}else {%>
			<script type="text/javascript">
				alert("<%=msg%>")
				location.href="<%=url%>"
			</script>
<%	} %>
