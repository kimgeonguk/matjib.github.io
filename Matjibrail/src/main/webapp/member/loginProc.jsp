<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="dao" class="member.MemberDAO" />

<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");
int check = dao.loginCheck(id, pass);

if(check == 1) {
	session.setAttribute("loginID", id);
	response.sendRedirect("login.jsp");
}else if(check == 0) {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<script type="text/javascript">
alert("비밀번호가 틀렸습니다.");
history.go(-1);
</script>
<%}else { %>
<script type="text/javascript">
alert("아이디가 존재하지 않습니다.");
history.go(-1);
</script>
<%} %>
</body>
</html>