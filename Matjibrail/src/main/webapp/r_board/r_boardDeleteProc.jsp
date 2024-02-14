<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="board.R_BoardDAO" %>
<%@ page import="java.sql.Timestamp" %>

<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="article" class="board.R_BoardVO" scope="page">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" http-equiv="refresh" content="0; URL=r_boardList.jsp"  >
<title></title>
</head>
<body>

<%
request.setCharacterEncoding("utf-8");
String num = request.getParameter("mr_num");
String loginID = (String)session.getAttribute("loginID");

	String pageNum = request.getParameter("pageNum");
	R_BoardDAO dbPro = new R_BoardDAO();
	
%>
<%
	int check = dbPro.deleteArticle(Integer.parseInt(num), loginID);

	if(check == 1){
		
out.println("<script>");
out.println("alert('삭제 완료하였습니다.')");
/* out.println("window.history.go(-2);"); */
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