<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="board.R_BoardDAO" />
<jsp:useBean id="recommend" class="board.RecommendDAO" />
<jsp:useBean id="vo" class="board.RecommendVO" />
<jsp:setProperty property="*" name="vo"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String pageNum = request.getParameter("pageNum");
String num = request.getParameter("mr_num");	


String loginID = (String)session.getAttribute("loginID");

%>



<!-- 
 int check = recommend.recommendCheck(Integer.parseInt(num), loginID);/


 if(check!=1) {  -->
<%
recommend.recommendDelete(Integer.parseInt(num), loginID);  
int result = dao.DeleteRecommend(Integer.parseInt(num));
out.println("<script>");
out.println("alert('비추천 완료하였습니다.')");
out.println("location.href = document.referrer;");
out.println("</script>");

%>



<!--  }else {
	
	out.println("<script>");
	out.println("alert('이미 비추천하였습니다.')");
	out.println("location.href = document.referrer;");
	out.println("</script>");
}
	  -->
	
</body>
</html>