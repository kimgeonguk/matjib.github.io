<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="popup.PopupVO" %>
<%@page import="popup.PopupDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
.wrapper {
	display: flex;
	flex-direction: column;
	height: 100%;
}

.main-content {
	flex: 1;
}

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
	height: 900px;
	border-color: #81BEF7;
	font-family: 'Nanum Gothic', sans-serif;
	flex: 1;
}
/*  아래늘리기  
html,
body{
	height: 100%;
}
body{
	display: flex;
	flex-direction: column;
} */

#footer
{
	margin:0 auto; 
	width : 1500px;
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

a
{
margin: 10px;
padding: 10px
}

</style>


</head>
<div class="wrapper">
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
<div id="section" class="main-content">
       <div id="a1" class="section">
            <h4>1. 개인정보처리방침의 의의</h4>
            <p><strong id="a1_1" class="b">맛집노선도는 본 개인정보처리방침은 개인정보보호법을 기준으로 작성하되, 맛집노선도 내에서의 이용자 개인정보 처리 현황을 최대한 알기 쉽고 상세하게 설명하기 위해 노력하였습니다.</strong><br>이는 쉬운 용어를 사용한 개인정보처리방침 작성 원칙인 ‘Plain Language Privacy Policy(쉬운 용어를 사용한 개인정보처리방침)’를 도입한 것입니다.</p>
            <p>개인정보처리방침은 다음과 같은 중요한 의미를 가지고 있습니다.</p>
            <ul class="bu">
                <li><i></i>맛집노선도가 어떤 정보를 수집하고, 수집한 정보를 어떻게 사용하며, 필요에 따라 누구와 이를 공유(‘위탁 또는 제공’)하며, 이용목적을 달성한 정보를 언제·어떻게 파기하는지 등 ‘개인정보의 한살이’와 관련한 정보를 투명하게 제공합니다.</li>
                <li><i></i>정보주체로서 이용자는 자신의 개인정보에 대해 어떤 권리를 가지고 있으며, 이를 어떤 방법과 절차로 행사할 수 있는지를 알려드립니다. 또한, 법정대리인(부모 등)이 만14세 미만 아동의 개인정보 보호를 위해 어떤 권리를 행사할 수 있는지도 함께 안내합니다.</li>
                <li><i></i>개인정보 침해사고가 발생하는 경우, 추가적인 피해를 예방하고 이미 발생한 피해를 복구하기 위해 누구에게 연락하여 어떤 도움을 받을 수 있는지 알려드립니다.</li>
                <li><i></i>그 무엇보다도, 개인정보와 관련하여 맛집노선도와 이용자간의 권리 및 의무 관계를 규정하여 이용자의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.</li>
            </ul>
        </div>
        <div id="a2" class="section">
            <h4>2. 수집하는 개인정보</h4>
            <p><strong id="a2_1" class="b">이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 맛집노선도 서비스를 회원과 동일하게 이용할 수 있습니다. <br>이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 맛집노선도는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.</strong></p>
            <ul class="sec">
                <li class="first">
                    <p><strong id="a2_2">회원가입 시점에 맛집노선도가 이용자로부터 수집하는 개인정보는 아래와 같습니다.</strong></p>
                    <ul class="bu">
                        <li><i></i>회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호’를 필수항목으로 수집합니다. 만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다. <span>그리고 선택항목으로 이메일 주소를 수집합니다.</span></li>
                        <li><i></i><span>단체아이디로 회원가입 시 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를 필수항목으로 수집합니다. 그리고 단체 대표자명을 선택항목으로 수집합니다.</span></li>
                    </ul>
                </li>
                <li>
                    <p><strong><a href="#tgl2-1" class="tgl_more">회원 가입 시 수집하는 개인정보에 대한 추가 설명</a></strong></p>
                    <dl class="tgl_cont" id="tgl2-1">
                        <dt>(1) 필수항목과 선택항목의 차이</dt>
                        <dd>필수항목이란 서비스의 본질적 기능을 수행하기 위해 필요한 정보이며, 선택항목이란 서비스 이용 자체에 영향을 미치지는 않으나 이용자에게 부가적인 가치를 제공하기 위해 추가로 수집하는 정보입니다. 회원가입 시에 수집하는 아이디, 비밀번호는 로그인을 위하여 필요한 정보이며 이름, 생년월일, 성별은 회원제 서비스 운영에 따르는 이용자 구분을 위하여 사용됩니다. 가입인증 휴대폰번호는 불법 광고 게시 등 부정한 목적으로 회원가입을 시도하는 경우, 이용제한 조치 등을 적용하기 위하여 수집합니다. 선택항목은 입력을 하지 않아도 회원 가입이나 서비스 이용에 제한이 없으며, 필요할 경우 맛집노선도 내정보 &gt; 회원정보 &gt; 연락처에서 사후에 언제든지 직접 입력하실 수 있습니다.</dd>
                        <dt>(2) 법정대리인 정보를 수집하는 이유</dt>
                        <dd>만 14세 미만 아동의 개인정보를 수집할 경우, 회사는 개인정보보호법에 따라 법정대리인(부모 등 아동의 보호자)의 동의를 받아야 합니다. 이에 따라 맛집노선도는 만 14세 미만 아동의 개인정보 수집 시점에서 법정대리인의 동의를 받고 있으며, 이 과정에서 법정대리인의 이름, DI, 휴대폰번호(모바일 인증 시에만)를 수집합니다. 수집된 법정대리인의 정보는 아동이 성년이 되는 시점에서 파기하고 있습니다.</dd>
                        <dt>(3) 단체정보의 개인정보 인정 여부</dt>
                        <dd>개인정보보호법에서 정의하는 개인정보는 ‘살아있는 자연인에 대한 정보’를 말합니다. 따라서 단체명, 영업소 주소 및 전화번호, 대표자 성명 등과 같은 법인이나 단체에 관한 정보는 원칙적으로 개인정보에 해당하지 않습니다. 맛집노선도 단체아이디로 회원 가입 시에 수집하는 대부분의 정보는 개인정보에 해당하지 않습니다. 하지만 개인 사업자 등의 경우 이를 단체정보로만 처리하기 모호한 측면이 있고, 관리자/담당자의 연락처 정보 등을 수집하기 때문에 본 개인정보처리방침에서는 단체정보의 수집 관련 내용을 기재하여 이용자의 이해를 돕고 있습니다.</dd>
                    </dl>
                </li>
                <li>
                    <p><strong id="a2_3">서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.</strong></p>
                    <ul class="bu">
                        <li><i></i>회원정보 또는 개별 서비스에서 프로필 정보(별명, 프로필 사진)를 설정할 수 있습니다. <span>회원정보에 별명을 입력하지 않은 경우에는 마스킹 처리된 아이디가 별명으로 자동 입력됩니다.</span></li>
                        <li><i></i><span>맛집노선도 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 대해 안내 드리고 동의를 받습니다.</span>
                        </li></ul>
                </li>
                <li>
                    <p><strong>서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 기기정보, 위치정보가 생성되어 수집될 수 있습니다.<br>또한 이미지 및 음성을 이용한 검색 서비스 등에서 이미지나 음성이 수집될 수 있습니다.</strong></p>
                    <p>구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 이를 저장(수집)하거나, 2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다. 서비스 이용 과정에서 위치정보가 수집될 수 있으며, 맛집노선도에서 제공하는 위치기반 서비스에 대해서는 '맛집노선도 위치정보 이용약관'에서 자세하게 규정하고 있습니다.<br>이와 같이 수집된 정보는 개인정보와의 연계 여부 등에 따라 개인정보에 해당할 수 있고, 개인정보에 해당하지 않을 수도 있습니다.</p>
                </li>
                <li>
                    <p><strong id="a2_4"><a href="#tgl2-2" class="tgl_more">생성정보 수집에 대한 추가 설명</a></strong></p>
                    <dl class="tgl_cont" id="tgl2-2">
                        <dt>IP(Internet Protocol) 주소란?</dt>
                        <dd>IP 주소는 인터넷 망 사업자가 인터넷에 접속하는 이용자의 PC 등 기기에 부여하는 온라인 주소정보 입니다. IP 주소가 개인정보에 해당하는지 여부에 대해서는 각국마다 매우 다양한 견해가 있습니다.</dd>
                        <dt>서비스 이용기록이란?</dt>
                        <dd>맛집노선도 접속 일시, 이용한 서비스 목록 및 서비스 이용 과정에서 발생하는 정상 또는 비정상 로그 일체, 메일 수발신 과정에서 기록되는 이메일주소, 친구 초대하기 또는 선물하기 등에서 입력하는 휴대전화번호 등을 의미합니다.</dd>
                        <dt>기기정보란?</dt>
                        <dd>본 개인정보처리방침에 기재된 기기정보는 생산 및 판매 과정에서 기기에 부여된 정보뿐 아니라, 기기의 구동을 위해 사용되는 S/W를 통해 확인 가능한 정보를 모두 일컫습니다. OS(Windows, MAC OS 등) 설치 과정에서 이용자가 PC에 부여하는 컴퓨터의 이름, PC에 장착된 주변기기의 일련번호, 스마트폰의 통신에 필요한 고유한 식별값(IMEI, IMSI), AAID 혹은 IDFA, 설정언어 및 설정 표준시, USIM의 통신사 코드 등을 의미합니다. 단, 맛집노선도는 IMEI와 같은 기기의 고유한 식별값을 수집할 필요가 있는 경우, 이를 수집하기 전에 맛집노선도도 원래의 값을 알아볼 수 없는 방식으로 암호화 하여 식별성(Identifiability)을 제거한 후에 수집합니다.</dd>
                        <dt>쿠키(cookie)란?</dt>
                        <dd>쿠키는 이용자가 웹사이트를 접속할 때에 해당 웹사이트에서 이용자의 웹브라우저를 통해 이용자의 PC에 저장하는 매우 작은 크기의 텍스트 파일입니다. 이후 이용자가 다시 웹사이트를 방문할 경우 웹사이트 서버는 이용자 PC에 저장된 쿠키의 내용을 읽어 이용자가 설정한 서비스 이용 환경을 유지하여 편리한 인터넷 서비스 이용을 가능케 합니다. 또한 방문한 서비스 정보, 서비스 접속 시간 및 빈도, 서비스 이용 과정에서 생성된 또는 제공(입력)한 정보 등을 분석하여 이용자의 취향과 관심에 특화된 서비스(광고 포함)를 제공할 수 있습니다. 이용자는 쿠키에 대한 선택권을 가지고 있으며, 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다. 다만, 쿠키의 저장을 거부할 경우에는 로그인이 필요한 맛집노선도 일부 서비스의 이용에 불편이 있을 수 있습니다.<br></dd>
                    </dl>
                </li>
                <li class="last">
                    <p><strong id="a2_5">맛집노선도는 아래의 방법을 통해 개인정보를 수집합니다.</strong></p>
                    <ul class="bu">
                        <li><i></i>회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우, 해당 개인정보를 수집합니다.</li>
                        <li><i></i>고객센터를 통한 상담 과정에서 웹페이지, 메일, 팩스, 전화 등을 통해 이용자의 개인정보가 수집될 수 있습니다.</li>
                        <li><i></i>오프라인에서 진행되는 이벤트, 세미나 등에서 서면을 통해 개인정보가 수집될 수 있습니다.</li>
                        <li><i></i>맛집노선도와 제휴한 외부 기업이나 단체로부터 개인정보를 제공받을 수 있으며, 이러한 경우에는 개인정보보호법에 따라 제휴사에서 이용자에게 개인정보 제공 동의 등을 받은 후에 맛집노선도에 제공합니다.</li>
                        <li><i></i>기기정보와 같은 생성정보는 PC웹, 모바일 웹/앱 이용 과정에서 자동으로 생성되어 수집될 수 있습니다.</li>
                    </ul>
                </li>
            </ul>
        </div>
        <div id="a3" class="section">
            <h4>3. 수집한 개인정보의 이용</h4>
            <ul class="sec">
                <li class="first last">
                    <p><strong id="a3_1">맛집노선도 및 맛집노선도 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발·제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.</strong></p>
                    <ul class="bu">
                        <li><i></i>회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.</li>
                        <li><i></i>콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.</li>
                        <li><i></i>법령 및 맛집노선도 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.</li>
                        <li><i></i>유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 상품 및 서비스의 배송을 위하여 개인정보를 이용합니다.</li>
                        <li><i></i>이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.</li>
                        <li><i></i>서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.</li>
                        <li><i></i>보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.</li>
                    </ul>
                </li>
            </ul>
        </div>
	 
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
</div>
</body>
</html>