<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"  %>
<!-- updateForm.jsp -->



<html>
<head><title>글수정</title></head>
<body>



<link rel="stylesheet" type="text/css" href="style.css">





<div align ="center">
<form name="f" method="post" action = "product_update.do"
		onsubmit="return check()">
		
		<input type = "hidden" name ="pnum" value ="${getProduct.pnum }"/>
<table border="1" width ="500" height ="650">

<tr> <td  bgcolor="skyblue" align="center" width="15%">상품명</td><td><input type ="text" name = pname  size ="30"  value="${getProduct.pname }"></td></tr>
<tr > <td bgcolor="skyblue" align="center" width="15%">판매점명</td><td><input type ="text" name = shopname size ="30"  value="${getProduct.shopname }"></td></tr>
<tr > <td bgcolor="skyblue" align="center" width="15%">내용</td><td><textarea name="content" rows="20" cols="50">${getProduct.content }</textarea></td></tr>
<tr > <td bgcolor="skyblue" align="center" width="15%">가격</td><td><input type ="text" name = price size ="30"  value="${getProduct.price }"></td></tr>
 		
			<tr>
				<td align="center" width="15%" bgcolor="skyblue">종류</td>
				<td><select name ="type">
						<option>:::종류:::</option>
						<option value="feed">사료</option>
						<option value="snack">츄르</option>
						<option value="toy">장난감</option>
						<option value="sand">모래</option>
						
				</select>
			</tr>
 					
	<tr><td colspan ="2" bgcolor="skyblue" align="center" width="10%"><a  href = "product_update.do"><input type="submit" value="글수정"></a>
			<input type="reset" value="다시작성">
		<input type="button" value="목록보기" onclick="window.location='product_list.do?unum=${unum}'">
				</td>	
					</tr>
				
</table>
</form>
</div>
</body>
</html>

