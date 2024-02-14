<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="dao" class="member.MemberDAO" />
<%
	String id = request.getParameter("id");
	boolean check = dao.idCheck(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복 체크</title>
<link href="../css/style.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="./script.js"></script>
</head>
<body bgcolor="#FFFFCC">
<br>
<div align="center">
<b><%=id %></b>
<%
if(check) {
	out.println("는(은) 이미 존재하는 ID입니다.<br><br>");
}else {
	out.println("는(은) 사용 가능한 ID입니다.<br><br>");
}
%>
<a href="#" onclick="javascript:self.close()">닫기</a>
</div>
</body>
</html>