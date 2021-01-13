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
    		alert("파일은 5개 이하만 가능합니다");
    		return;
    	}
    	var input = '<br><input type="file" name="image'+num+'">';
    	num++;
    	var fileContainer = document.getElementById('file_container');
    	fileContainer.innerHTML += input;
    	}
   </script>
<h3 align="center">게 시 글 작 성</h3>
<div align="center">
<form name="f" action="cat_board_write_ok.do" method="post" enctype="multipart/form-data">
<table border="1" width="60%" 
 >
 <tr>
 <td>공개범위</td>
 <td>
 <select name="type">
 <option value="all">전체공개</option>
 <option value="member">회원공개</option>
 <option value="public">비공개</option>
 </select>
 </td>
 </tr>
 <tr>
 <td>작성자</td>
 <td><input type="text" name="writer" value="${sessionScope.name}"></td>
 </tr>
 <tr>
 <td>제목</td>
 <td><input type="text" name="subject"></td>
 </tr>
 <tr>
 <td>파일</td>
 <td>
 <div id="file_container">
 <input type="file" name="image1">
 </div>
 <button type="button" onclick="addFile()">+</button>
 <br>
 </tr>
 <tr>
 <td>내용</td>
 <td><textarea name="content" rows="20" cols="100%"></textarea></td>
 </tr>
 <tr>
 <td>위치</td>
 <td><input type="text" name="location" id="plocation">
 <input type="hidden" name="cnum" id="pcnum">
 <button type="button" onclick="window.open('cat_find.do','childForm', 'width=570, height=350, resizable = no, scrollbars = no')">고양이찾기
 </button>
 </td>
 </tr>
 <tr>
 <td>이름</td>
 <td><input type="text" name="name" id="pname">
 </td>
 </tr>
 <tr>
 <td>특징</td>
 <td><input type="text" name="feature" id="pfeature"></td>
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
