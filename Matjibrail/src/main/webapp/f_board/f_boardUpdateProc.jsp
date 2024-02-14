<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.F_BoardVO" %>
<%@ page import="board.F_BoardDAO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8" %>


<%
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");
ArrayList saveFile = new ArrayList();		// 저장될 파일 이름
ArrayList oldFile = new ArrayList(); 		// 실제 파일 이름


String realFolder = "";
String saveFolder = "/f_board/image";					// 학원에서 할 때
//String saveFolder = "C:/ADevelop/jspproject/JspPractice/src/main/webapp/i_board/image";					// 집에서 할 때
String encType = "utf-8";		
int size=5*1024*1024;	

ServletContext context = request.getServletContext();
realFolder = context.getRealPath(saveFolder);
System.out.println("============ uploadFilePath = " + realFolder);
	

 MultipartRequest multi = new MultipartRequest(request, realFolder, size, encType, new DefaultFileRenamePolicy());		//파일업로드를 직접적으로 담당 		

 String mf_image="";
 String mf_writer = multi.getParameter("mf_writer");
 String mf_pass = multi.getParameter("mf_pass");
 String mf_subject = multi.getParameter("mf_subject");
 String mf_content = multi.getParameter("mf_content");
String add = multi.getParameter("add");

if(Integer.parseInt(add) > 0){
	 for(int i = 0; i < Integer.parseInt(add); i++){
		 mf_image += (multi.getFilesystemName("mf_image"+(i+1))+ ",");
		 
		 }
	 }else{
		 mf_image="";
	 }
	 
	 mf_image = mf_image.substring(0, mf_image.length()-1);
	 
	 Enumeration e = multi.getFileNames();
	 
	 while(e.hasMoreElements()){
		 String n = (String)e.nextElement();
		 saveFile.add(multi.getFilesystemName(n));
		 oldFile.add(multi.getOriginalFileName(n));
	 }

	String mf_postdate = request.getParameter("mf_postdate");
	F_BoardVO article = new F_BoardVO();
	F_BoardDAO dbPro = F_BoardDAO.getInstance();
	
	
article.setMf_writer(mf_writer);
article.setMf_pass(mf_pass);
article.setMf_subject(mf_subject);
article.setMf_content(mf_content);
article.setMf_image(mf_image);
article.setMf_postdate(new Timestamp(System.currentTimeMillis()));


String pageNum = request.getParameter("pageNum");


int check = dbPro.updateArticle(article);

if(check==1){
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" http-equiv="Refresh" content="0; url=f_boardList.jsp?pageNum=<%=pageNum%>">
<title></title>
</head>
<body>
<div align="center">
<%}else{ %>
<script type="text/javascript">
alert("비밀번호가 일치하지 않습니다.");
history.go(-1);
</script>
<%} %>
</div>
</body>
</html>
