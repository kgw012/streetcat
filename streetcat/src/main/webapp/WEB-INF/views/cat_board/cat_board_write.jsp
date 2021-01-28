<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
    <script type="text/javascript">
    function setChildValue(cnum,location,name,feature,cat_image_name){
    	document.getElementById("pcnum").value = cnum;
        document.getElementById("plocation").value = location;
        document.getElementById("pname").value = name;
        document.getElementById("pfeature").value = feature;
        document.getElementById("cat_image").value = cat_image_name;
        document.getElementById("cat_image_name").src = "./resources/upload/cat/" + cat_image_name;
  	}
    var num = 1;
    function addFile(){
    	
    	if(num>5){
    		alert("������ 5�� ���ϸ� �����մϴ�");
    		return;
    	}

    	var input = '<input type="file" value="����ã��" name="image'+num+'" required accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, '+"'img_view"+num+"'"+', 50, 50)"><div id="img_view'+num+'" style="width:auto;height:50px;max-width:50px;margin-bottom:10px;margin-left:10px;"></div>';
    	
    	var fileContainer = document.getElementById('file_container');
    	fileContainer.innerHTML += input;
    	num++;
    	}
    function removeFile(){

    	var input = '<input type="file" value="����ã��" name="image'+num+'" accept=".png,.jpg,.jpeg,.gif" onchange="preImg(this, '+"'img_view"+num+"'"+', 50, 50)"><div id="img_view'+num+'" style="width:auto;height:50px;max-width:50px;margin-bottom:10px;margin-left:10px;"></div>';
    	
    	var fileContainer = document.getElementById('file_container');
    	fileContainer.innerHTML = "";
    	num=1;
    	
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
    	      k = "<img id='" + i+num+ "' src='" + e.target.result + "' style='width:auto;height:" + d + "px;max-width:" + c + "px;' alt='�̹���'/>";
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
<form name="f" action="cat_board_write_ok.do" method="post" enctype="multipart/form-data">
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
 <td><input type="text" name="subject"></td>
 </tr>
 <tr>
 <td>����</td>
 <td>
 <div id="file_container">
 
 
 </div>
 <button type="button" onclick="addFile()">+</button>
 <button type="button" onclick="removeFile()">reset</button>
 <br>
 </tr>
 <tr>
 <td>����</td>
 <td><textarea name="content" rows="20" cols="100%"></textarea></td>
 </tr>
 <tr>
 <td>��ġ</td>
 <td><input type="text" name="location" id="plocation">
 <input type="hidden" name="cnum" id="pcnum">
 <button type="button" onclick="window.open('cat_find.do','childForm', 'width=570, height=350, resizable = no, scrollbars = yes')">�����ã��
 </button>
 </td>
 </tr>
 <tr>
 <td>��ǥ�̹���</td>
 <td>
 <img name="cat_image_name" id="cat_image_name" style="width:150px; max-height:150px;">
 <input type="hidden" name="cat_image" id="cat_image">
 </td>
 </tr>
 <tr>
 <td>�̸�</td>
 <td><input type="text" name="name" id="pname">
 </td>
 </tr>
 <tr>
 <td>Ư¡</td>
 <td><input type="text" name="feature" id="pfeature"></td>
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
