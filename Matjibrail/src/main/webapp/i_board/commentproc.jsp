<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ page import="board.CommentDAO"%>
 <%@ page import="java.sql.Timestamp"%>
 <%@ page import="java.util.ArrayList" %>

 <%
  request.setCharacterEncoding("utf-8");
  %>
 <jsp:useBean id="article" class="board.CommentVO" scope="page"> 

 	<jsp:setProperty name="article" property="*" /> 
</jsp:useBean>
 <%
 String content = request.getParameter("content");
 
 %>
 <%
 System.out.println("->"+content);
 
 article.setRegdate(new Timestamp(System.currentTimeMillis()));
/*  String writer = request.getParameter("writer");
 article.setWriter(writer); */
 
 article.setContent(request.getParameter("content"));
 
 
 
  CommentDAO dbPro = CommentDAO.getInstance();
//   CommentDAO dbPro = new CommentDAO();
 
dbPro.insertArticle(article);
 

/* 
 response.sendRedirect("i_boardContent.jsp");
  */
 %>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<script type="text/javascript">

location.href = document.referrer;
</script>

</body>
</html>