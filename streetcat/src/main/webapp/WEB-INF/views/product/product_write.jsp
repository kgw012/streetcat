<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- write.jsp -->
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
<title>�Խñ۾���  </title>

</head>
<body>
<div align="center">
	<form name="f" action="product_write_ok.do" method="post"
												 enctype ="multipart/form-data">
										
		<table border="1" width="500">
			<tr bgcolor="yellow">
				<td align="center" colspan="2">�� ǰ �� õ</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">��ǰ ����</th>
				<td><input type="file" name="image1_file" class="box"></td>
			</tr>
				<tr>
				<th width="20%" bgcolor="yellow">��Ÿ ����</th>
				<td><input type="file" name="image2_file" class="box"></td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">��ǰ��</th>
				<td><input type="text" name="pname" class="box" size="45"></td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">�Ǹ�����</th>
				<td><input type="text" name="shopname" class="box" size="45"></td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">����</th>
				<td><input type="text" name="price" class="box" size="45"></td>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">����</th>
				<td><select name ="type">
						<option>:::����:::</option>
						<option value="feed">���</option>
						<option value="tuna">��ġ</option>
						<option value="snack">��</option>
						<option value="toy">�峭��</option>
						<option value="sand">��</option>
						<option value="etc">��Ÿ</option>
						
				</select>
			</tr>
			<tr>
				<th width="20%" bgcolor="yellow">����</th>
				<td><textarea name="content" rows="11" cols="45" class="box"></textarea></td>
			</tr>
			
			<tr bgcolor="yellow">
				<td colspan="2" align="center">
					<input type="submit" value="�۾���">
					<input type="reset" value="�ٽþ���">
					<input type="button" value="��Ϻ���" onclick="window.location='product_list.do?unum=${unum}'">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>