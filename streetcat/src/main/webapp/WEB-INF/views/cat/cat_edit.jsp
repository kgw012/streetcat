<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>길냥이 수정하기</title>
	<style>
	    .map_wrap {position:relative;width:100%;height:350px;}
	    .title {font-weight:bold;display:block;}
	    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
	    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
	    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	</style>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js
		?appkey=c545970a000c32aa58cb39d32c259bd4
		&libraries=services"></script>
	<script type="text/javascript">
		function check(){
			if(f.name.value==""){
				alert("길냥이 이름을 입력해주세요!");
				f.name.focus();
				return false;
			}
			if(f.feature.value==""){
				alert("길냥이 특징을 입력해주세요!");
				f.feature.focus();
				return false;
			}
			if (f.location.value==""){
				alert("지도상에 출현 위치를 클릭해주세요!");
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
    <h2><a href="home.do">CATSTREET</a></h2>
	<div align="center">
		<h1>길냥이 수정하기</h1>
		<br>
		<form name="f" action="cat_edit_ok.do" method="post" enctype ="multipart/form-data" onsubmit="return check()">
			<table border="1" style="width:800px;">
				<tr bgcolor="yellow">
					<td align="center" colspan="2">길냥이 수정하기</td>
				</tr>
				<tr>
					<th width="20%" bgcolor="yellow">등록자</th>
					<td><input type="text" name="mbId" value="${mbId }" class="box" size="45" readonly></td>
					<input type="hidden" name="unum" value="${unum }">
				</tr>
				<tr>
					<th width="20%" bgcolor="yellow">길냥이 이름</th>
					<td><input type="text" name="name" class="box" size="45" value="${cat.name }"></td>
				</tr>
				<tr>
					<th width="20%" bgcolor="yellow">길냥이 특징</th>
					<td><input type="text" name="feature" class="box" size="45" value="${cat.feature }"></td>
				</tr>
				<tr>
					<th width="20%" bgcolor="yellow">출현위치</th>
					<td>
						<input type="hidden" name="location" value="${cat.location }" />
						<input type="hidden" name="location_lat" value="${cat.location_lat }" />
						<input type="hidden" name="location_long" value="${cat.location_long }" />
						<div class="map_wrap">
						    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
						    <div class="hAddr">
						        <span class="title">지도중심기준 행정동 주소정보</span>
						        <span id="centerAddr"></span>
						    </div>
						</div>
					</td>
				</tr>
				<tr>
					<th width="20%" bgcolor="yellow">길냥이 사진 수정하기</th>
					<td>
						<img src="./resources/upload/${cat.image}" width="150" height="150">
						<input type="hidden" name="image" value="${cat.image }">
						<br>
						수정할 이미지 선택 : <input type="file" id="image_file" name="image_file">
					</td>
				</tr>
				<tr bgcolor="yellow">
					<td colspan="2" align="center">
						<input type="hidden" name="cnum" value="${cat.cnum }">
						<input type="submit" value="수정완료">
						<input type="reset" value="다시쓰기">
						<input type="button" value="목록보기" onclick="window.location='cat_list.do'">
					</td>
				</tr>
			</table>
		</form>
	</div>
	
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
    
var lat = ${cat.location_lat};
var lon = ${cat.location_long};

var locPosition = new kakao.maps.LatLng(lat, lon);

// 클릭한 위치를 표시할 마커입니다
var marker = new kakao.maps.Marker({
	position: locPosition
});
map.setCenter(locPosition);
marker.setMap(map);

// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
searchAddrFromCoords(map.getCenter(), displayCenterInfo);

// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
        	var location = result[0].address.address_name;
        	document.getElementsByName('location')[0].value = location;
        	
            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
            detailAddr += '<div>지번 주소 : ' + location + '</div>';
            
            var content = '<div class="bAddr">' +
                            '<span class="title">법정동 주소정보</span>' + 
                            detailAddr + 
                        '</div>';

            // 마커를 클릭한 위치에 표시합니다 
            marker.setPosition(mouseEvent.latLng);
            marker.setMap(map);
            document.getElementsByName('location_lat')[0].value = mouseEvent.latLng.getLat();
            document.getElementsByName('location_long')[0].value = mouseEvent.latLng.getLng();

            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
            infowindow.setContent(content);
            infowindow.open(map, marker);
        }   
    });
});

// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', function() {
    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
});

function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}

function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        var infoDiv = document.getElementById('centerAddr');

        for(var i = 0; i < result.length; i++) {
            // 행정동의 region_type 값은 'H' 이므로
            if (result[i].region_type === 'H') {
                infoDiv.innerHTML = result[i].address_name;
                break;
            }
        }
    }    
}
</script>
</body>
</html>