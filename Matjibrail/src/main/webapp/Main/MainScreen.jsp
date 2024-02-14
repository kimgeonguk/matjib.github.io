<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="popup.PopupVO" %>
<%@page import="popup.PopupDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<title>메인페이지</title>
<!-- 부트스트랩 css 사용 -->
<!--  <link rel="stylesheet" href="../bootstrap/css/bootstrap.css"> -->
<!--  부트스트랩 js 사용 -->
<!--  <script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script> -->

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
	/* margin:0 auto; */
	position:relative;
	z-index:1;
	width : 1500px;
	height: 1100px;
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
		<a href="MainScreen.jsp"><img alt="" src="images/MainLogo.png"></a>
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
<div id="section">

	<!-- <div style="text-align: center;">
	<img alt="" src="images/rail2.png" width="1000px" height="600px">
	</div> -->
	
	 <div class="subway-map" data-columns="40" data-rows="20" data-cellSize="40" data-legendId="legend" data-textClass="text" data-gridNumbers="false" data-grid="false" data-lineWidth="5" >
        <ul data-color="#008000" data-label="jQuery Widgets">
           	<li data-coords="11,4"  data-labelpos="W" ><a href="./Popup/Popupsta.jsp?stname=신촌">신촌</a></li>     	
           	<li data-coords="13,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=이대">이대</a></li>
           	<li data-coords="15,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=아현">아현</a></li>
           	<li data-coords="17,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=충정로">충정로</a></li>
           	<li data-coords="19,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=시청">시청</a></li>
           	<li data-coords="21,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=을지로입구">을지로입구</a></li>
           	<li data-coords="23,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=을지로3가">을지로3가</a></li>
           	<li data-coords="25,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=을지로4가">을지로4가</a></li>
           	<li data-coords="27,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=동대문역사문화공원">동대문역사문화공원</a></li>
           	<li data-coords="29,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=신당">신당</a></li>
           	<li data-coords="31,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=상왕십리">상왕십리</a></li>
           	<li data-coords="33,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=왕십리">왕십리</a></li>
           	<li data-coords="35,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=한양대">한양대</a></li>
           	<li data-coords="37,4" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=뚝섬">뚝섬</a></li>
           	<li data-coords="39,4" data-labelpos="E"><a href="./Popup/Popupsta.jsp?stname=성수">성수</a></li>	
           	<li data-coords="39,6" data-labelpos="E"><a href="./Popup/Popupsta.jsp?stname=건대입구">건대입구</a></li>	
           	<li data-coords="39,8" data-labelpos="E"><a href="./Popup/Popupsta.jsp?stname=구의">구의</a></li>	
           	<li data-coords="39,10" data-labelpos="E"><a href="./Popup/Popupsta.jsp?stname=강변">강변</a></li>	
           	<li data-coords="39,12" data-labelpos="E"><a href="./Popup/Popupsta.jsp?stname=잠실나루">잠실나루</a></li>	
           	<li data-coords="39,14" data-labelpos="E"><a href="./Popup/Popupsta.jsp?stname=잠실">잠실</a></li>	
           	<li data-coords="39,16" data-labelpos="E"><a href="./Popup/Popupsta.jsp?stname=잠실새내">잠실새내</a></li>	
           	<li data-coords="39,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=종합운동장">종합운동장</a></li>	
           	<li data-coords="37,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=삼성">삼성</a></li>	
           	<li data-coords="35,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=선릉">선릉</a></li>	
           	<li data-coords="33,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=역삼">역삼</a></li>	
           	<li data-coords="31,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=강남">강남</a></li>	
           	<li data-coords="29,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=교대">교대</a></li>	
           	<li data-coords="27,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=서초">서초</a></li>	
           	<li data-coords="25,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=방배">방배</a></li>	
           	<li data-coords="23,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=사당">사당</a></li>	
           	<li data-coords="21,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=낙성대">낙성대</a></li>	
           	<li data-coords="19,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=서울대입구">서울대입구</a></li>	
           	<li data-coords="17,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=봉천">봉천</a></li>	
           	<li data-coords="15,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=신림">신림</a></li>	
           	<li data-coords="13,17" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=신대방">신대방</a></li>	
           	<li data-coords="11,17" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=구로디지털단지">구로디지털단지</a></li>	
           	<li data-coords="11,16" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=대림">대림</a></li>	
           	<li data-coords="11,15" data-labelpos="E"><a href="./Popup/Popupsta.jsp?stname=신도림">신도림</a></li>	
           	<li data-coords="11,14" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=문래">문래</a></li>	
           	<li data-coords="11,11" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=영등포구청">영등포구청</a></li>	
           	<li data-coords="11,9" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=당산">당산</a></li>	
           	<li data-coords="11,7" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=합정">합정</a></li>	
           	<li data-coords="11,5" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=홍대입구">홍대입구</a></li>	
           	<li data-coords="11,4" data-labelpos="W"><a href=""></a></li>	 	
        </ul>
        
        <ul data-color="#008000" data-label="jQuery Widgets" >
        	<li data-coords="39,4" data-labelpos="E"></li>	
        	<li data-coords="39,2" data-labelpos="E"><a href="./Popup/Popupsta.jsp?stname=용답">용답</a></li>	
        	<li data-coords="37,2" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=신답">신답</a></li>	
        	<li data-coords="35,2" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=용두">용두</a></li>	
        	<li data-coords="33,2" data-labelpos="S"><a href="./Popup/Popupsta.jsp?stname=신설동">신설동</a></li>	
        </ul>
        
         <ul data-color="#008000" data-label="jQuery Widgets" >
        	<li data-coords="11,15" data-labelpos="W"><a href=""></a></li>
        	<li data-coords="8,15" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=도림천">도림천</a></li>
        	<li data-coords="8,13" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=양천구청">양천구청</a></li>
        	<li data-coords="8,11" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=신정네거리">신정네거리</a></li>
        	<li data-coords="8,9" data-labelpos="W"><a href="./Popup/Popupsta.jsp?stname=까치산">까치산</a></li>
        </ul>
	
		<script type="text/javascript">
        $(".subway-map").subwayMap({ debug: true });
    	</script>
     </div>
   	
 <br><br>
  </div>
 
 

    


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