<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
    <script type="text/javascript">
    function setChildValue(cnum,location,name,feature){
    	document.getElementById("pcnum").value = cnum;
        document.getElementById("plocation").value = location;
        document.getElementById("pname").value = name;
        document.getElementById("pfeature").value = feature;
  }
    var num = 2;
    function addFile(){
    	if(num>5){
    		alert("������ 5�� ���ϸ� �����մϴ�");
    		return;
    	}
    	var input = '<br><input type="file" name="image'+num+'">';
    	num++;
    	var fileContainer = document.getElementById('file_container');
    	fileContainer.innerHTML += input;
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
 <option value="public">�����</option>
 </select>
 </td>
 </tr>
 <tr>
 <td>�ۼ���</td>
 <td><input type="text" name="writer" value="${sessionScope.name}"></td>
 </tr>
 <tr>
 <td>����</td>
 <td><input type="text" name="subject"></td>
 </tr>
 <tr>
 <td>����</td>
 <td>
 <div id="file_container">
 <input type="file" name="image1">
 </div>
 <button type="button" onclick="addFile()">+</button>
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
 <button type="button" onclick="window.open('cat_find.do','childForm', 'width=570, height=350, resizable = no, scrollbars = no')">�����ã��
 </button>
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
