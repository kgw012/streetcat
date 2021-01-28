<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- cat_content.jsp-->
<%@ include file="../top.jsp" %>
<%@ include file="../navbar.jsp" %>

	<div class="container">
		<h1 class="page-header">길냥이 상세정보</h1>
		<div class="table-responsive">
			<table class="table table-striped table-bordered">
				<tr>
					<th width="20%">등록자</th>
					<td>${writer }</td>
				</tr>
				<tr>
					<th width="20%">길냥이 이름</th>
					<td>${getCat.name }</td>
				</tr>
				<tr>
					<th width="20%">길냥이 특징</th>
					<td>${getCat.feature }</td>
				</tr>
				<tr>
					<th width="20%">출현위치</th>
					<td>
						<div id="map" style="width:100%;height:350px;"></div>
					</td>
				</tr>
				<tr>
					<th width="20%">길냥이 사진</th>
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
							<input type="button" class="btn btn-default" value="수정하기" onclick="go_edit(${getCat.unum});">
							<input type="button" class="btn btn-default" value="삭제하기" onclick="go_delete(${getCat.unum})">
							<input type="button" class="btn btn-default" value="목록보기" onclick="window.location='cat_list.do'">
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
	
	<!-- Kakao Map API 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js
		?appkey=c545970a000c32aa58cb39d32c259bd4"></script>
		
	<!-- functions -->
	<script type="text/javascript">
		//수정권한 체크
		function go_edit(unum){
			if(unum == null){
				alert("로그인 후 이용해주세요");
				return;
			}
			if("${sessionScope.grade}" == "관리자"){
				alert("관리자 권한으로 정보를 수정합니다.");
				document.editForm.submit();
				return;
			}
			if(unum != "${sessionScope.unum}"){
				alert("작성자만 수정할 수 있습니다.");
				return;
			}
			document.editForm.submit();
		}
		
		//삭제권한 체크
		function go_delete(unum){
			if(unum == null){
				alert("로그인 후 이용해주세요");
				return;
			}
			if("${sessionScope.grade}" == "관리자"){
				var flag = confirm("관리자 권한으로 등록된 고양이를 삭제하시겠습니까?");
				if(flag==true){
					alert("삭제되었습니다.");
					document.deleteForm.submit();
				}else{
					alert("취소하였습니다.");
				}
				return;
			}
			if(unum != "${sessionScope.unum}"){
				alert("작성자만 삭제할 수 있습니다.");
				return;
			}
	
			var flag = confirm("정말로 삭제하시겠습니까?");
	
			if(flag==true){
				alert("삭제되었습니다.");
				document.deleteForm.submit();
			}else{
				alert("취소하였습니다.");
			}
		}
	</script>
	
	<!-- Kakao Map 설정 -->
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

<%@ include file="../bottom.jsp" %>