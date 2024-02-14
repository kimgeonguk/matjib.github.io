<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="popup.PopupVO" %>
<%@page import="popup.PopupDAO" %>
<%@page import="board.R_BoardVO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String loginID = (String)session.getAttribute("loginID");
request.setCharacterEncoding("UTF-8");
String stname = request.getParameter("stname");

List<R_BoardVO> articleList = null;
PopupDAO dao = new PopupDAO();
articleList = dao.getArticles(stname);

int count = 0;
count = dao.getPopArticleCount(stname); // 해당 역 글 수
%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>메인페이지</title>
<!-- 부트스트랩 css 사용 -->
<!--  <link rel="stylesheet" href="../bootstrap/css/bootstrap.css"> -->
<!--  부트스트랩 js 사용 -->
<!--  <script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script> -->

<script src="http://code.jquery.com/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.subwayMap-0.5.3.js" type="text/javascript"></script>

<style type="text/css">

@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

#map_ma {width:500px; height:350px; clear:both; border:solid 1px #81BEF7;}
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
	background-color:#E0ECF8;
	transition: ease 0.2s;
}




</style>


</head>
<body link="black" vlink="black">
<!-- 위 -->
<div id="header">
<br>
	<div style="text-align : right; width:60%; float:left" >
		<a href="../MainScreen.jsp"><img alt="" src="../images/MainLogo.png"></a>
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
			<li><a href="../../i_board/i_boardList.jsp">공지사항</a>
			</li>
			<li><a href="../../f_board/f_boardList.jsp">자유게시판</a>
			</li>
			<li><a href="../../r_board/r_boardList.jsp">맛집리뷰 게시판</a>
				<ul>
					<li><a href="../../r_board/r1_boardList.jsp">2호선 (1)</a></li>
					<li><a href="../../r_board/r2_boardList.jsp">2호선 (2)</a></li>
					<li><a href="../../r_board/r3_boardList.jsp">2호선 (3)</a></li>
					<li><a href="../../r_board/r4_boardList.jsp">2호선 (4)</a></li>
				</ul>
			</li>
			<li><a href="#">회원 메뉴</a>
				<ul>
				<% if(loginID == null) { // 로그인이 안되면 %>
					<li><a href="../../member/login.jsp">로그인</a></li>
				<%}else {%>
					<li><a href="../../member/logout.jsp">로그아웃</a></li>
				<%} %>
				<% if(loginID == null) { // 로그인이 안되면 %>
					<li><a href="../../member/login.jsp">마이페이지</a></li>
				<%}else {%>
					<li><a href="../../member/mypage.jsp">마이페이지</a></li>
				<%} %>
					
				</ul>
			</li>
		
		</ul>
	</div>

</div>

<!-- 메인부분 -->
<div id="section" align="center">
<br><br>

	<table style="border: 1px solid; border-color: #81BEF7;">
		<tr>
			<td width="400px" height="80px" align="center" bgcolor="#CEE3F6" style="font-size: 27px; font-weight: bold;"><a href="Popupsta.jsp?stname=<%=stname%>">역 정보</a></td>
			<td width="400px" height="80px" align="center" bgcolor="#CEE3F6" style="font-size: 27px; font-weight: bold;"><a href="Popupres.jsp?stname=<%=stname%>">맛집 정보</a></td>
		</tr>
		
		<%
			if(count == 0) { // 해당역 글이 없으면
		%>
		
			<tr>
			
			  <td colspan="2" align="center"><div><a style="font-weight: bold; font-size: 14pt; "><br>해당 역의 맛집정보가 없습니다. 정보를 등록해주세요!<br><br></a></div></td>
			  
		    </tr>
		</table>
			
		<%
			}else {
		%>
		<tr>
			<td colspan="2" align="center">
				<h1><a style="color: #81BEF7; "><%=stname %></a>역 맛집 정보</h1>
				<hr width="700" align="center" color="#81BEF7" >
				<table border="0" style=" width: 700px;">
					<tr>
						<td width="100px" align="center"><a style="font-weight: bold">랭킹</a></td>
						<td width="120px" align="center"><a style="font-weight: bold">사진</a></td>
						<td width="400px" align="center"><a style="font-weight: bold">제목</a></td>
						<td width="80px" align="center"><a style="font-weight: bold">추천수</a></td>
					</tr>
				</table>
			<hr width="700" align="center" color="#81BEF7" >
		<% for(int i=0; i<articleList.size(); i++) { 
			R_BoardVO article = (R_BoardVO)articleList.get(i);
		
		%>
				<table id="list" border="0" style=" width: 700px;">	
					<tr>
						<td width="100px" height="100px" align="center" style=" border-bottom: 1px dashed #81BEF7;">
							<%if(i==0){ %>
								<a style="font-size: 35pt; font-weight: bold; color: #FFBF00"><%=i+1%></a>
							<%}else if(i==1) {%>
								<a style="font-size: 28pt; font-weight: bold; color: #BDBDBD"><%=i+1%></a>
							<%}else if(i==2) {%>
								<a style="font-size: 28pt; font-weight: bold; color: #8A4B08"><%=i+1%></a>
							<%}else {%>
								<a style="font-size: 15pt; font-weight: bold;"><%=i+1%></a>
							<%} %>
						
						</td>
						<td width="120px" align="center" style=" border-bottom: 1px dashed #81BEF7;">
							
						<% 	if(!article.getMr_image().equals("")){
						
						String [] imgArr = article.getMr_image().split(",");

						
							article.setMr_image(imgArr[0]);
						}
							%>
							<img src="../../r_board/image/<%=article.getMr_image() %>" width="120px" onError="this.style.visibility='hidden'"><br>
							
						</td>
						<td width="400px" align="center" style=" border-bottom: 1px dashed #81BEF7;">
							<%if(i<3){ %>
							<a href="../../r_board/r_boardContent.jsp?mr_num=<%= article.getMr_num()%>&pageNum=<%=1%>" style="font-size: 15pt; font-weight: bold;"><%=article.getMr_subject() %></a>
							<%}else { %>
							<a href="../../r_board/r_boardContent.jsp?mr_num=<%= article.getMr_num()%>&pageNum=<%=1%>" style="font-size: 12pt;"><%=article.getMr_subject() %></a>
							<%} %>
						</td>
						<td width="80px" align="center" style=" border-bottom: 1px dashed #81BEF7;">
						<%if(i<3){ %>
							<a style="font-weight: bold;"><%=article.getMr_up() %></a>
						<%}else { %>
							<a><%=article.getMr_up() %></a>
						<%} %>
						</td>
					</tr>
					
		  <%} %>
				
			
			</table>
				<hr width="700" align="center" color="#81BEF7" >
			<%} %>
				<br>
				<input type="button" style="width:250px; height:40px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-weight: bold; cursor: pointer;" 
					onclick="javascript:window.close()" value="창 닫기">
					<br>
					<br>	
					
			</td>
			
		</tr>
	</table>
	
</div>



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