<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- cat_insert.jsp-->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>

	<!-- KakaoMap css -->
	<style>
	    .map_wrap {position:relative;width:100%;height:350px;}
	    .title {font-weight:bold;display:block;}
	    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
	    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
	    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	</style>
	
	<div class="container">
		<h1 class="page-header">����� ����ϱ�</h1>
		<form id="myForm" action="cat_insert_ok.do" method="post" enctype ="multipart/form-data">
			<input type="hidden" name="unum" value="${unum }">
			<div class="form-group">
				<label for="input_writer">�����</label>
				<input type="text" name="writer" class="form-control" value="${writer }" readonly>
			</div>
			<div class="form-group">
				<label for="input_name">����� �̸�</label>
				<input type="text" name="name" class="form-control">
			</div>
			<div class="form-group">
				<label for="input_feature">����� Ư¡</label>
				<input type="text" name="feature" class="form-control">
			</div>
			<div class="form-group">
				<label for="input_location">���� ��ġ</label>
				<input type="hidden" name="location" value="" />
				<input type="hidden" name="location_lat" value="" />
				<input type="hidden" name="location_long" value="" />
				<div class="map_wrap">
				    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
				    <div class="hAddr">
				        <span class="title">�����߽ɱ��� ������ �ּ�����</span>
				        <span id="centerAddr"></span>
				    </div>
				</div>
			</div>
			<div class="form-group">
				<label for="input_image">����� ����</label>
				<input type="file" id="image_file" name="image_file">
			</div>
			<div class="btn-group pull-right" role="group">
				<input type="submit" class="btn btn-default" value="����ϱ�">
				<input type="reset" class="btn btn-default" value="�ٽþ���">
				<input type="button" class="btn btn-default" value="��Ϻ���" onclick="window.location='cat_list.do'">
			</div>
		</form>
	</div>
	
	<!-- load scripts -->
		<!-- JQuery.js -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- bootstrap.js -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	
	<!-- Kakao Map API �ҷ����� -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js
		?appkey=c545970a000c32aa58cb39d32c259bd4
		&libraries=services"></script>
		
	<!-- Kakao Map ���� -->
	<script>
		var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // ������ �߽���ǥ
		        level: 3 // ������ Ȯ�� ����
		    };  
		
		// ������ �����մϴ�    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// �ּ�-��ǥ ��ȯ ��ü�� �����մϴ�
		var geocoder = new kakao.maps.services.Geocoder();
		
		var marker = new kakao.maps.Marker(), // Ŭ���� ��ġ�� ǥ���� ��Ŀ�Դϴ�
		    infowindow = new kakao.maps.InfoWindow({zindex:1}); // Ŭ���� ��ġ�� ���� �ּҸ� ǥ���� �����������Դϴ�
		    
		// HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ� 
		if (navigator.geolocation) {
		    
		    // GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat = position.coords.latitude, // ����
		            lon = position.coords.longitude; // �浵
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon); // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
		
		        // ���� �߽���ǥ�� ������ġ�� �����մϴ�
		        map.setCenter(locPosition); 
		            
		      });
		    
		} else { // HTML5�� GeoLocation�� ����� �� ������ ��Ŀ ǥ�� ��ġ�� ���������� ������ �����մϴ�
		    
		    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667);  
		
		    // ���� �߽���ǥ�� ������ġ�� �����մϴ�
		    map.setCenter(locPosition);     
		}
		
		// ���� ���� �߽���ǥ�� �ּҸ� �˻��ؼ� ���� ���� ��ܿ� ǥ���մϴ�
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		
		// ������ Ŭ������ �� Ŭ�� ��ġ ��ǥ�� ���� �ּ������� ǥ���ϵ��� �̺�Ʈ�� ����մϴ�
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		        	var location = result[0].address.address_name;
		        	document.getElementsByName('location')[0].value = location;
		        	
		            var detailAddr = !!result[0].road_address ? '<div>���θ��ּ� : ' + result[0].road_address.address_name + '</div>' : '';
		            detailAddr += '<div>���� �ּ� : ' + location + '</div>';
		            
		            var content = '<div class="bAddr">' +
		                            '<span class="title">������ �ּ�����</span>' + 
		                            detailAddr + 
		                        '</div>';
		
		            // ��Ŀ�� Ŭ���� ��ġ�� ǥ���մϴ� 
		            marker.setPosition(mouseEvent.latLng);
		            marker.setMap(map);
		            document.getElementsByName('location_lat')[0].value = mouseEvent.latLng.getLat();
		            document.getElementsByName('location_long')[0].value = mouseEvent.latLng.getLng();
		
		            // ���������쿡 Ŭ���� ��ġ�� ���� ������ �� �ּ������� ǥ���մϴ�
		            infowindow.setContent(content);
		            infowindow.open(map, marker);
		        }   
		    });
		});
		
		// �߽� ��ǥ�� Ȯ�� ������ ������� �� ���� �߽� ��ǥ�� ���� �ּ� ������ ǥ���ϵ��� �̺�Ʈ�� ����մϴ�
		kakao.maps.event.addListener(map, 'idle', function() {
		    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});
		
		function searchAddrFromCoords(coords, callback) {
		    // ��ǥ�� ������ �ּ� ������ ��û�մϴ�
		    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
		}
		
		function searchDetailAddrFromCoords(coords, callback) {
		    // ��ǥ�� ������ �� �ּ� ������ ��û�մϴ�
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}
		
		// ���� ������ܿ� ���� �߽���ǥ�� ���� �ּ������� ǥ���ϴ� �Լ��Դϴ�
		function displayCenterInfo(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        var infoDiv = document.getElementById('centerAddr');
		
		        for(var i = 0; i < result.length; i++) {
		            // �������� region_type ���� 'H' �̹Ƿ�
		            if (result[i].region_type === 'H') {
		                infoDiv.innerHTML = result[i].address_name;
		                break;
		            }
		        }
		    }    
		}
	</script>
	
	<!-- functions -->
	<script type="text/javascript">
		//myForm validation check
		$(document).ready(function(){
			$('#myForm').submit(function(){
				if($("input[name='name']").val() == ""){
					alert("����� �̸��� �Է����ּ���!");
					$("input[name='name']").focus();
					return false;
				}
				if($("input[name='feature']").val() == ""){
					alert("����� Ư¡�� �Է����ּ���!");
					$("input[name='feature']").focus();
					return false;
				}
				if ($("input[name='location']").val() == ""){
					alert("������ ���� ��ġ�� Ŭ�����ּ���!");
					return false;
				}
				if($("input[name='image_file']").val() == ""){
					alert("��ǥ������ ���ε����ּ���!");
					return false;
				}
			});
		});
	</script>
	
</body>
</html>