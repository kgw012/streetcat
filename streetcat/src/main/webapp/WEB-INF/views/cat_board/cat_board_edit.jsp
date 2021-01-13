<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
    <script type="text/javascript">
    function setChildValue(cnum,location,name,feature){
    	document.getElementById("pcnum").value = cnum;
        document.getElementById("plocation").value = location;
        document.getElementById("pname").value = name;
        document.getElementById("pfeature").value = feature;
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
 <option value="public">비공개</option>
 </select>
 </td>
 </tr>
 <tr>
 <td>작성자</td>
 <td><input type="text" value="${getBoard.writer}" readonly></td>
 </tr>
 <tr>
 <td>제목</td>
 <td><input type="text" name="subject" value="${getBoard.subject}"></td>
 </tr>
 <tr>
 <td>파일</td>
 <td><input type="file" name="image1"><br>
 <input type="file" name="image2"><br>
 <input type="file" name="image3"><br>
 <input type="file" name="image4"><br>
 <input type="file" name="image5"></td>
 </tr>
 <tr>
 <td>내용</td>
 <td><textarea name="content" rows="20" cols="100%" value="${getBoard.content}"></textarea></td>
 </tr>
 <tr>
 <td>위치</td>
 <td><input type="text" name="location" id="plocation" value="${getBoard.location}">
 <input type="hidden" name="cnum" id="pcnum">
 <button type="button" onclick="window.open('cat_find.do','childForm', 'width=570, height=350, resizable = no, scrollbars = no')">고양이찾기
 </button>
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