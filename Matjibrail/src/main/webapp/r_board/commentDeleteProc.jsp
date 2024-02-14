<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.CommentVO" %>
<%@ page import="board.CommentDAO" %>
<%@ page import="java.sql.Timestamp" %>

<jsp:useBean id="article" class="board.CommentVO" scope="page">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>


<%
request.setCharacterEncoding("utf-8");
String num = request.getParameter("mr_num");
String loginID = (String)session.getAttribute("loginID");

	String pageNum = request.getParameter("pageNum");
	CommentDAO dbPro = new CommentDAO();
	
%>
<%
	int check = dbPro.deleteArticle(Integer.parseInt(num), loginID);

	if(check == 1){
		
out.println("<script>");
out.println("alert('삭제 완료하였습니다.')");
out.println("location.href = document.referrer;");
out.println("</script>");

}else {
	
	out.println("<script>");
	out.println("alert('삭제 실패하였습니다.')");
	out.println("location.href = document.referrer;");
	out.println("</script>");
}
	 %>	
</body>
</html>