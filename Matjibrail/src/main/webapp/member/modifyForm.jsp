<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="popup.PopupVO" %>
<%@page import="popup.PopupDAO" %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ page import="member.*" %>
<jsp:useBean id="dao" class="member.MemberDAO" />

<%
request.setCharacterEncoding("UTF-8");
String loginID = (String)session.getAttribute("loginID");
MemberVO vo = dao.getMember(loginID);
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
<script type="text/javascript" src="./script.js"></script>


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
	height: 800px;
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
/*추가*/
#regForm *
{
	margin: 8px;
}

#section input:hover
{
	background: #E6E6E6;
	transition: ease 0.4s;
}

#section input:focus
{
	background: #E6E6E6;
	outline: 2px solid #81BEF7;
}

</style>


</head>
<body link="black" vlink="black">
<!-- 위 -->
<div id="header">
<br>
	<div style="text-align : right; width:60%; float:left" >
		<a href="../Main/MainScreen.jsp"><img alt="" src="images/MainLogo.png"></a>
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
			<li><a href="#">맛집리뷰 게시판</a>
				<ul>
					<li><a href="../r_board/r_boardList.jsp">2호선 (1)</a></li>
					<li><a href="../r_board/r_boardList.jsp">2호선 (2)</a></li>
					<li><a href="../r_board/r_boardList.jsp">2호선 (3)</a></li>
					<li><a href="../r_board/r_boardList.jsp">2호선 (4)</a></li>
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
		var url = "login.jsp"
		//뒤로가기 가능
		window.location.href=url;
		
		//뒤로가기 불가
		/* window.replace.href=url; */ 
	</script>
<%}else{ //로그인상태면 세션내용 표시 %> 
<div id="section">
<br><br><br>

	<div align="center">
	<b style="font-size: 35pt; font-weight: bold; color: #81BEF7">회원정보 수정</b>
	<br><br><br>
<form action="modifyProc.jsp" method="post" name="regForm" id="regForm">
<table>
	<tr>
		<td align="right" style="font-size: 13pt; font-weight: bold">아이디&nbsp;&nbsp; </td>
		<td>
			&nbsp;<%=vo.getId() %>&nbsp;
		</td>
	</tr>
	
	<tr>
		<td align="right" style="font-size: 13pt; font-weight: bold">비밀번호&nbsp;&nbsp; </td>
		<td>
			<input type="password" name="pass" value="<%=vo.getPass()%>" style="width: 200px; height: 22px; border: 1px soild; border-radius: 4px; border-color:#81BEF7"> 
		</td>
	</tr>
	<tr>
		<td align="right"  style="font-size: 13pt; font-weight: bold">비밀번호 확인&nbsp;&nbsp; </td>
		<td>
			<input type="password" name="repass" value="<%=vo.getPass()%>" style="width: 200px; height: 22px; border: 1px soild; border-radius: 4px; border-color:#81BEF7 ">
		</td>
	</tr>
	
	<tr>
		<td align="right" style="font-size: 13pt; font-weight: bold">이름&nbsp;&nbsp; </td>
		<td>
			&nbsp;<%=vo.getName() %>
		</td>
	</tr>
	<tr>
		<td align="right" style="font-size: 13pt; font-weight: bold">영문명&nbsp;&nbsp; </td>
		<td>
			<input type="text" name="english" value="<%=vo.getEnglish() %>" style="width: 200px; height: 22px; border: 1px soild; border-radius: 4px; border-color:#81BEF7 ">
		</td>
	</tr>
	
	<tr>
		<td align="right" style="font-size: 13pt; font-weight: bold">이메일&nbsp;&nbsp; </td>
		<td>
			<input type="email" name="email" value="<%=vo.getEmail()%>" style="width: 200px; height: 22px; border: 1px soild; border-radius: 4px; border-color:#81BEF7 ">
		</td>
	</tr>
	
	<tr>
		<td align="right" style="font-size: 13pt; font-weight: bold">전화번호&nbsp;&nbsp; </td>
		<td>
			<select name="phone1" value="<%=vo.getPhone1()%>" style="width: 50px; height: 28px; border: 1px soild; border-radius: 4px; border-color:#81BEF7 ">
				<option value="02">02</option>
				<option value="031">031</option>
				<option value="032">032</option>
				<option value="033">033</option>
				<option value="042">042</option>
				<option value="010">010</option>
			</select>-
			<input type="text" name="phone2" value="<%=vo.getPhone2()%>" size="5" style="width: 70px; height: 22px; border: 1px soild; border-radius: 4px; border-color:#81BEF7 ">-
			<input type="text" name="phone3" size="5" value="<%=vo.getPhone3()%>" style="width: 70px; height: 22px; border: 1px soild; border-radius: 4px; border-color:#81BEF7 ">
		</td>
	</tr>
		
	<tr>
		<td align="right"  style="font-size: 13pt; font-weight: bold" >우편번호&nbsp;&nbsp; </td>
		<td> 
			<input type="text" name="zipcode" value="<%=vo.getZipcode()%>" style="width: 70px; height: 22px; border: 1px soild; border-radius: 4px; border-color:#81BEF7 ">&nbsp;
			<input type="button" value="우편번호 찾기" onClick="zipCheck()" style="width: 100px; height:30px; border: 1px soild; border-radius: 4px; border-color:#81BEF7; font-weight: bold; background-color:#CEE3F6; cursor: pointer; ">
		</td>
	</tr>
	
	<tr>
		<td align="right" style="font-size: 13pt; font-weight: bold">주소&nbsp;&nbsp; </td>
		<td>
			<input type="email" name="address1" size="50" value="<%=vo.getAddress1()%>" style="width: 200px; height: 22px; border: 1px soild; border-radius: 4px; border-color:#81BEF7 ">
		</td>
	</tr>
	<tr>
		<td align="right" style="font-size: 13pt; font-weight: bold">나머지주소&nbsp;&nbsp; </td>
		<td>
			<input type="email" name="address2" size="30" value="<%=vo.getAddress2()%>" style="width: 200px; height: 22px; border: 1px soild; border-radius: 4px; border-color:#81BEF7 ">
		</td>
	</tr>

	<tr>
		<td align="right" style="font-size: 13pt; border-radius: 4px; font-weight: bold">선호 음식&nbsp;&nbsp;</td>
		<td>
		 <input type="checkbox" name="likefood" value="한식">한식&nbsp;&nbsp;&nbsp;
         <input type="checkbox" name="likefood" value="양식">양식&nbsp;&nbsp;&nbsp;
         <input type="checkbox" name="likefood" value="중식">중식<br>
         <input type="checkbox" name="likefood" value="일식">일식&nbsp;&nbsp;&nbsp;
         <input type="checkbox" name="likefood" value="기타">기타
		</td>
	</tr>
	
	<tr>
	
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="정보수정" onClick="inputCheck()" style="width: 130px; height:35px; border: 1px soild; border-radius: 4px; border-color:#81BEF7; font-weight: bold; background-color:#CEE3F6; cursor: pointer; ">&nbsp;&nbsp;
			<input type="reset" value="다시입력" style="width: 130px; height:35px; border: 1px soild; border-radius: 4px; border-color:#81BEF7; font-weight: bold; background-color:#CEE3F6; cursor: pointer; ">
			<input type="hidden" name="role" value="user">
		</td>
	</tr>
</table>
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