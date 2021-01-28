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
    	    alert('�̹������� ������ jpg, png, gif �� ��� �����մϴ�.');
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
    	      k = "<img id='" + i+ "'src='" + e.target.result + "' style='width:auto;height:" + d + "px;max-width:" + c + "px;' alt='�̹���'/>";
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
<h3 align="center">�� �� �� �� ��</h3>
<div align="center">
<form name="f" action="cat_board_edit_ok.do" method="post" enctype="multipart/form-data">
<table border="1" width="60%" 
 >
 <tr>
 <td>��������</td>
 <td>
 <select name="type">
 <option value="all">��ü����</option>
 <option value="member">ȸ������</option>
 <option value="private">�����</option>
 </select>
 </td>
 </tr>
 <tr>
 <td>�ۼ���</td>
 <td><input type="text" name="writer" value="${sessionScope.mbId}" readonly></td>
 </tr>
 <tr>
 <td>����</td>
 <td><input type="text" name="subject" value="${getBoard.subject}"></td>
 </tr>
 <tr>
 <td>����</td>
 <td>
 <div id="file_container">
 
 <input type="file"  name="image1" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view1', 50, 50)">��ǥ�̹���
 <div id="img_view1" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image1}">
 <img src="./resources/upload/catBoard/${getBoard.image1}" width="50" height="50"><a href="image_delete.do?image=image1&bnum=${getBoard.bnum}" onclick="return confirm('���� �����Ͻðڽ��ϱ�?')">����</a>
 </c:if>
 </div>
 <input type="file"  name="image2" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view2', 50, 50)">
 <div id="img_view2" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image2}">
 <img src="./resources/upload/catBoard/${getBoard.image2}" width="50" height="50"><a href="image_delete.do?image=image2&bnum=${getBoard.bnum}" onclick="return confirm('���� �����Ͻðڽ��ϱ�?')">����</a>
 </c:if>
 </div>
 <input type="file"  name="image3" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view3', 50, 50)">
 <div id="img_view3" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image3}">
 <img src="./resources/upload/catBoard/${getBoard.image3}" width="50" height="50"><a href="image_delete.do?image=image3&bnum=${getBoard.bnum}" onclick="return confirm('���� �����Ͻðڽ��ϱ�?')">����</a>
 </c:if>
 </div>
 <input type="file"  name="image4" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view4', 50, 50)">
 <div id="img_view4" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image4}">
 <img src="./resources/upload/catBoard/${getBoard.image4}" width="50" height="50"><a href="image_delete.do?image=image4&bnum=${getBoard.bnum}" onclick="return confirm('���� �����Ͻðڽ��ϱ�?')">����</a>
 </c:if>
 </div>
 <input type="file"  name="image5" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, 'img_view5', 50, 50)">
 <div id="img_view5" style="width:auto;height:50px;max-width:50px;margin-bottom:20px;margin-left:10px;">
 <c:if test="${not empty getBoard.image5}">
 <img src="./resources/upload/catBoard/${getBoard.image5}" width="50" height="50"><a href="image_delete.do?image=image5&bnum=${getBoard.bnum}" onclick="return confirm('���� �����Ͻðڽ��ϱ�?')">����</a>
 </c:if>
 </div>
 
 </div>
 <br>
 </tr>
 <tr>
 <td>����</td>
 <td><textarea name="content" rows="20" cols="100%">${getBoard.content}</textarea>
 
 </td>
 </tr>
 <tr>
 <td>��ġ</td>
 <td><input type="text" name="location" id="plocation" value="${getBoard.location}">
 <input type="hidden" name="cnum" id="pcnum" value="${getBoard.cnum}">
 <input type="hidden" name="bnum" value="${getBoard.bnum}">
 <button type="button" onclick="window.open('cat_find.do','childForm', 'width=570, height=350, resizable = no, scrollbars = yes')">�����ã��
 </button>
 </td>
 </tr>
 <tr>
 <td>��ǥ�̹���</td>
 <td><img name="cat_image" id="cat_image" style="width:150px; max-height:150px;" src="./resources/upload/cat/${getBoard.cat_image }">
 <input type="hidden" name="cat_image" id="cat_image">
 </td>
 </tr>
 <tr>
 <td>�̸�</td>
 <td><input type="text" name="name" id="pname" value="${getBoard.name}">
 </td>
 </tr>
 <tr>
 <td>Ư¡</td>
 <td><input type="text" name="feature" id="pfeature" value="${getBoard.feature}"></td>
 </tr>
 <tr>
		<td colspan="2" align="center">
		<input type="submit" value="�۾���">
		<input type="reset" value="�ٽþ���">
		<input type="button" value="��Ϻ���" onclick="window.location='cat_board.do'">
		</td>
</tr>
</table>
</form>
</div>