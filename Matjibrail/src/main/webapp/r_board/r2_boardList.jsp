<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="popup.PopupVO" %>
<%@page import="popup.PopupDAO" %>
<%@ page import="board.R_BoardVO" %>
<%@ page import="board.R_BoardDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String loginID = (String)session.getAttribute("loginID");
request.setCharacterEncoding("UTF-8");
%>
 
<%
//게시판 기능
// 한 페이지에 보여줄 목록 수 지정
int pageSize = 20;

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = request.getParameter("pageNum");
String searchWhat = request.getParameter("searchWhat");
String searchText = request.getParameter("searchText");
String searchHeader = request.getParameter("searchHeader");

if(searchText != null){
	searchText = new String(searchText.getBytes("utf-8"), "utf-8");
}
if(pageNum == null){
	pageNum = "1";
}

// 현재 페이지
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

int count = 0;
int number = 0;
int bcheck = 20;

List<R_BoardVO> articleList = null;
R_BoardDAO dbPro = R_BoardDAO.getInstance();
count = dbPro.getArticleCount(bcheck); // 전체글 수
R_BoardVO vo = new R_BoardVO();
// 검색이 아니면 전체 리스트를 보여주고 검색이면 검색한 내용만 보여줌

if(searchText == null){
	if(searchWhat != null){

		count = dbPro.getArticleCount(searchHeader);
		
		if(count > 0){
			
			articleList = dbPro.getArticles(searchHeader, startRow, endRow);

		}
	}
	else{
		count = dbPro.getArticleCount(bcheck);
		if(count > 0) {
			
			articleList = dbPro.getArticles(startRow, endRow);
		}
	}
} 
else{	
	count = dbPro.getArticleCount(searchWhat, searchText);
	if(count > 0) {
		
		articleList = dbPro.getArticles(searchWhat, searchText, startRow, endRow );
	}
}

number = count - (currentPage - 1) * pageSize;
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>맛집리뷰 게시판 1</title>
<!-- 부트스트랩 css 사용 -->
<!--  <link rel="stylesheet" href="../bootstrap/css/bootstrap.css"> -->
<!--  부트스트랩 js 사용 -->
<!--  <script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script> -->


<script type="text/javascript" src="script.js"></script>
<style type="text/css">

@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);


a{text-decoration:none}
*{font-family: 'Nanum Gothic', sans-serif;}
#header
{
	margin:0 auto; 
	width : 1500px;
	height:150px;
	border-bottom: 1px solid;
	border-color: #81BEF7;
	font-family: 'Nanum Gothic', sans-serif;
}


#nav
{
	position:relative;
	z-index:2;
	margin:0 auto; 
	width : 1500px;
	height: 100px;
	border-bottom: 1px solid;
	border-color: #81BEF7;
	text-align: center;
	font-family: 'Nanum Gothic', sans-serif;
	
} 
#nav *
{
	margin: 0;
	padding: 0;
}


#section
{
	margin:0 auto; 
	position:relative;
	z-index:1;
	width : 1500px;
	height: 1000px;
	border-color: #81BEF7;
	font-family: 'Nanum Gothic', sans-serif;
}

#footer
{
	margin:0 auto; 
	width : 1500px;
	height:200px;
	border-top: 1px solid;
	border-bottom: 1px solid;
	border-color: #81BEF7;
	text-align: center;
	font-family: 'Nanum Gothic', sans-serif;
}

#footer > div > span
{
	 
	padding : 20px;
	margin: 40px;
}


#footer > div > h6
{
	
	line-height: 1px;
	text-align: left;
	margin-left: 40%;
}

/*메뉴바*/
ul li{
		list-style: none;
	}
	
#menu {
		font:bold 16px 'Nanum Gothic', sans-serif;;
		width:1000px;
		height:50px;
		color:#81BEF7;
		line-height: 50px; 
		margin:0 auto;
		text-align: center;
		font-size: 16pt;
	}
#menu > ul > li {
		float:left;
		width:200px;
		position:relative;
		margin: 20px;
}
#menu > ul > li:hover {
	background: #81BEF7;
	transition: ease 1s;
}

#menu > ul > li > ul {
	width:200px;
	display:none;
	position: absolute;
	font-size:14px;
	background: #F2F2F2;
	border: 1px solid;
	
}
#menu > ul > li:hover > ul {
	display:block;
		
}
#menu > ul > li > ul > li:hover {
	background: #81BEF7;
	transition: ease 1s;
	}



	ul li{
		list-style: none;
	}


/* 헤더 인풋*/

#mlan
{
	width : 150px;
	height: 40px;
	border: 1px solid;
	border-color: #81BEF7;
}

#mserchbox
{
	width: 200px;
	height: 35px;
	border: 1px solid;
	border-color: #81BEF7;
}

#mserchbt
{
	width : 50px;
	height: 40px;
	background-color: #81BEF7; 
	border: 1px solid;
	border-color: #81BEF7;
}

#mserchlist
{
	width : 100px;
	height: 40px;
	border: 1px solid;
	border-color: #81BEF7;
}



.text
{
	
	font-size: 6px;

}

#list tr:hover
{
	background-color:#E6E6E6;
	transition: ease 0.2s;
}

#searchText:hover
{
	background-color:#E6E6E6;
	transition: ease 0.2s;
}

#searchText:focus
{
	background-color:#E6E6E6;
	transition: ease 0.2s;
	outline: 1px solid #81BEF7;
}

</style>


</head>
<body link="black" vlink="black">


<!-- 위 -->
<div id="header">
<br>
	<div style="text-align : right; width:60%; float:left" >
		<a href="../Main/MainScreen.jsp"><img alt="" src="../Main/images/MainLogo.png"></a>
	</div>
	
	<div style="text-align: right; margin-left: 60% ">
		<form action="" style="margin-right: 5%">
			<select id="mlan" name="laguage" style="text-align: center;">
			<option value="ko">한국어</option> 
			<option value="jp">일본어</option>
			</select>
			<br><br>
			<select id="mserchlist" name="m_searchWhat" style="text-align: center;">
			<option value="header">역이름</option> 
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
			</select>
			<input id="mserchbox" type="text" name="m_serch">
			<input id="mserchbt" type="submit" value="검색" style="font-weight : bold ;">
		</form>
	</div>
	
</div>


<!-- 메뉴바 -->
<div id="nav">
	<div id="menu">
		<ul>
			<li><a href="../i_board/i_boardList.jsp">공지사항</a>
			</li>
			<li><a href="../f_board/f_boardList.jsp">자유게시판</a>
			</li>
			<li><a href="../r_board/r_boardList.jsp">맛집리뷰 게시판</a>
				<ul>
					<li><a href="../r_board/r1_boardList.jsp">2호선 (1)</a></li>
					<li><a href="../r_board/r2_boardList.jsp">2호선 (2)</a></li>
					<li><a href="../r_board/r3_boardList.jsp">2호선 (3)</a></li>
					<li><a href="../r_board/r4_boardList.jsp">2호선 (4)</a></li>
				</ul>
			</li>
			<li><a href="#">회원 메뉴</a>
				<ul>
				<% if(loginID == null) { // 로그인이 안되면 %>
					<li><a href="../member/login.jsp">로그인</a></li>
				<%}else {%>
					<li><a href="../member/logout.jsp">로그아웃</a></li>
				<%} %>
				<% if(loginID == null) { // 로그인이 안되면 %>
					<li><a href="../member/login.jsp">마이페이지</a></li>
				<%}else {%>
					<li><a href="../member/mypage.jsp">마이페이지</a></li>
				<%} %>
					
				</ul>
			</li>
		
		</ul>
	</div>

</div>

<!-- 메인부분 -->
<% if(loginID == null) { // 로그인이 안되면 url로 강제이동%>
	<script type="text/javascript">
		var url = "../member/login.jsp"
		//뒤로가기 가능
		window.location.href=url;
		
		//뒤로가기 불가
		/* window.replace.href=url; */ 
	</script>


<%}else{ //로그인상태면 세션내용 표시 %> 
<div id="section">
<br><br>
<div align="left" style="margin-left: 10%">
<b style="font-size: 25pt; color: #81BEF7;">맛집리뷰 - 2호선 (2) : 신설동 ~ 종합운동장</b>
</div>
<br>
<div align="right">
<form action="r2_boardList.jsp" name="searchHeaderForm" align="right" onsubmit="return checkSearchHeader()">
	<select name="searchText" style="position: absolute; left: 74%; width:300px; height:35px; border-color:#81BEF7; border-radius: 5px;">
		<option value="" align="center">----------------역 검색-----------------</option>
		<option align="center">신설동</option>
		<option align="center">용두</option>
		<option align="center">신답</option>
		<option align="center">용답</option>
		<option align="center">성수</option>
		<option align="center">건대입구</option>
		<option align="center">구의</option>
		<option align="center">강변</option>
		<option align="center">잠실나루</option>
		<option align="center">잠실</option>
		<option align="center">잠실새내</option>
		<option align="center">종합운동장</option>

	</select>
	 <input type="hidden" name="searchWhat" value="mr_header">
	 <input type="submit" value="검색" style="width:70px; height: 35px; border-color:#81BEF7; background-color:#CEE3F6; font-size: 12pt; font-weight: bold; border-radius: 5px;">
</form>
</div><br><br>
<%
if(count == 0) { // 저장된 글이 없을 경우
%>
<table width="1200" border="0" cellpadding="0" cellspacing="0">
 <tr align="center">
  <td><div style="text-align: center; margin-left: 25%;"><a style="font-weight: bold; font-size: 14pt; ">게시판에 저장된 글이 없습니다.</a></div></td>
 </tr>
</table>
<%} else{ // 글이 있을 경우 %>
<!-- 항목명만출력 -->
<hr color="#81BEF7">
<table width="1270" border="0" cellpadding="0" cellspacing="0" align="center">
 <tr height="30" bgcolor="" >
  <td align="center" width="70" style="font-weight: bold;">번호</td>
  <td align="center" width="120" style="font-weight: bold;">역이름</td>
  <td align="center" width="550" style="font-weight: bold;">제목</td>
  <td align="center" width="100" style="font-weight: bold;">작성자</td>
  <td align="center" width="130" style="font-weight: bold;">작성일</td>
  <td align="center" width="50" style="font-weight: bold;">조회수</td>
  <td align="center" width="50" style="font-weight: bold;">추천수</td>
 </tr>
</table>
<hr color="#81BEF7">
<!-- 내용리스트 -->
<table id="list" width="1270" border="0" cellpadding="0" cellspacing="0" align="center">
 <% for(int i = 0; i < articleList.size(); i++) {
	 R_BoardVO article = (R_BoardVO)articleList.get(i);
	 if(article.getMr_bcheck() == 20){
 %>
 <tr height="30">
  <td align="center" width="70" style=" border-bottom: 1px dashed #E6E6E6; font-weight: bold;"><a><%=number-- %></a></td>
  <td align="center" width="120" style=" border-bottom: 1px dashed #E6E6E6; font-weight: bold;"><%=article.getMr_header() %></td>
  <td width="550" style=" border-bottom: 1px dashed #E6E6E6;">
  <%
   int wid = 0;
  %>
   <img src="../img/level.gif" width="<%=wid %>" height="16">
   <a href="r_boardContent.jsp?mr_num=<%= article.getMr_num()%>&pageNum=<%=currentPage%>" style="margin-left: 15%">
    <%=article.getMr_subject() %></a> 
    <%if(article.getMr_readcount() >= 20) { %>
    <img alt="" src="img/hot.gif" border="0" height="16">
    <%} %>
    <td align="center" width="100" style=" border-bottom: 1px dashed #E6E6E6;"><a><%=article.getMr_writer() %></a></td>
  <td align="center" width="130" style=" border-bottom: 1px dashed #E6E6E6; "><a><%=sdf.format(article.getMr_postdate()) %></a></td>
  <td align="center" width="50" style=" border-bottom: 1px dashed #E6E6E6; "><a><%=article.getMr_readcount() %></a></td>
  <td align="center" width="50" style=" border-bottom: 1px dashed #E6E6E6; "><a><%=article.getMr_up() %></a></td>
 </tr>
 <%} 
 	}%>
</table>

<%} %>
<hr color="#81BEF7">
<!-- 페이징 처리 -->
<br>
<div align="center">	
<%
if(count > 0) {
	 
	int pageBlock = 10;
	
	int imsi = count % pageSize == 0 ? 0 : 1;
	
	int pageCount = count/pageSize + imsi;
	
	int startPage = (int)((currentPage - 1) / pageBlock) * pageBlock + 1;
	int endPage = startPage + pageBlock - 1;
	
	if(endPage > pageCount) endPage = pageCount;
	
	if(startPage > pageBlock) {
		
		// 검색일 경우와 아닐 경우 페이지 처리
				if(searchText == null && searchHeader == null) {
			%>
			<a href="r2_boardList.jsp?pageNum=<%= startPage-pageBlock %>">[이전]</a>
			<% }else if(searchText == null){  %>
				<a href="r2_boardList.jsp?pageNum=<%= startPage-pageBlock %>&searchHeader=<%=searchHeader%>">[이전]</a>
			<%
			}else {	
			%>
			<a href="r2_boardList.jsp?pageNum=<%= startPage-pageBlock %>&searchWhat=<%=searchWhat%>&searchText=<%=searchText%>">[이전]</a>
			<% 
				}
			}	
			
			for(int i = startPage; i <= endPage; i++){
				if(searchText == null && searchWhat == null){
			%>
			<a href="r2_boardList.jsp?pageNum=<%=i%>">[<%=i %>]</a>
			<% }else if(searchText == null){ %>
			<a href="r2_boardList.jsp?pageNum=<%=i%>&searchHeader=<%=searchHeader%>">[<%=i %>]</a>
			<%
				}else {
			%>		
			<a href="r2_boardList.jsp?pageNum=<%=i%>&searchWhat=<%=searchWhat%>&searchText=<%=searchText%>">[<%=i %>]</a>
			<% 	
				}
			}
			
			if(endPage < pageCount){
				if(searchText == null && searchWhat == null){
			%>
			<a href="r2_boardList.jsp?pageNum=<%= startPage+pageBlock %>">[다음]</a>
			<% }else if(searchText == null){ %>
			<a href="r2_boardList.jsp?pageNum=<%= startPage+pageBlock %>&searchHeader=<%=searchHeader%>">[다음]</a>
				<%} else { %>
			<a href="r2_boardList.jsp?pageNum=<%= startPage+pageBlock %>&searchWhat=<%=searchWhat%>&searchText=<%=searchText%>">[다음]</a>
			<%
			}
			 }
		}


			%>
	<input type="button" style="position:absolute; left:5%; width:85px; height:40px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-size:12pt; font-weight: bold; cursor: pointer;" 
						onclick="location.href='r2_boardList.jsp'" value="목록">
	<input type="button" style="position:absolute; right:5%; width:85px; height:40px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-size:12pt; font-weight: bold; cursor: pointer;" 
						onclick="location.href='r_boardWriteForm.jsp'" value="글쓰기">
<br><br><br>
<form action="r2_boardList.jsp" onsubmit="return search()" name="searchForm" >
 <select name="searchWhat" style="width: 100px; height: 35px; border-color:#81BEF7; border-radius: 5px;"> 
  <option value="mr_writer">작성자</option>
  <option value="mr_subject">제목</option>
  <option value="mr_content">내용</option>
  <option value="mr_header">말머리</option> 
 </select>
 &nbsp;&nbsp;
 <input id="searchText" type="text" name="searchText" style="width: 300px; height: 30px; border-color:#81BEF7; border-radius: 5px;">
 &nbsp;&nbsp;
 <input type="submit" value="검색" style="width:70px; height: 35px; border-color:#81BEF7; background-color:#CEE3F6; font-size: 12pt; font-weight: bold; border-radius: 5px;">
</form>
</div>
</div>

 
 <%} %>

    


<!-- 하단 -->
<div id="footer">
<br><br>
	<div>
		<span ><a href="../pages/howto.jsp" style="color:black; font-weight: bold; font-family: 15pt;">페이지 이용방법</a></span>
		<span><a style="color:black; font-weight: bold;">고객문의</a></span>
		<span><a href="../pages/agreement.jsp" style="color:#black; font-weight: bold; font-family: 15pt;">이용약관</a></span>
		<span><a href="../pages/personal.jsp" style="color:#black; font-weight: bold; font-family: 15pt;">개인정보 처리방침</a></span>
		</div>
		<br>
		<div>
			<h6 style="color:#black; font-weight: bold; font-size: 10pt;">상호명 : ㈜ 맛집 노선도</h6>
			<h6 style="color:#black; font-weight: bold; font-size: 10pt;">주소 : 서울시 영등포구 영중로 56 신한빌딩 4, 5층 주식회사 글로벌인</h6>
			<h6 style="color:#black; font-weight: bold; font-size: 10pt;">Email : matjibcs@gmail.com</h6>
	</div>
	 
	
</div>

</body>

</html>