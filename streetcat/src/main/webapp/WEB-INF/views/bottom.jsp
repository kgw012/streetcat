<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

	<!-- bottom.jsp-->
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<!-- functions -->
		<!-- popper.js -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
			integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
			crossorigin="anonymous"></script>
		<!-- sockjs.js -->
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
		
	<!-- �� ���� ����ؼ� ���� ��� ������ �����ߴ��� ���ؿ���. --> 
    <script>
	    var websocket;
	    var nickname = '<c:out value="${mbId}"/>';
	    
    	<c:if test="${!empty mbId}">
		        websocket = new SockJS("http://localhost:8081/streetcat/chatting.do");
		        $('#guideMessage').text('�����');
		        
		        websocket.onopen = function(){
		        	websocket.send(nickname);
		        }
		        
		        websocket.onmessage = function(evt){
		        	if(evt.data.indexOf("readMessage")!=-1){
		        	evt.data = evt.data.replace('readMessage','')
		        	  $('#count').append('&nbsp;<span class="badge">'+evt.data+'</span>');
		        	}
		       }
		</c:if>
	</script>
</body>
</html>