<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.R_BoardVO" %>
<%@ page import="board.R_BoardDAO" %>
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
String saveFolder = "/r_board/image";					// 학원에서 할 때
//String saveFolder = "C:/ADevelop/jspproject/JspPractice/src/main/webapp/i_board/image";					// 집에서 할 때
String encType = "utf-8";		
int size=5*1024*1024;	

ServletContext context = request.getServletContext();
realFolder = context.getRealPath(saveFolder);
System.out.println("============ uploadFilePath = " + realFolder);
	

 MultipartRequest multi = new MultipartRequest(request, realFolder, size, encType, new DefaultFileRenamePolicy());		//파일업로드를 직접적으로 담당 		
 
 String mr_image="";
 String mr_writer = multi.getParameter("mr_writer");
 String mr_pass = multi.getParameter("mr_pass");
 String mr_subject = multi.getParameter("mr_subject");
 int mr_bcheck = Integer.parseInt(multi.getParameter("mr_bcheck"));
 String mr_header = multi.getParameter("mr_header");
 String mr_content = multi.getParameter("mr_content");
 String add = multi.getParameter("add");

 if(Integer.parseInt(add) > 0){
	 for(int i = 0; i < Integer.parseInt(add); i++){
		 mr_image += (multi.getFilesystemName("mr_image"+(i+1))+ ",");
		 
		 }
	 }else{
		 mr_image="";
	 }
	 
	 mr_image = mr_image.substring(0, mr_image.length()-1);
	 
	 Enumeration e = multi.getFileNames();
	 
	 while(e.hasMoreElements()){
		 String n = (String)e.nextElement();
		 saveFile.add(multi.getFilesystemName(n));
		 oldFile.add(multi.getOriginalFileName(n));
	 }

	String mr_postdate = request.getParameter("mr_postdate");
	R_BoardVO article = new R_BoardVO();
	R_BoardDAO dbPro = R_BoardDAO.getInstance();
	
	
article.setMr_writer(mr_writer);
article.setMr_pass(mr_pass);
article.setMr_subject(mr_subject);
article.setMr_bcheck(mr_bcheck);
article.setMr_header(mr_header);
article.setMr_content(mr_content);
article.setMr_image(mr_image);
article.setMr_postdate(new Timestamp(System.currentTimeMillis()));


String pageNum = request.getParameter("pageNum");


int check = dbPro.updateArticle(article);

if(check==1){
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" http-equiv="Refresh" content="0; url=r_boardList.jsp?pageNum=<%=pageNum%>">
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
