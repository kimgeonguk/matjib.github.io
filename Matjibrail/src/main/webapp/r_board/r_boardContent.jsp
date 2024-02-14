<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.R_BoardVO" %>
<%@ page import="board.R_BoardDAO" %>
<%@ page import="board.CommentDAO" %>
<%@ page import="board.CommentVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="view/color.jsp" %>
<%@ page import="java.io.File" %>
<jsp:useBean id="recommend" class="board.RecommendDAO" />
<jsp:useBean id="vo" class="board.RecommendVO" />
<jsp:setProperty property="*" name="vo"/>

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
String loginID = (String)session.getAttribute("loginID");
request.setCharacterEncoding("UTF-8");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>글 상세 - 자유게시판</title>


<script src="http://code.jquery.com/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.subwayMap-0.5.3.js" type="text/javascript"></script>

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
	height: 1200px;
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
	text-align: bold;
}

#m_searchBoard
{
	width : 150px;
	height: 40px;
	border: 1px solid;
	border-color: #81BEF7;
}


#m_searchWhat
{
	width : 15 	0px;
	height: 40px;
	border: 1px solid;
	border-color: #81BEF7;
}

.text
{
	
	font-size: 6px;

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
	<div align="right">
		<select id="mlan" name="laguage" style="text-align: center;">
			<option value="ko">한국어</option> 
			<option value="jp">일본어</option>
		</select>
	</div>
	<br><br>
	<div style="text-align: right; margin-left: 60% ">
	<form action="MainBoardList.jsp" id="searchForm" name="searchForm" align="right" onsubmit="return search()" method="post">
	<select id="m_searchBoard" name="m_searchBoard" onchange="searchChoice(this)" value="<%=getParam(request, "m_searchBoard")%>" style="text-align: center;">	
		<option value="">--- 게시판 선택 ---</option> 
		<option value="i_board">공지사항</option> 
		<option value="f_board">자유게시판</option>
		<option value="r_board">맛집리뷰</option>
	</select>

	<select name="m_searchWhat" id="m_searchWhat" value='<%=getParam(request, "m_searchWhat")%>'>
			<option value="" align="center" selected="selected">-- 조건 선택 --</option>
			<option value="writer" align="center">작성자</option>
			<option value="subject" align="center">제목</option>
			<option value="content" align="center">내용</option>
			<option value="header" align="center">역이름(리뷰)</option>
	</select>	
 <input id="mserchbox" type="text" name="mserchbox"  placeholder="통합 검색">
 <input id="mserchbt" type="submit" value="검색">
</form>
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
<%
request.setCharacterEncoding("utf-8");

int mr_num = Integer.parseInt(request.getParameter("mr_num"));
String pageNum = request.getParameter("pageNum");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   R_BoardDAO dao = new R_BoardDAO();   
   int Recommend= dao.Recommend(mr_num); 

try{
	R_BoardVO article = new R_BoardVO();
	R_BoardDAO dbPro = R_BoardDAO.getInstance();
	
	article = dbPro.getArticle(mr_num);
%>
		
<div id="section">
	<br><br>
	<div align="left" style="margin-left: 10%">
	<b style="font-size: 25pt; color: #81BEF7;">맛집리뷰 - 2호선</b>
	</div>
	<br><br><br>

	<div align="center">
	<form action="">
		<table width="1300" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" width="50" style="text-align: left; font-size: 15pt; font-weight: bold;"><a style=" margin-left: 20%">No. <%=article.getMr_num() %></a></td>
				<td colspan="4" align="center" width="1220" style="font-size: 15pt; font-weight: bold"><%=article.getMr_subject() %></td>
			</tr>
			<tr height="20"><td colspan="8" width="1300" style=" border-bottom: 1px solid #81BEF7;"></td></tr>
			
			<tr height="30">
				<td width="80" style="text-align: center;"><a style="font-weight: bold;">작성자</a></td>
				<td align="center" width="120" style="margin-left: 10%; text-align: left;"  > <a style="margin-left: 20%;"><%=article.getMr_writer() %></a></td>
				<td width="80" style="text-align: right;"><a style="font-weight: bold;">작성일</a></td>
				<td colspan="2" align="center" width="250"><a style="margin-left: 20%; text-align: left;"><%=sdf.format(article.getMr_postdate()) %></a></td>
				<td width = "710" ></td>
				<td align="center" width="50" ><a style="font-weight: bold;">조회</a></td>
				<td align="center" width="50" ><%=article.getMr_readcount() %></td>
				
			</tr>
			
			<tr height="30"><td colspan="8" width="1300" style=" border-top: 1px solid #81BEF7;"></tr>
				
				<td width="50"></td>
				<td colspan="6" width="1200" height="200" valign="top">
					<div>
					<%
					if(article.getMr_image() != null){
						
						String [] imgArr = article.getMr_image().split(",");

						for(int i = 0; i < imgArr.length; i++){
							article.setMr_image(imgArr[i]);
					
					%>
						<img src="image/<%=article.getMr_image() %>" width="200" onError="this.style.visibility='hidden'"><br>
						
						<%} 
						
						}else{ %>
						<img alt="사진없음" src="isolidmage/chiwawa.jpg" width="200" ><br>
							
						<%} %>
					</div><br>
				
	
					<%=article.getMr_content() %>
					
					
				</td>
				<td width="50"></td>
			</tr>
			<tr height="30"><td colspan="8" width="1300" style=" border-top: 1px solid #81BEF7;"></tr>

		</table>
		
					<input type="button" value="글쓰기" style="position:absolute; right:20%; width:70px; height:30px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-size:10pt; font-weight: bold; cursor: pointer;" 
							onClick="document.location.href='r_boardWriteForm.jsp'">
					&nbsp;&nbsp;&nbsp;&nbsp;
					
					<input type="button" value="수정" style="position:absolute; right:15%; width:70px; height:30px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-size:10pt; font-weight: bold; cursor: pointer;"
							onClick="document.location.href='r_boardUpdateForm.jsp?mr_num=<%=article.getMr_num()%>&pageNum=<%=pageNum%>'">
					&nbsp;&nbsp;&nbsp;&nbsp;
					
					<input type="button" value="삭제" style="position:absolute; right:10%; width:70px; height:30px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-size:10pt; font-weight: bold; cursor: pointer;"
							onClick="document.location.href='r_boardDeleteProc.jsp?mr_num=<%=article.getMr_num()%>&pageNum=<%=pageNum%>'">
					&nbsp;&nbsp;&nbsp;&nbsp;

					<input type="button" value="목록" style="position:absolute; right:5%; width:70px; height:30px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-size:10pt; font-weight: bold; cursor: pointer;"
							onClick="document.location.href='r_boardList.jsp?pageNum=<%=pageNum%>'">
</form>
<%

String num = request.getParameter("mr_num");	


int check = recommend.recommendCheck(Integer.parseInt(num), loginID);

%>
  <% if(check!=1) { %>
<form action="r_recommand2.jsp">
<table>
         <tr>
            <td><a style="font-weight: bold; font-size: 13pt;">추천수</a></td>
            <td><a style="font-weight: bold; font-size: 13pt;"><%= Recommend%></a>   </td>
         </tr>
         <tr height="30"></tr>
         <tr>
         <td colspan="2"><input type="button" name="mr_recommand" value="추천!" style="width: 100px; height: 50px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-size:10pt; font-weight: bold; cursor: pointer;" 
         		onclick="document.location.href='r_recommand.jsp?mr_num=<%=article.getMr_num()%>&pageNum=<%=pageNum%>'"> 
            </td>
         </tr>
         
         <%}else{%>
         <table>
          <tr>
            <td><a style="font-weight: bold; font-size: 13pt;">추천수</a></td>
            <td><a style="font-weight: bold; font-size: 13pt;"><%= Recommend%></a>   </td>
         </tr>
         <tr height="30"></tr>
         <tr>
            <td colspan="2"><input type="button" name="mr_recommand" value="추천취소!" style="width: 100px; height: 50px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-size:10pt; font-weight: bold; cursor: pointer;" 
            	onclick="document.location.href='r_recommand2.jsp?mr_num=<%=article.getMr_num()%>&pageNum=<%=pageNum%>'"> 
            </td>
         </tr>
         <% }%>	
</table>
</form> 
</div>
	<%
	}catch(Exception e){}
%>

<%

// 한 페이지에 보여줄 목록 수 지정
int pageSize = 5;


String searchWhat = request.getParameter("searchWhat");
// writer, subject, content
String searchText = request.getParameter("searchText");
// 검색할 내용

if(searchText != null) {
   searchText = new String(searchText.getBytes("utf-8"), "utf-8");
}


if(pageNum == null) {
   pageNum = "1";
}

// 현재 페이지
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage -1) * pageSize +1;
int endRow = currentPage * pageSize;

int count = 0;
int number = 0;

List<CommentVO> articleList = null;
CommentDAO dbPro = CommentDAO.getInstance();
count = dbPro.getArticleCount(mr_num);   // 전체 글 수

// 검색이 아니면 전체 리스트를 보여주고 검색이면 검색한 내ㅑ용만 보여줌

if(searchText == null) {
   count = dbPro.getArticleCount(mr_num);   // 전체 글수
   
   if(count > 0) {
      
      articleList = dbPro.getArticles(startRow, endRow, mr_num);
   }
}else {
   
   count = dbPro.getArticleCount(searchWhat, searchText);   // 전체 글수
   
   if(count > 0) {
      articleList = dbPro.getArticles(searchWhat, searchText, startRow, endRow);
   }
    number = count -(currentPage -1) * pageSize; 
}

%>
<br><br>
<div align="left" style="margin-left: 5%"><b>전체 댓글 : <%=count %>개</b>
<br><br>
<%
   if(count == 0) {   // 글이 없을 경우
%>
<table width="1200" border="0" cellpadding="0" cellspacing="0">
   <tr align="center">
      <td style="text-align: center;"><a style="font-weight: bold; font-style: 14pt;">저장된 댓글이 없습니다.</a></td>
   </tr>
</table>
<%   }else {   // 글이 있을 경우 %>
<table width="1200" border="0" cellpadding="0" cellspacing="0" align="center">
   <tr height="30">	
      <td align="center" width="50" style="font-weight: bold; border-bottom: 1px solid #81BEF7;">번호</td>
      <td align="center" width="100" style="font-weight: bold; border-bottom: 1px solid #81BEF7;">작성자</td>
      <td align="center" width="800" style="font-weight: bold; border-bottom: 1px solid #81BEF7;">내용</td>
      <td align="center" width="100" style="font-weight: bold; border-bottom: 1px solid #81BEF7;">작성일</td>
      <td align="center" width="40" style="font-weight: bold; border-bottom: 1px sollid #81BEF7;"></td>
   </tr>

   <%

   
    for(int i = 0; i < articleList.size(); i++) {
	   CommentVO article = (CommentVO)articleList.get(i);  
   %>
   <tr height="30">
      <td align="center" width="50"><%=(number++)+1 %></td>
       <td align="center" width="100">
             <%=article.getWriter() %>
 
      </td>
      <td width="250" >
         <%
            int wid = 0;
            
            if(article.getDepth() > 0) {
               wid = 5 * (article.getDepth());
         %>
         <img src="../img/level.gif" width="<%=wid%>" height="16">
         <img src="../img/re.gif">
         <%
            }else {
         %>
         <img src="../img/level.gif" width="<%=wid%>" height="16">
         <%
            }
         %>
           <a style="margin-left: 10%"><%=article.getContent() %></a>
            
            
         <% if(article.getReadcount() >= 20) { %>
         
         <img src="../img/hot.gif" border="0" height="16">
         <%} %>
      </td>
     
      <td align="center" width="150">
         <%=sdf.format(article.getRegdate()) %>
      </td>
  
  	 <td align="center" colspan="5"><input type="submit"
	value="댓글삭제 "
	onClick="document.location.href='commentDeleteProc.jsp?mr_num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
	</td> 
	
         
      
      
   </tr>
	 <tr>
	<td colspan="5" width="1200" style="border-bottom: 1px dashed #81BEF7;">
	</tr>
   <%} %>
	
 
  
   
</table>
<%   } %>
</div>

<!-- 페이징 처리 -->
<div align="center">
<%
if(count > 0) {
   int pageBlock = 10;
   int imsi = count % pageSize == 0 ? 0 : 1;
   int pageCount = count/pageSize + imsi;
   
   int startPage = (int)((currentPage -1) / pageBlock) * pageBlock + 1;
   int endPage = startPage + pageBlock -1;
   
   if(endPage > pageCount) endPage = pageCount;
   
   if(startPage > pageBlock) {
      
      // 검색일 경우와 아닐 경우 페이지 처리
      if(searchText == null) {
%>
      <a href="r_boardContent.jsp?mr_num=<%=mr_num %>&pageNum=<%=startPage-pageBlock%>">[이전]</a>
      <%
      }else {
      %>
      <a href="r_boardContent.jsp?mr_num=<%=mr_num %>&pageNum=<%=startPage-pageBlock%>&searchWhat=<%=searchWhat%>&searchText=<%=searchText%>"></a>
<%
      }
   }
   for(int i = startPage; i <= endPage; i++) {
      if(searchText == null) {
%>   
<a href="r_boardContent.jsp?mr_num=<%=mr_num %>&pageNum=<%=i%>">[<%=i%>]</a>
<%   }else { %>
   <a href="r_boardContent.jsp?mr_num=<%=mr_num %>&pageNum=<%=i%>&searchWhat=<%=searchWhat%>&searchText=<%=searchText%>"></a>
<% }
   }
   if(endPage < pageCount) {
      if(searchText == null) {
%>
<a href="r_boardContent.jsp?mr_num=<%=mr_num %>&pageNum=<%=startPage+pageBlock%>">[다음]</a>
<%}else { %>
   <a href="r_boardContent.jsp?mr_num=<%=mr_num %>&pageNum=<%=startPage+pageBlock%>&searchWhat=<%=searchWhat%>&searchText=<%=searchText%>"></a>

<%   }
} 

   if(endPage < pageCount) {
      %>
      <a href="r_boardContent.jsp?mr_num=<%=mr_num %>&pageNum=<%=startPage+pageBlock%>">[다음]</a>
<%} 
}%>

 <!-- 새글과 답변글을 구분하는 코드 작성 -->
<%


	try{
	int num = 0, ref=1, step=0, depth=0;
	
	
		if(request.getParameter("num")!=null){
		
			num = Integer.parseInt(request.getParameter("num"));
			ref = Integer.parseInt(request.getParameter("ref"));
			step = Integer.parseInt(request.getParameter("step"));
			depth = Integer.parseInt(request.getParameter("depth"));
		}
	
%> 
</div>
<br><br><br>
<!-- 댓글 내용입력부 -->
<div class="container" align="center">
	<div class="form-group">
		<form method="post" action="commentproc.jsp" >
		
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="ref" value="<%=ref%>">
			<input type="hidden" name="step" value="<%=step%>">
			<input type="hidden" name="depth" value="<%=depth%>">
			<table class="table table-striped" width="1100" style="text-align: center; border: 0px solid #dddddd" >
	
				<tr>
					<td><input type="hidden" name="writer" value="<%=loginID%>"></td> <!-- 글쓴이 -->
					<td><input type="hidden" name="email" value="123@naver.com"></td><!-- 이메일 -->
					<td><input type="hidden" name="subject" value="12345"></td> <!-- 제목 -->
                    <td><input type="hidden" name="pass" value="12345"></td> <!-- 비번 -->
                    <td><input type="hidden" name="c_num" value="<%=mr_num%>"></td> <!-- 게시번호 -->
                    
				</tr>
				<tr>
					<td style="border-bottom:none;" width="100" valign="middle" ><a style="font-weight: bold; font-size: 15pt;"><%= loginID %></a></td>
					<td><input type="text"  style="height:100px; width: 800px; border:1px solid; border-color:#81BEF7; border-radius: 5px; " class="form-control" placeholder="댓글 내용을 입력해주세요." name = "content"></td>
					<td><input type="submit" class="btn-primary pull" value="작성" style="width: 100px; height: 100px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-size:10pt; font-weight: bold; cursor: pointer;"></td>
				</tr>

			</table>
		</form>
	</div>
</div>
	


	<%
	}catch(Exception e){}
%>
	
	 
	 
	 
	 
</div>

 
<%} %>
 
 

    


<!-- 하단 -->
<div id="footer">
<br>
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