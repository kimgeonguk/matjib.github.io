<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="popup.PopupVO" %>
<%@page import="popup.PopupDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String loginID = (String)session.getAttribute("loginID");
request.setCharacterEncoding("UTF-8");
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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>글쓰기 - 자유게시판</title>
<!-- 부트스트랩 css 사용 -->
<!--  <link rel="stylesheet" href="../bootstrap/css/bootstrap.css"> -->
<!--  부트스트랩 js 사용 -->
<!--  <script type="text/javascript" src="../bootstrap/js/bootstrap.js"></script> -->


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
<%
	int num=0;		// 새 글이 처음 만들어졌을 때의 값들 초기화
	
	try{
		if(request.getParameter("mf_num") != null){				// 무언가 글이 있을 경우
			num = Integer.parseInt(request.getParameter("mf_num"));		// num = DB상에 저장되어 있는 해당 게시글의 일련번호
		}
%>

<div id="section">
<br><br>
<div align="left" style="margin-left: 10%">
<b style="font-size: 25pt; color: #81BEF7;">자유게시판 - 글작성</b>
</div>
<br><br><br>


<form action="f_boardWriteForm.jsp" name="f_boardWriteForm" method="post" onsubmit="return checkWriteForm()">
<!-- 폼이 넘어갈 때 위의 숫자 변수들을 같이 처리함-->
<input type="hidden" name="num" value="<%=num %>">
<table width="1000" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr >
		<td width="140" align="center"><a style="font-size: 14pt; font-weight: bold;">글 제목</a></td>
		<td colspan="3" align="center"><input type="text" size="50" maxlength="50" style="width: 800px; height: 23px; border: 1px solid; border-color:#81BEF7; border-radius: 5px; outline: 1px solid #81BEF7;" name="mf_subject" value='<%=getParam(request, "mf_subject")%>'></td>
	</tr>
	
	<tr height="20px;">
	
	</tr>
	
	<tr>
		<td width="140" align="center"><a style="font-size: 14pt; font-weight: bold;">작성자</a></td>
		<td width="330">
		<a style="margin-left: 3%; font-weight: bold;" ><%=loginID %></a>
		<input type="hidden" size="20" maxlength="20" style="margin-left: 6%" name="mf_writer" value='<%=loginID %>'>
		<input type="hidden" size="20" maxlength="20" style="margin-left: 6%" name="mf_pass" value='<%=1234%>'> <%--일단 디폴트로 1234 --%>
		</td>
		
		<%-- <td width="140" align="center">비밀번호</td>
		<td width="330"><input type="password" size="20" maxlength="20" style="margin-left: 6%" name="mf_pass" value='<%=getParam(request, "mf_pass")%>'></td> --%>
	</tr>
	
	<tr height="40px;">
	
	</tr>
	
	<tr height = "500px">
		<td colspan="4"><textarea style="margin-left: 2%; resize: none; width: 1000px; height:480px; border-radius: 5px; border-color:#81BEF7; outline: 1px solid #81BEF7; "  name="mf_content"><%=getParam(request, "mf_content")%></textarea></td>
	</tr>
	
	<tr height="40px;">
	
	</tr>
	
	<tr>
		<td width="140" height="50px" align="center">
		<a style="font-weight: bold;">추가 이미지 수<br>(최대 9개)</a>
		</td>
		<td>
		<input type="number" min="0" max="9" name="add" style="width: 40px; height: 23px; border: 1px solid;  border-radius: 5px; border-color:#81BEF7; outline: 1px solid #81BEF7; " value='<%=getParam(request, "add")%>'>
		<a style="font-weight: bold">개 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<input type="submit" style="width: 60px; height: 23px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-weight: bold; cursor: pointer;" value="확인">
		</td>
		
	</tr>
	<tr height="20px">
		<td colspan="4"><a style="font-size: 9pt; margin-left: 3%;">* 이미지를 추가하지 않으신다면 0을 입력해주세요. </a><td>
		
	</tr>
	<tr>
		<td colspan="4"><a style="font-size: 9pt; margin-left: 3%;">* 확인버튼을 누르시면 글작성 버튼이 생성됩니다.<br><br></a><td>
	</tr>
	
	</table>
	</form>
	
	
	<%
	int filecnt = 0;
	
	if(request.getParameter("add") != null){
		
		filecnt = Integer.parseInt(request.getParameter("add"));
	}else{
		filecnt = 0;
	}
	%>
	<form action="f_boardWriteProc.jsp" encType="multipart/form-data" method="post" onsubmit="return checkWriteForm()">
		<input type="hidden" name="mf_writer" value="<%=getParam(request, "mf_writer") %>">
		<input type="hidden" name="mf_pass" value="<%=getParam(request, "mf_pass") %>">
		<input type="hidden" name="mf_subject" value="<%=getParam(request, "mf_subject") %>">
		<input type="hidden" name="mf_content" value="<%=getParam(request, "mf_content") %>">
		<input type="hidden" name="add" value="<%=getParam(request, "add") %>">
		<%
		if (Integer.parseInt(request.getParameter("add")) > 0) {
		%>
		<input type="hidden" name="add" value="<%=getParam(request, "add")%>">
		<%
		} else {
		%>
		<%
		}
		%>
		<%
		for (int i = 0; i < filecnt; i++) {
			if (filecnt > 9) {
				filecnt = 9;
			}
		%>
		<div align="left" style="width: 1000; margin-left: 18%;">
		<a style="font-size: 13pt"><%=i + 1%>번째</a><a style="font-size: 13pt"> 이미지 선택 &nbsp;&nbsp;&nbsp;</a> 
		<input type="file" name="mf_image<%=i + 1%>"><br>
		</div>
	
		<%} %>
		<br><br>
		<table width="1000" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="글 작성" style="width: 130px; height:40px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-weight: bold; cursor: pointer;"> &nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="다시 작성"  style="width: 130px; height:40px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-weight: bold; cursor: pointer;"> &nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="목록으로"  style="width: 130px; height:40px; background-color:#CEE3F6; border:1px solid; border-color:#81BEF7; border-radius: 5px; font-weight: bold; cursor: pointer;" onClick="window.location='f_boardList.jsp'">
			</td>
		</tr>
		</table>
</form>
<%}catch(Exception e){} %>
	
	 
	 
	 
	 
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