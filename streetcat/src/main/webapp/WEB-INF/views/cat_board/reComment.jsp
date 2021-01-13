<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title></title>
</head>
<body>
 <h3>답 글 달 기</h3>
 댓글내용 : ${getComment.content}
 <form name="f" action="cat_board_comment_write.do" method="post">
  <textarea rows="3" cols="60"  name="content" required></textarea>
  <input type="hidden" name="type" value="popup">
  <input type="hidden" name="re_step" value="${getComment.re_step}">
  <input type="hidden" name="re_level" value="${getComment.re_level}">
  <input type="hidden" name="bnum" value="${getComment.bnum}">
  <input type="hidden" name="comment_num" value="${getComment.comment_num}">
  <input type="submit" value="등록">
 </form>
</body>
</html>