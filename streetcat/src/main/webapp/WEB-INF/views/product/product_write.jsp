<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- write.jsp -->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
<title>게시글쓰기  </title>

</head>
<body>
<div align="center">
	<form name="f" action="product_write_ok.do" method="post"
												 enctype ="multipart/form-data">
										
		<table border="1" width="500">
			<tr bgcolor="yellow">
				<td align="center" colspan="2">상 품 추 천</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">상품 사진</th>
				<td><input type="file" name="image1_file" class="box"></td>
			</tr>
				<tr>
				<th width="20%" bgcolor="yellow">기타 사진</th>
				<td><input type="file" name="image2_file" class="box"></td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">상품명</th>
				<td><input type="text" name="pname" class="box" size="45"></td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">판매점명</th>
				<td><input type="text" name="shopname" class="box" size="45"></td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">가격</th>
				<td><input type="text" name="price" class="box" size="45"></td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">종류</th>
				<td><select name ="type">
						<option>:::종류:::</option>
						<option value="feed">사료</option>
						<option value="tuna">참치</option>
						<option value="snack">츄르</option>
						<option value="toy">장난감</option>
						<option value="sand">모래</option>
						<option value="etc">기타</option>
						
				</select>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">내용</th>
				<td><textarea name="content" rows="11" cols="45" class="box"></textarea></td>
			</tr>
			
			<tr bgcolor="yellow">
				<td colspan="2" align="center">
					<input type="submit" value="글쓰기">
					<input type="reset" value="다시쓰기">
					<input type="button" value="목록보기" onclick="window.location='product_list.do?unum=${unum}'">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>