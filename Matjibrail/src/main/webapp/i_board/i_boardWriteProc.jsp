<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.I_BoardVO" %>
<%@ page import="board.I_BoardDAO" %>
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
String saveFolder = "/i_board/image";					// 학원에서 할 때
//String saveFolder = "C:/ADevelop/jspproject/JspPractice/src/main/webapp/i_board/image";					// 집에서 할 때
String encType = "utf-8";		
int size=5*1024*1024;	

ServletContext context = request.getServletContext();
realFolder = context.getRealPath(saveFolder);
System.out.println("============ uploadFilePath = " + realFolder);


 MultipartRequest multi = new MultipartRequest(request, realFolder, size, encType, new DefaultFileRenamePolicy());		//파일업로드를 직접적으로 담당 		
String mi_image = "";
 String mi_writer = multi.getParameter("mi_writer");
 String mi_pass = multi.getParameter("mi_pass");
 String mi_subject = multi.getParameter("mi_subject");
 String mi_content = multi.getParameter("mi_content");
 String add = multi.getParameter("add");
 
 if(Integer.parseInt(add) > 0){
 for(int i = 0; i < Integer.parseInt(add); i++){
	 mi_image += (multi.getFilesystemName("mi_image"+(i+1))+ ",");
 }
 }else{
	 mi_image="";
 }
 
 mi_image = mi_image.substring(0, mi_image.length()-1);
 
 Enumeration e = multi.getFileNames();
 
 while(e.hasMoreElements()){
	 String n = (String)e.nextElement();
	 saveFile.add(multi.getFilesystemName(n));
	 oldFile.add(multi.getOriginalFileName(n));
 }
 
 
 String mi_postdate = request.getParameter("mi_postdate");

	I_BoardVO article = new I_BoardVO();
	I_BoardDAO dbPro = I_BoardDAO.getInstance(); 
	
	request.setAttribute("imgArr", mi_image);
	
article.setMi_writer(mi_writer);
article.setMi_pass(mi_pass);
article.setMi_subject(mi_subject);
article.setMi_content(mi_content);
article.setMi_image(mi_image);
article.setMi_postdate(new Timestamp(System.currentTimeMillis()));

dbPro.insertArticle(article);


response.sendRedirect("i_boardList.jsp");
%>