<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"  %>
<!-- updateForm.jsp -->



<html>
<head><title>�ۼ���</title></head>
<body>



<link rel="stylesheet" type="text/css" href="style.css">





<div align ="center">
<form name="f" method="post" action = "product_update.do"
		onsubmit="return check()">
		
		<input type = "hidden" name ="pnum" value ="${getProduct.pnum }"/>
<table border="1" width ="500" height ="650">

<tr> <td  bgcolor="skyblue" align="center" width="15%">��ǰ��</td><td><input type ="text" name = pname  size ="30"  value="${getProduct.pname }"></td></tr>
<tr > <td bgcolor="skyblue" align="center" width="15%">�Ǹ�����</td><td><input type ="text" name = shopname size ="30"  value="${getProduct.shopname }"></td></tr>
<tr > <td bgcolor="skyblue" align="center" width="15%">����</td><td><textarea name="content" rows="20" cols="50">${getProduct.content }</textarea></td></tr>
<tr > <td bgcolor="skyblue" align="center" width="15%">����</td><td><input type ="text" name = price size ="30"  value="${getProduct.price }"></td></tr>
 		
			<tr>
				<td align="center" width="15%" bgcolor="skyblue">����</td>
				<td><select name ="type">
						<option>:::����:::</option>
						<option value="feed">���</option>
						<option value="snack">��</option>
						<option value="toy">�峭��</option>
						<option value="sand">��</option>
						
				</select>
			</tr>
 					
	<tr><td colspan ="2" bgcolor="skyblue" align="center" width="10%"><a  href = "product_update.do"><input type="submit" value="�ۼ���"></a>
			<input type="reset" value="�ٽ��ۼ�">
		<input type="button" value="��Ϻ���" onclick="window.location='product_list.do?unum=${unum}'">
				</td>	
					</tr>
				
</table>
</form>
</div>
</body>
</html>

