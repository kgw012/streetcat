<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- cat_content.jsp-->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>

	<div class="container">
		<h1 class="page-header">����� ������</h1>
		<div class="table-responsive">
			<table class="table table-striped table-bordered">
				<tr>
					<th width="20%">�����</th>
					<td>${writer }</td>
				</tr>
				<tr>
					<th width="20%">����� �̸�</th>
					<td>${getCat.name }</td>
				</tr>
				<tr>
					<th width="20%">����� Ư¡</th>
					<td>${getCat.feature }</td>
				</tr>
				<tr>
					<th width="20%">������ġ</th>
					<td>
						<div id="map" style="width:100%;height:350px;"></div>
					</td>
				</tr>
				<tr>
					<th width="20%">����� ����</th>
					<td><img src="./resources/upload/cat/${getCat.image}" width="150" height="150"></td>
				</tr>
				<tr>
					<td colspan="2">
						<form name="editForm" action="cat_edit.do" method="post" style="display: inline;">
							<input type="hidden" name="unum" value="${getCat.unum }">
							<input type="hidden" name="cnum" value="${getCat.cnum }">
							<input type="hidden" name="writer" value="${writer }">
						</form>
						<form name="deleteForm" action="cat_delete.do" method="post" style="display: inline;">
							<input type="hidden" name="cnum" value="${getCat.cnum }">
						</form>
						<div class="btn-group pull-right" role="group">
							<input type="button" class="btn btn-default" value="�����ϱ�" onclick="go_edit(${getCat.unum});">
							<input type="button" class="btn btn-default" value="�����ϱ�" onclick="go_delete(${getCat.unum})">
							<input type="button" class="btn btn-default" value="��Ϻ���" onclick="window.location='cat_list.do'">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	
	<!-- Kakao Map API �ҷ����� -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js
		?appkey=c545970a000c32aa58cb39d32c259bd4"></script>
		
	<!-- functions -->
	<script type="text/javascript">
		//�������� üũ
		function go_edit(unum){
			if(unum == null){
				alert("�α��� �� �̿����ּ���");
				return;
			}
			if("${sessionScope.grade}" == "������"){
				alert("������ �������� ������ �����մϴ�.");
				document.editForm.submit();
				return;
			}
			if(unum != "${sessionScope.unum}"){
				alert("�ۼ��ڸ� ������ �� �ֽ��ϴ�.");
				return;
			}
			document.editForm.submit();
		}
		
		//�������� üũ
		function go_delete(unum){
			if(unum == null){
				alert("�α��� �� �̿����ּ���");
				return;
			}
			if("${sessionScope.grade}" == "������"){
				var flag = confirm("������ �������� ��ϵ� ����̸� �����Ͻðڽ��ϱ�?");
				if(flag==true){
					alert("�����Ǿ����ϴ�.");
					document.deleteForm.submit();
				}else{
					alert("����Ͽ����ϴ�.");
				}
				return;
			}
			if(unum != "${sessionScope.unum}"){
				alert("�ۼ��ڸ� ������ �� �ֽ��ϴ�.");
				return;
			}
	
			var flag = confirm("������ �����Ͻðڽ��ϱ�?");
	
			if(flag==true){
				alert("�����Ǿ����ϴ�.");
				document.deleteForm.submit();
			}else{
				alert("����Ͽ����ϴ�.");
			}
		}
	</script>
	
	<!-- Kakao Map ���� -->
	<script>
		var name = '${getCat.name}';
		var loc = '${getCat.location}';
		var lat = '${getCat.location_lat}';
		var lng = '${getCat.location_long}';
		var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
		    mapOption = {
		        center: new kakao.maps.LatLng(lat, lng), // ������ �߽���ǥ
		        level: 3 // ������ Ȯ�� ����
		    };  
		
		// ������ �����մϴ�    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		//��Ŀ�� ǥ�õ� ��ġ�Դϴ� 
		var markerPosition  = new kakao.maps.LatLng(lat, lng); 
		
		// ��Ŀ�� �����մϴ�
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		// ��Ŀ�� ���� ���� ǥ�õǵ��� �����մϴ�
		marker.setMap(map);
		
		var iwContent = '<div style="padding:5px;">' + name + '<br>' + loc + '</div>', // ���������쿡 ǥ��� �������� HTML ���ڿ��̳� document element�� �����մϴ�
		    iwPosition = new kakao.maps.LatLng(lat, lng); //���������� ǥ�� ��ġ�Դϴ�
		
		// ���������츦 �����մϴ�
		var infowindow = new kakao.maps.InfoWindow({
		    position : iwPosition, 
		    content : iwContent 
		});
		  
		// ��Ŀ ���� ���������츦 ǥ���մϴ�. �ι�° �Ķ������ marker�� �־����� ������ ���� ���� ǥ�õ˴ϴ�
		infowindow.open(map, marker); 
	</script>

<%@ include file="../bottom.jsp" %>