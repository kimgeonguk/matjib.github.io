<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="dao" class="member.MemberDAO" />
<jsp:useBean id="vo" class="member.MemberVO" />

<jsp:setProperty property="*" name="vo"/>



<!DOCTYPE html>
<%
 request.setCharacterEncoding("utf-8");
 String english = request.getParameter("english");
 String email = request.getParameter("email");
     
 String id = dao.findId(english, email); //아이디를 디비에서 가져옴..실패시 널
 
%>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>

<body>

<%-- 

<%
String name = request.getParameter("name");
String email = request.getParameter("email");
 
 String id = dao.findid(name, email);
%>
 --%>
<%if(id==null){ %>
<script type="text/javascript">
alert("존재하지 않은 계정입니다");
history.go(-1);
</script>
<%}else{%>
<script type="text/javascript">
alert("찾으시는 계정은 <%=id %>입니다.");
location.href="login.jsp";
</script>
<%}%>

</body>
</html>