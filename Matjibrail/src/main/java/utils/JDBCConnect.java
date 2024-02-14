package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;

public class JDBCConnect {

	public Connection con;
	public Statement stmt;
	public PreparedStatement pstmt;
	public ResultSet rs;
	
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String id = "scott";
	String pass = "1234";
	public JDBCConnect() {			// �⺻������
		try {
			
			Class.forName("oracle.jdbc.OracleDriver");			// JDBC ����̹� �ε�
			
			
			con = DriverManager.getConnection(url,id,pass);
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public JDBCConnect(String driver, String url, String id, String pass) {			// ������2(�Ű����� 4��)
		
		try {
			Class.forName(driver);
			
			con = DriverManager.getConnection(url, id, pass);
			
			System.out.println("DB ���� ����!");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public JDBCConnect(ServletContext application) {
		
		try {
			
			String driver = application.getInitParameter("OracleDriver");
			Class.forName(driver);
			
			String url = application.getInitParameter("OracleURL");
			String id = application.getInitParameter("OracleId");
			String pass = application.getInitParameter("OraclePass");
			con = DriverManager.getConnection(url, id, pass);
			
			System.out.println("DB ���� ����!");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close() {					// DB ���� ���� �޼���
		try {
			if(rs != null)rs.close();
			if(stmt != null)rs.close();
			if(pstmt != null)rs.close();
			if(con != null)rs.close();
			
			System.out.println("DB ���� ����");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
