package utils;

import javax.servlet.jsp.JspWriter;
public class JSFunction {

	public static void alertLocation(String msg, String url, JspWriter out) {			// 메시지 알림창을 띄운 후 명시한 URL로 이동하는 메서드
		
		// msg : 알림창에 띄울 메시지
		// url : 알림창을 닫은 후 이동할 페이지의 url
		// out : 자바스크립트 코드를 삽입할 출력 스트림`
		
		
		try {
			String script = "" +						//script = 삽입할 자바 스크립트 코드 
							"<script> alert('" + msg + "'); location.href='"+ url + "'; </script>";
			
			out.println(script);			// 자바 스크립트 코드를 out객체를 이용하여 출력
		}catch(Exception e) {}
	}
	
	
	public static void alertBack(String msg, JspWriter out) {			// 메시지 알림창을 띄운 후 이전 페이지로 이동하는 메서드
		
		try {
			String script = "" + "<script> alert('" + msg + "'); history.back(); </script>";
			
			out.println(script);
		}catch(Exception e) {}
		
	}
}
