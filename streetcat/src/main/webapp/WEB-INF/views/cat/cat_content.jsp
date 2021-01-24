<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>����� ������</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js
		?appkey=c545970a000c32aa58cb39d32c259bd4"></script>
	<script type="text/javascript">
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
</head>
<body>
    <h2><a href="home.do">CATSTREET</a></h2>
	<div align="center">
		<h1>����� ������</h1>
		<br>
		<table border="1" style="width:800px;">
			<tr bgcolor="yellow">
				<td align="center" colspan="2">����� ������</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">�����</th>
				<td align="center">${mbId }</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">����� �̸�</th>
				<td align="center">${getCat.name }</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">����� Ư¡</th>
				<td align="center">${getCat.feature }</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">������ġ</th>
				<td>
					<div id="map" style="width:100%;height:350px;"></div>
				</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">����� ����</th>
				<td align="center"><img src="./resources/upload/${getCat.image}" width="150" height="150"></td>
			</tr>
			<tr bgcolor="yellow">
				<td colspan="2" align="center">
					<form name="editForm" action="cat_edit.do" method="post" style="display: inline;">
						<input type="hidden" name="unum" value="${getCat.unum }">
						<input type="hidden" name="cnum" value="${getCat.cnum }">
						<input type="hidden" name="mbId" value="${mbId }">
						<input type="button" value="�����ϱ�" onclick="go_edit(${getCat.unum});">
					</form>
					<form name="deleteForm" action="cat_delete.do" method="post" style="display: inline;">
						<input type="hidden" name="cnum" value="${getCat.cnum }">
						<input type="button" value="�����ϱ�" onclick="go_delete(${getCat.unum})">
					</form>
					<input type="button" value="��Ϻ���" onclick="window.location='cat_list.do'">
				</td>
			</tr>
		</table>
	</div>
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
</body>
</html>