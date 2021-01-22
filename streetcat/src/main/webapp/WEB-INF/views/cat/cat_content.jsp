<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>고양이 상세정보</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js
		?appkey=c545970a000c32aa58cb39d32c259bd4"></script>
</head>
<body>
	<div align="center">
		<h1>고양이 등록하기</h1>
		<br>
		<table border="1" style="width:800px;">
			<tr bgcolor="yellow">
				<td align="center" colspan="2">고양이 상세정보</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">고양이 이름</th>
				<td align="center">${getCat.name }</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">고양이 특징</th>
				<td align="center">${getCat.feature }</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">출현위치</th>
				<td>
					<div id="map" style="width:100%;height:350px;"></div>
				</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">고양이 사진</th>
				<td align="center"><img src="./resources/upload/${getCat.image}" width="150" height="150"></td>
			</tr>
			<tr bgcolor="yellow">
				<td colspan="2" align="center">
					<input type="submit" value="등록하기">
					<input type="reset" value="다시쓰기">
					<input type="button" value="목록보기" onclick="window.location='cat_list.do'">
				</td>
			</tr>
		</table>
	</div>
	<script>
		var name = '${getCat.name}';
		var loc = '${getCat.location}';
		var lat = '${getCat.location_lat}';
		var lng = '${getCat.location_long}';
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		//마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(lat, lng); 
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		var iwContent = '<div style="padding:5px;">' + name + '<br>' + loc + '</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwPosition = new kakao.maps.LatLng(lat, lng); //인포윈도우 표시 위치입니다
		
		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
		    position : iwPosition, 
		    content : iwContent 
		});
		  
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker); 
	</script>
</body>
</html>