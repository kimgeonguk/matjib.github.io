package utils;

import javax.servlet.jsp.JspWriter;
public class JSFunction {

	public static void alertLocation(String msg, String url, JspWriter out) {			// �޽��� �˸�â�� ��� �� ����� URL�� �̵��ϴ� �޼���
		
		// msg : �˸�â�� ��� �޽���
		// url : �˸�â�� ���� �� �̵��� �������� url
		// out : �ڹٽ�ũ��Ʈ �ڵ带 ������ ��� ��Ʈ��`
		
		
		try {
			String script = "" +						//script = ������ �ڹ� ��ũ��Ʈ �ڵ� 
							"<script> alert('" + msg + "'); location.href='"+ url + "'; </script>";
			
			out.println(script);			// �ڹ� ��ũ��Ʈ �ڵ带 out��ü�� �̿��Ͽ� ���
		}catch(Exception e) {}
	}
	
	
	public static void alertBack(String msg, JspWriter out) {			// �޽��� �˸�â�� ��� �� ���� �������� �̵��ϴ� �޼���
		
		try {
			String script = "" + "<script> alert('" + msg + "'); history.back(); </script>";
			
			out.println(script);
		}catch(Exception e) {}
		
	}
}
