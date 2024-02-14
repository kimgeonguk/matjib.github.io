<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="board.TotalVO" %>
<%@ page import="board.MainDAO" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setCharacterEncoding("utf-8"); %>
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
<%
int pageSize = 5;

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = request.getParameter("pageNum");
String m_searchWhat = request.getParameter("m_searchWhat");
String mserchbox = request.getParameter("mserchbox");
String m_searchBoard = request.getParameter("m_searchBoard");


if(mserchbox != null){
	mserchbox = new String(mserchbox.getBytes("utf-8"), "utf-8");
}

if(pageNum == null){
	pageNum = "1";
}

// 현재 페이지
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

int count1 = 0;
int count2 = 0;
int count3 = 0;


int number1 = 0;
int number2 = 0;
int number3 = 0;


List<TotalVO> articleList = null;
MainDAO dbPro = MainDAO.getInstance();


	count1 = dbPro.getArticleCount(m_searchBoard, m_searchWhat, mserchbox);
	count2 = dbPro.getArticleCount(m_searchBoard, m_searchWhat, mserchbox);
	count3 = dbPro.getArticleCount(m_searchBoard, m_searchWhat, mserchbox);

	if(count1 > 0) {
		articleList = dbPro.getArticles(m_searchBoard, m_searchWhat, mserchbox, startRow, endRow );
	}
	if(count2 > 0) {
		articleList = dbPro.getArticles(m_searchBoard, m_searchWhat, mserchbox, startRow, endRow );
	}
	if(count3 > 0) {
		articleList = dbPro.getArticles(m_searchBoard, m_searchWhat, mserchbox, startRow, endRow );
	}


	
number1 = count1 - (currentPage - 1) * pageSize;
number2 = count2 - (currentPage - 1) * pageSize;
number3 = count3 - (currentPage - 1) * pageSize;

%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통합검색</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>

</head>
<body bgcolor="">
<form name="chooseLanguage" align="right">
	<select name="Language">
		<option value="Korean">한국어</option>
		<option value="Japaness">Japaness</option>
	</select>
</form><br>
<form action="MainBoardList.jsp" name="searchForm" align="right" onsubmit="return search()" method="post">
	<select id="m_searchBoard" name="m_searchBoard" onchange="searchChoice(this)"  style="text-align: center;">	
		<option value="">--------검색게시판 선택-------</option> 
		<option value="i_board">공지게시판</option> 
		<option value="f_board">자유게시판</option>
		<option value="r_board">리뷰게시판</option>
	</select>

	<select name="m_searchWhat" id="m_searchWhat" value='<%=getParam(request, "m_searchWhat")%>'>
			<option value="" align="center" selected="selected">--------검색조건 선택-------</option>
			<option value="writer" align="center">작성자</option>
			<option value="subject" align="center">제목</option>
			<option value="content" align="center">내용</option>
			<option value="header" align="center">역이름(리뷰게시판)</option>
			
	</select>	
 <input type="text" name="mserchbox">
 <input type="submit" value="검색">
</form>
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
<%if(request.getParameter("m_searchBoard").equals("i_board")){ 
%>
<h3>공지게시판 검색결과</h3>
<%
if(count1 == 0) { // 저장된 글이 없을 경우
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
 <tr align="center">
  <td>게시판에 저장된 글이 없습니다.</td>
 </tr>
</table>
<%} else{ // 글이 있을 경우 %>

<table width="800" border="1" cellpadding="0" cellspacing="0" align="center">
 <tr height="30" bgcolor="">
  <td align="center" width="50">번호</td>
  <td align="center" width="250">제목</td>
  <td align="center" width="100">작성자</td>
  <td align="center" width="150">작성일</td>
  <td align="center" width="50">조회수</td>
 </tr>
 <% for(int i = 0; i < articleList.size(); i++) {
 	TotalVO article = (TotalVO)articleList.get(i);
 %>
 <tr height="30">
  <td align="center" width="50"><%=number1-- %></td>
  <td width="250">
  <%
   int wid = 0;
 
  %>
   <img src="../img/level.gif" width="<%=wid %>" height="16">
 
    <a href="../i_board/i_boardContent.jsp?mi_num=<%= article.getMi_num()%>&pageNum=<%=currentPage%>">
    <%=article.getMi_subject() %></a> 
    <%if(article.getMi_readcount() >= 20) { %>
    <img alt="" src="img/hot.gif" border="0" height="16">
    <%} %>
    <td align="center" width="100"><%=article.getMi_writer() %></td>
  <td align="center" width="150"><%=sdf.format(article.getMi_postdate()) %></td>
  <td align="center" width="50"><%=article.getMi_readcount() %></td> 
 
 </tr>
 <%} %>
</table>
<%}


if(count1 > 0) {
	 
	int pageBlock = 5;
	
	int imsi = count1 % pageSize == 0 ? 0 : 1;
	
	int pageCount = count1/pageSize + imsi;
	
	int startPage = (int)((currentPage - 1) / pageBlock) * pageBlock + 1;
	int endPage = startPage + pageBlock - 1;
	
	if(endPage > pageCount) endPage = pageCount;
	
	if(startPage > pageBlock) {
		
	%>
	<a href="MainBoardList.jsp?pageNum=<%= startPage-pageBlock %>&m_searchBoard=<%=m_searchBoard %>&m_searchWhat=<%=m_searchWhat%>&mserchbox=<%=mserchbox%>">[이전]</a>
	<% }
	for(int i = startPage; i <= endPage; i++){	
		%>		
	<a href="MainBoardList.jsp?pageNum=<%=i%>&m_searchBoard=<%=m_searchBoard %>&m_searchWhat=<%=m_searchWhat%>&mserchbox=<%=mserchbox%>">[<%=i %>]</a>		
<% 	}
	if(endPage < pageCount){ %>	
	<a href="MainBoardList.jsp?pageNum=<%= startPage+pageBlock %>&m_searchBoard=<%=m_searchBoard %>&m_searchWhat=<%=m_searchWhat%>&mserchbox=<%=mserchbox%>">[다음]</a>
<%} 
 }
}
else if(getParam(request,"m_searchBoard").equals("f_board")){ %>
<h3>자유게시판 검색결과</h3>
<%
if(count2 == 0) { // 저장된 글이 없을 경우
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
 <tr align="center">
  <td>게시판에 저장된 글이 없습니다.</td>
 </tr>
</table>
<%} else{ // 글이 있을 경우 %>

<table width="800" border="1" cellpadding="0" cellspacing="0" align="center">
 <tr height="30" bgcolor="">
  <td align="center" width="50">번호</td>
  <td align="center" width="250">제목</td>
  <td align="center" width="100">작성자</td>
  <td align="center" width="150">작성일</td>
  <td align="center" width="50">조회수</td>
 </tr>
 <% for(int i = 0; i < articleList.size(); i++) {
 	TotalVO article = (TotalVO)articleList.get(i);
 %>
 <tr height="30">
  <td align="center" width="50"><%=number2-- %></td>
  <td width="250">
  <%
   int wid = 0;
 
  %>
   <img src="../img/level.gif" width="<%=wid %>" height="16">
 
    <a href="../f_board/f_boardContent.jsp?mf_num=<%= article.getMf_num()%>&pageNum=<%=currentPage%>">
    <%=article.getMf_subject() %></a> 
    <%if(article.getMf_readcount() >= 20) { %>
    <img alt="" src="img/hot.gif" border="0" height="16">
    <%} %>
    <td align="center" width="100"><%=article.getMf_writer() %></td>
  <td align="center" width="150"><%=sdf.format(article.getMf_postdate()) %></td>
  <td align="center" width="50"><%=article.getMf_readcount() %></td> 
 
 </tr>
 <%} %>
</table>
<%}


if(count2 > 0) {
	 
	int pageBlock = 5;
	
	int imsi = count2 % pageSize == 0 ? 0 : 1;
	
	int pageCount = count2/pageSize + imsi;
	
	int startPage = (int)((currentPage - 1) / pageBlock) * pageBlock + 1;
	int endPage = startPage + pageBlock - 1;
	
	if(endPage > pageCount) endPage = pageCount;
	
	if(startPage > pageBlock) {	
		// 검색일 경우와 아닐 경우 페이지 처리
		
	%>
	<a href="MainBoardList.jsp?pageNum=<%= startPage-pageBlock %>&m_searchBoard=<%=m_searchBoard %>&m_searchWhat=<%=m_searchWhat%>&mserchbox=<%=mserchbox%>">[이전]</a>
	<% }
	for(int i = startPage; i <= endPage; i++){	
	%>		
	<a href="MainBoardList.jsp?pageNum=<%=i%>&m_searchBoard=<%=m_searchBoard %>&m_searchWhat=<%=m_searchWhat%>&mserchbox=<%=mserchbox%>">[<%=i %>]</a>		
<% 	}
	if(endPage < pageCount){ %>	
	<a href="MainBoardList.jsp?pageNum=<%= startPage+pageBlock %>&m_searchBoard=<%=m_searchBoard %>&m_searchWhat=<%=m_searchWhat%>&mserchbox=<%=mserchbox%>">[다음]</a>
<%}  
}
}
else if(getParam(request,"m_searchBoard").equals("r_board")){
%>
<%
if(count3 == 0) { // 저장된 글이 없을 경우
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
 <tr align="center">
  <td>게시판에 저장된 글이 없습니다.</td>
 </tr>
</table>
<%} else{ // 글이 있을 경우 %>
<table width="800" border="1" cellpadding="0" cellspacing="0" align="center">
 <tr height="30" bgcolor="">
  <td align="center" width="50">번호</td>
  <td align="center" width="100">말머리</td>
  <td align="center" width="250">제목</td>
  <td align="center" width="100">작성자</td>
  <td align="center" width="150">작성일</td>
  <td align="center" width="50">조회수</td>
 </tr>
 <% for(int i = 0; i < articleList.size(); i++) {
 	TotalVO article = (TotalVO)articleList.get(i);
 %>
 <tr height="30">
  <td align="center" width="50"><%=number3-- %></td>
  <td align="center" width="100"><%=article.getMr_header() %></td>
  <td width="250">
  <%
   int wid = 0;
  %>
   <img src="../img/level.gif" width="<%=wid %>" height="16">
   <a href="../r_board/r_boardContent.jsp?mr_num=<%= article.getMr_num()%>&pageNum=<%=currentPage%>">
    <%=article.getMr_subject() %></a> 
    <%if(article.getMr_readcount() >= 20) { %>
    <img alt="" src="img/hot.gif" border="0" height="16">
    <%} %>
    <td align="center" width="100"><%=article.getMr_writer() %></td>
  <td align="center" width="150"><%=sdf.format(article.getMr_postdate()) %></td>
  <td align="center" width="50"><%=article.getMr_readcount() %></td>
 </tr>
 <%} %>
</table>
<%}

if(count3 > 0) {
	 
	int pageBlock = 5;
	
	int imsi = count3 % pageSize == 0 ? 0 : 1;
	
	int pageCount = count3/pageSize + imsi;
	
	int startPage = (int)((currentPage - 1) / pageBlock) * pageBlock + 1;
	int endPage = startPage + pageBlock - 1;
	
	if(endPage > pageCount) endPage = pageCount;
	
	if(startPage > pageBlock) {	
		// 검색일 경우와 아닐 경우 페이지 처리
		
	%>
	<a href="MainBoardList.jsp?pageNum=<%= startPage-pageBlock %>&m_searchBoard=<%=m_searchBoard %>&m_searchWhat=<%=m_searchWhat%>&mserchbox=<%=mserchbox%>">[이전]</a>
	<% }
	for(int i = startPage; i <= endPage; i++){	
	%>		
	<a href="MainBoardList.jsp?pageNum=<%=i%>&m_searchBoard=<%=m_searchBoard %>&m_searchWhat=<%=m_searchWhat%>&mserchbox=<%=mserchbox%>">[<%=i %>]</a>		
<% 	}
	if(endPage < pageCount){ %>	
	<a href="MainBoardList.jsp?pageNum=<%= startPage+pageBlock %>&m_searchBoard=<%=m_searchBoard %>&m_searchWhat=<%=m_searchWhat%>&mserchbox=<%=mserchbox%>">[다음]</a>
<%} 
 }
}
%>
</div>
<div align="center">
<table width = "700" align="center">
 <tr bgcolor="">
 <td style="position: absolute; left: 48%;"><a href="MainScreen.jsp">홈페이지으로 돌아가기</a></td>
 </tr>
</table>
<hr color="skyblue">
<footer id="footer">
<div></div>
<nav id="bottomMenu" align="center">
	<ul>
		<li><a href="#" class="bottomLink">페이지 이용방법&nbsp;&nbsp;</a></li>
		<li><a href="#" class="bottomLink">고객문의&nbsp;&nbsp;</a></li>
		<li><a href="#" class="bottomLink">이용약관&nbsp;&nbsp;</a></li>
		<li><a href="#" class="bottomLink">개인정보 처리방침</a></li>
	</ul><br>
	</nav>
		<pre style="font-size: 7px; position: fixed; " align="center">
		상호명 : (주)맛집 노선도
			주소 : 서울시 영등포구 영중로 56 신한빌딩 4, 5층 주식회사 글로벌인
		Email : matjibcs@gmail.com
		</pre>
</footer>
</div>
</body>
</html>