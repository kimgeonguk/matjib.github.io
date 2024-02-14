<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "view/color.jsp" %>
<%
	int num = Integer.parseInt(request.getParameter("mf_num"));
	String pageNum = request.getParameter("pageNum");
%>
    
    
<!DOCTYPE html>
<html>
<head>
<link href="../css/style" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
<meta charset="UTF-8">
<title></title>
</head>

<body bgcolor="<%=bodyback_c%>">
<div align="center">
<b>글삭제</b>
<br><br>
<form action="f_boardDeleteProc.jsp?pageNum=<%=pageNum%>" 
onsubmit="return deleteSave()" method="post" name="delForm">
<table width="360" border="1" align="center" cellpadding="0" cellspacing="0">
	<tr height="30">
		<td align="center" bgcolor="<%=value_c%>">
		<b>비밀번호를 입력해 주세요.</b>
		</td>
	</tr>
	
	<tr height="30">
		<td align="center">비밀번호:
			<input type="password" name="mf_pass" size="8" maxlength="12">
			<input type="hidden" name="mf_num" value="<%=num %>">
		</td>
	</tr>
	
	<tr height="30">
		<td align="center" bgcolor="<%=value_c%>">
			<input type="submit" value="글삭제">
			<input type="button" value="글목록"
			onclick="document.location.href='f_boardList.jsp?pageNum=<%=pageNum %>'">
		</td>
	</tr>
	
	
</table>
</form>
</div>
</body>
</html>