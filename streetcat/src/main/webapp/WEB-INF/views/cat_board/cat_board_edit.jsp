<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR" import="java.util.*,com.ezen709.streetcat.model.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script type="text/javascript">
    function setChildValue(cnum,location,name,feature,cat_image_name){
    	document.getElementById("pcnum").value = cnum;
        document.getElementById("plocation").value = location;
        document.getElementById("pname").value = name;
        document.getElementById("pfeature").value = feature;
        document.getElementById("cat_image").value = cat_image_name;
        document.getElementById("cat_image_name").src = "./resources/upload/cat/" + cat_image_name;
  }
    function preImg(a, b, c, d) {
    	  var f = a.value;
    	  var g = f.substring(f.lastIndexOf('.') + 1).toLowerCase();
    	  var h = document.getElementById(b);
    	  if (!/(jpg|png|gif|jpeg)$/i.test(g)) {
    	    alert('이미지파일 형식은 jpg, png, gif 만 등록 가능합니다.');
    	    return;
    	  }
    	  while (h.firstChild) {
    	    h.removeChild(h.firstChild);
    	  }
    	  if (window.FileReader) {
    	    var i = b + "_img";
    	    var j = new FileReader();
    	    var k = "";
    	    j.onload = function(e) {
    	      k = "<img id='" + i+ "'src='" + e.target.result + "' style='width:auto;height:" + d + "px;max-width:" + c + "px;' alt='이미지'/>";
    	      document.getElementById(b).innerHTML = k;
    	    };
    	    j.readAsDataURL(a.files[0]);
    	  } else {
    	    a.select();
    	    a.blur();
    	    var l = document.selection.createRange().text;
    	    h.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src='" + l + "')";
    	  }
    	}
   </script>
<h3 align="center">게 시 글 작 성</h3>
<div align="center">
<form name="f" action="cat_board_edit_ok.do" method="post" enctype="multipart/form-data">
<table border="1" width="60%" 
 >
 <tr>
 <td>공개범위</td>
 <td>
 <select name="type">
 <option value="all">전체공개</option>
 <option value="member">회원공개</option>
 <option value="private">비공개</option>
 </select>
 </td>
 </tr>
 <tr>
 <td>작성자</td>
 <td><input type="text" name="writer" value="${sessionScope.mbId}" readonly></td>
 </tr>
 <tr>
 <td>제목</td>
 <td><input type="text" name="subject" value="${getBoard.subject}"></td>
 </tr>
 <tr>
 <td>파일</td>
 <td>
 <div id="file_container">
 
 <input type="file"  name="image1" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view1', 50, 50)">대표이미지
 <div id="img_view1" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image1}">
 <img src="./resources/upload/catBoard/${getBoard.image1}" width="50" height="50"><a href="image_delete.do?image=image1&bnum=${getBoard.bnum}" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
 </c:if>
 </div>
 <input type="file"  name="image2" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view2', 50, 50)">
 <div id="img_view2" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image2}">
 <img src="./resources/upload/catBoard/${getBoard.image2}" width="50" height="50"><a href="image_delete.do?image=image2&bnum=${getBoard.bnum}" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
 </c:if>
 </div>
 <input type="file"  name="image3" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view3', 50, 50)">
 <div id="img_view3" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image3}">
 <img src="./resources/upload/catBoard/${getBoard.image3}" width="50" height="50"><a href="image_delete.do?image=image3&bnum=${getBoard.bnum}" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
 </c:if>
 </div>
 <input type="file"  name="image4" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view4', 50, 50)">
 <div id="img_view4" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image4}">
 <img src="./resources/upload/catBoard/${getBoard.image4}" width="50" height="50"><a href="image_delete.do?image=image4&bnum=${getBoard.bnum}" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
 </c:if>
 </div>
 <input type="file"  name="image5" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view5', 50, 50)">
 <div id="img_view5" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image5}">
 <img src="./resources/upload/catBoard/${getBoard.image5}" width="50" height="50"><a href="image_delete.do?image=image5&bnum=${getBoard.bnum}" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
 </c:if>
 </div>
 
 </div>
 <br>
 </tr>
 <tr>
 <td>내용</td>
 <td><textarea name="content" rows="20" cols="100%">${getBoard.content}</textarea>
 
 </td>
 </tr>
 <tr>
 <td>위치</td>
 <td><input type="text" name="location" id="plocation" value="${getBoard.location}">
 <input type="hidden" name="cnum" id="pcnum" value="${getBoard.cnum}">
 <input type="hidden" name="bnum" value="${getBoard.bnum}">
 <button type="button" onclick="window.open('cat_find.do','childForm', 'width=570, height=350, resizable = no, scrollbars = yes')">고양이찾기
 </button>
 </td>
 </tr>
 <tr>
 <td>대표이미지</td>
 <td><img name="cat_image" id="cat_image" style="width:150px; max-height:150px;" src="./resources/upload/cat/${getBoard.cat_image }">
 <input type="hidden" name="cat_image" id="cat_image">
 </td>
 </tr>
 <tr>
 <td>이름</td>
 <td><input type="text" name="name" id="pname" value="${getBoard.name}">
 </td>
 </tr>
 <tr>
 <td>특징</td>
 <td><input type="text" name="feature" id="pfeature" value="${getBoard.feature}"></td>
 </tr>
 <tr>
		<td colspan="2" align="center">
		<input type="submit" value="글쓰기">
		<input type="reset" value="다시쓰기">
		<input type="button" value="목록보기" onclick="window.location='cat_board.do'">
		</td>
</tr>
</table>
</form>
</div>