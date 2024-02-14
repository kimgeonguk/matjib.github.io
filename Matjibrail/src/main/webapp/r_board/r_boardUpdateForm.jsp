<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.R_BoardVO"%>
<%@ page import="board.R_BoardDAO"%>
<%@ include file="view/color.jsp"%>
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

function stationChoice(s){
	var num1 = ["동대문역사문화공원","뚝섬","상왕십리","시청","신당","신촌","아현","왕십리","을지로3가","을지로4가","을지로입구","이대","충정로","한양대"];
	var num2 = ["강변","건대입구","구의","성수","신설동","용답","용두","잠실","잠실나루","잠실새내","종합운동장"];
	var num3 = ["강남","교대","구로디지털단지","낙성대","방배","봉천","사당","삼성","서초","서울대입구","선릉","신대방","신림","역삼"];
	var num4 = ["까치산","당산","대림","도림천","문래","신도림","신정네거리","양천구청","영등포구청","합정","홍대입구"];
	
	var target = document.getElementById("mr_header");
	
	if(s.value== "10")var d = num1;
	else if(s.value== "20") var d = num2;
	else if(s.value== "30") var d = num3;
	else if(s.value== "40") var d = num4;
	
	target.options.length = 0;
	
	for(x in d){
		
		var opt = document.createElement("option");
		opt.value = d[x];
		opt.innerHTML = d[x];
		target.appendChild(opt);
	}
	
}
</script>
</head>
<%
int num = Integer.parseInt(request.getParameter("mr_num"));
String pageNum = request.getParameter("pageNum");

try {

	R_BoardDAO dbPro = R_BoardDAO.getInstance();

	R_BoardVO article = dbPro.updateGetArticle(num);
	
	
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
		<div style="position: absolute; left: 35%; font-size: 2em;">
			<b>글수정</b>
		</div><br><br>
		<form action="r_boardUpdateForm.jsp?pageNum=<%=pageNum%>" method="post" name="r_boardUpdateForm" onsubmit="return writeSave()">
			<table width="400" border="1" cellpadding="0" cellspacing="0"
				align="center" bgcolor="<%=bodyback_c%>">
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">아이디</td>
					<td width="330" align="left">
					<input type="text" size="20" maxlength="20" name="mr_writer"value="<%=article.getMr_writer()%>"> 
					<input type="hidden"name="mr_num" value="<%=article.getMr_num()%>"></td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
					<td width="330" align="left"><input type="text" size="50"
						maxlength="50" name="mr_subject"
						value="<%=article.getMr_subject()%>"></td>
				</tr>
				<tr>
					<td width="140" bgcolor="<%=value_c%>" align="center">구간 선택</td>
					<td width="330" height="10"><select name="mr_bcheck" onchange="stationChoice(this)" value='<%=getParam(request, "mr_bcheck")%>'>
							<option value="">-------구간을 선택하세요---------</option>
							<option value="10" align="center">구간1(신촌~뚝섬)</option>
							<option value="20" align="center">구간2(신설동~종합운동장)</option>
							<option value="30" align="center">구간3(삼성~구로디지털단지)</option>
							<option value="40" align="center">구간4(대림~홍대입구)</option>
					</select></td>
					<td width="140" bgcolor="<%=value_c%>" align="center">역이름 선택</td>
					<td width="330" height="10">
					<select name="mr_header" id="mr_header" value='<%=getParam(request, "mr_header")%>'>
							<option value="" align="center" selected="selected">--------역 이름을 선택하세요-------</option>
					</select></td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">내용</td>
					<td width="330" align="left"><textarea rows="14" cols="50"
							name="mr_content"><%=article.getMr_content()%>"</textarea></td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">기존파일</td>
					<td><%=article.getMr_image() %></td>
				</tr>
				<tr>
					<td width="140" bgcolor="<%=value_c%>" align="center">추가할 파일 수(최대 9개)</td>
					<td width="150"><input type="text" size="2" name="add" value='<%=getParam(request, "add")%>'><input type="submit" value="확인"></td>
					<td><input type="hidden" name="mr_pass" value="<%=article.getMr_pass() %>"></td>
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
	 	<table>
			<tr>
				<td><input type="hidden" name="mf_pass" value="1234"></td>
			</tr>
		</table>
	
	
<%-- 		<table>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
				<td width="330" align="left"><input type="password" size="20" maxlength="20" name="mr_pass"></td>
			</tr>
		</table> --%>
	</form>	
	<form action="r_boardUpdateProc.jsp?pageNum=<%=pageNum%>" encType="multipart/form-data" method="post">
		<input type="hidden" name="mr_writer" value="<%=getParam(request, "mr_writer") %>">
		<input type="hidden" name="mr_pass" value="<%=getParam(request, "mr_pass") %>">
		<input type="hidden" name="mr_subject" value="<%=getParam(request, "mr_subject") %>">
		<input type="hidden" name="mr_bcheck" value="<%=getParam(request, "mr_bcheck") %>">
		<input type="hidden" name="mr_header" value="<%=getParam(request, "mr_header") %>">
		<input type="hidden" name="mr_content" value="<%=getParam(request, "mr_content") %>">
		<input type="hidden" name="add" value="<%=getParam(request, "add") %>">
		<%
			if (Integer.parseInt(request.getParameter("add")) > 0) {
			%>
			<input type="hidden" name="add" value="<%=getParam(request, "add")%>">
			<%
			} else {
			%>
			<script type="text/javascript">
				alert("이미지 개수를 입력해주세요(없을경우 숫자 0입력).");
				history.go(-1);
			</script>
			<%
			}
			%>
			<%
			for (int i = 0; i < filecnt; i++) {
				if (filecnt > 9) {
					filecnt = 9;
				}
			%>
	<%=i+1 %> 번째 파일 선택 : <input type="file" name="mr_image<%=i+1%>"><br>
	
	<%} %>
	
	<table>
			<tr>
				<td colspan="2" align="center" bgcolor="<%=value_c%>">
					<input type="submit" value="글수정">
					<input type="reset" value="되돌리기">
					<input type="button" value="목록" onClick="document.location='r_boardList.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
	</table>
		</form>
	</div>
	<%}catch(Exception e){} %>

</body>
</html>