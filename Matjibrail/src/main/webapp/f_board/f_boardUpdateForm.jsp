<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.F_BoardVO" %>
<%@ page import="board.F_BoardDAO" %>
<%@ include file="view/color.jsp" %>
<% request.setCharacterEncoding("utf-8");
   response.setCharacterEncoding("utf-8");
%>
<%!
public String getParam(HttpServletRequest req, String param){
	if(req.getParameter(param) != null){
		return req.getParameter(param);
	}
	else{
		return "";
	}
}

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
function fileElement(fe){
	
	var cnt = fe.elements.length;
	
	var filecnt = 1;
	
	for(i=0; i < cnt; i++){
		if(fe.elements[i].type == "file"){
			if(fe.elments[i].value==""){
				alert(filecnt + "번째 파일정보가 누락되었습니다.");
				fe.elements[i].focus();
				return;
			}
			filecnt++;
		}
	}
	fe.submit();
}

</script>
</head>
<%
int num = Integer.parseInt(request.getParameter("mf_num"));
	String pageNum = request.getParameter("pageNum");
	
	try{
		
		F_BoardDAO dbPro = F_BoardDAO.getInstance();
		
		F_BoardVO article = dbPro.updateGetArticle(num);
%>	
<body bgcolor="<%=bodyback_c%>">
<form name="chooseLanguage" align="right">
	<select name="Language">
		<option value="Korean">한국어</option>
		<option value="Japaness">Japaness</option>
	</select>
</form><br>
<div align="center"><font size="6em"><b>맛집 노선도</b></font><br>
<hr color="skyblue">
<nav id="topMenu" align="center">
	<ul>
		<li><a href="i_boardList.jsp" class="menuLink">공지사항</a></li>
		<li><a href="f_boardList.jsp" class="menuLink">자유게시판</a></li>
		<li><a href="r_boardList.jsp" class="menuLink">맛집 리뷰 게시판</a></li>
		<li><a href="#" class="menuLink">회원 메뉴</a></li>
	</ul>
</nav>
<hr color="skyblue">
<div style="position: absolute; left: 35%; font-size:2em;"><b>글수정</b></div><br><br>
	<form action="f_boardUpdateForm.jsp?pageNum=<%=pageNum%>" method="post" name="f_boardUpdateForm" onsubmit="return writeSave()">
		<table width="400" border="1" cellpadding="0" cellspacing="0" align="center" bgcolor="<%=bodyback_c%>">
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">아이디</td>
				<td width="330" align="left"><input type="text" size="20" maxlength="20" name="mf_writer" value="<%=article.getMf_writer()%>">
											<input type="hidden" name="mf_num" value="<%=article.getMf_num()%>">
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
				<td width="330" align="left">
					<input type="text" size="50" maxlength="50" name="mf_subject" value="<%=article.getMf_subject()%>">				<!-- 새글일 경우 -->		
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">내용</td>
				<td width="330" align="left"><textarea rows="14" cols="50" name="mf_content"><%=article.getMf_content()%>"</textarea></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">기존파일</td>
				<td><%=article.getMf_image() %></td>
			</tr>
			<tr>
				<td width="140" bgcolor="<%=value_c%>" align="center">추가할 파일 수(최대 9개)</td>
				<td width="150"><input type="text" size="2" name="add" value='<%=getParam(request, "add")%>'><input type="submit" value="확인"></td>
				<td><input type="hidden" name="mf_pass" value="<%=article.getMf_pass() %>"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" bgcolor="<%=value_c%>">
				<input type="submit" value="글수정"> <input type="reset" value="다시작성"> 
				<input type="button" value="목록" onClick="document.location='r_boardList.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
		</table>
		<%
	int filecnt = 0;
	
	if(request.getParameter("add") != null){
		
		filecnt = Integer.parseInt(request.getParameter("add"));
	}
	else{
		filecnt = 0;
	}
	%>
<%-- 		<table>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
				<td width="330" align="left"><input type="password" size="20" maxlength="20" name="mf_pass"></td>
			</tr>
		</table>
 --%>
 	<table>
			<tr>
				<td><input type="hidden" name="mf_pass" value="1234"></td>
			</tr>
		</table>
 	</form>	
	<form action="f_boardUpdateProc.jsp?pageNum=<%=pageNum%>" encType="multipart/form-data" method="post">
		<input type="hidden" name="mf_writer" value="<%=getParam(request, "mf_writer") %>">
		<input type="hidden" name="mf_pass" value="<%=getParam(request, "mf_pass") %>">
		<input type="hidden" name="mf_subject" value="<%=getParam(request, "mf_subject") %>">
		<input type="hidden" name="mf_content" value="<%=getParam(request, "mf_content") %>">
		<input type="hidden" name="add" value="<%=getParam(request, "add") %>">
		<% 
	for(int i = 0; i < filecnt; i++){
		if(filecnt > 9){
			filecnt = 9;
		}
	
	%>
	<%=i+1 %> 번째 파일 선택 : <input type="file" name="mf_image<%=i+1%>"><br>
	
	<%} %>
	
	<table>
			<tr>
				<td colspan="2" align="center" bgcolor="<%=value_c%>">
					<input type="submit" value="글수정">
					<input type="reset" value="되돌리기">
					<input type="button" value="목록" onClick="document.location='f_boardList.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
	</table>
	</form>	
</div>
<%}catch(Exception e){} %>

</body>
</html>