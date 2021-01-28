<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!-- searchCat.jsp -->
<%@ include file="../top.jsp" %>
	
	<style>
		body {
		  padding-top: 0px;
		}
	</style>
	
	<div class="container" style="height:100%;">
		<h1 class="page-header text-center">����� ��ġ�˻�</h1>
		<p class="text-center">������ Ŭ���Ͽ� �ٹ��� ����̵��� ã���ϴ�.</p>
		<form name="f" method="post">
			<input type="hidden" name="searchString" value="">
			<input type="hidden" name="search" value="">
		</form>
		<div align="center">
			<div id="map" style="width:500px;height:400px;"></div>
		</div>
		<br>
		<div class="text-center">
			<input type="button" class="btn btn-primary" value="ã��" onclick="searchSubmit(lat, lon);">
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
		
	<!-- Kakao Map ���� -->
	<script>
		var lat = 33.450701,
			lon = 126.570667;
		var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(lat, lon), // ������ �߽���ǥ
		        level: 3 // ������ Ȯ�� ���� 
		    }; 

		var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�

	    // ��Ŀ�� �����մϴ�
	    var marker = new kakao.maps.Marker({  
	        map: map, 
	        position: new kakao.maps.LatLng(lat, lon)
	    });
		
		// HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ� 
		if (navigator.geolocation) {
		    
		    // GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        lat = position.coords.latitude, // ����
	            lon = position.coords.longitude; // �浵
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon); // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
		        
		        // ��Ŀ�� ǥ���մϴ�
		        displayMarker(locPosition);
		            
		      });
		    
		} else { // HTML5�� GeoLocation�� ����� �� ������ ��Ŀ ǥ�� ��ġ�� �����մϴ�
		    
		    var locPosition = new kakao.maps.LatLng(lat, lon);    
		        
		    displayMarker(locPosition);
		}
		
	    
		// ������ ��Ŀ�� ǥ���ϴ� �Լ��Դϴ�
		function displayMarker(locPosition) {
	
		    marker.setPosition(locPosition);
		    // ���� �߽���ǥ�� ������ġ�� �����մϴ�
		    map.setCenter(locPosition);      
		}
		
		// ������ Ŭ�� �̺�Ʈ�� ����մϴ�
		// ������ Ŭ���ϸ� ������ �Ķ���ͷ� �Ѿ�� �Լ��� ȣ���մϴ�
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // Ŭ���� ����, �浵 ������ �����ɴϴ� 
		    var latlng = mouseEvent.latLng; 
		    
		    lat = latlng.getLat();
		    lon = latlng.getLng();
		    
		    // ��Ŀ ��ġ�� Ŭ���� ��ġ�� �ű�ϴ�
		    marker.setPosition(latlng);
		    
		});
		
		function searchSubmit(lat, lon){
			document.getElementsByName("searchString")[0].value = "findByLocation";
			document.getElementsByName("search")[0].value = lat + "," + lon;
			
			window.opener.name = "parentPage";
			document.f.target = "parentPage";
			document.f.action = "cat_list.do";
			document.f.submit();
			self.close();
		}
	</script>

<%@ include file="../bottom.jsp" %>