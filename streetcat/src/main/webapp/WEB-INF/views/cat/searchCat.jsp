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
		<h1 class="page-header text-center">고양이 위치검색</h1>
		<p class="text-center">지도를 클릭하여 근방의 고양이들을 찾습니다.</p>
		<form name="f" method="post">
			<input type="hidden" name="searchString" value="">
			<input type="hidden" name="search" value="">
		</form>
		<div align="center">
			<div id="map" style="width:500px;height:400px;"></div>
		</div>
		<br>
		<div class="text-center">
			<input type="button" class="btn btn-primary" value="찾기" onclick="searchSubmit(lat, lon);">
		</div>
	</div>
	
	
	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	
	<!-- Kakao Map API 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js
		?appkey=c545970a000c32aa58cb39d32c259bd4"></script>
		
	<!-- Kakao Map 설정 -->
	<script>
		var lat = 33.450701,
			lon = 126.570667;
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨 
		    }; 

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({  
	        map: map, 
	        position: new kakao.maps.LatLng(lat, lon)
	    });
		
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		        
		        // 마커를 표시합니다
		        displayMarker(locPosition);
		            
		      });
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치를 설정합니다
		    
		    var locPosition = new kakao.maps.LatLng(lat, lon);    
		        
		    displayMarker(locPosition);
		}
		
	    
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(locPosition) {
	
		    marker.setPosition(locPosition);
		    // 지도 중심좌표를 접속위치로 변경합니다
		    map.setCenter(locPosition);      
		}
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    lat = latlng.getLat();
		    lon = latlng.getLng();
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
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