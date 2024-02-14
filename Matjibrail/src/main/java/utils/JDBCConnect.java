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
	public JDBCConnect() {			// 기본생성자
		try {
			
			Class.forName("oracle.jdbc.OracleDriver");			// JDBC 드라이버 로드
			
			
			con = DriverManager.getConnection(url,id,pass);
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public JDBCConnect(String driver, String url, String id, String pass) {			// 생성자2(매개변수 4개)
		
		try {
			Class.forName(driver);
			
			con = DriverManager.getConnection(url, id, pass);
			
			System.out.println("DB 연결 성공!");
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
			
			System.out.println("DB 연결 성공!");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close() {					// DB 연결 해제 메서드
		try {
			if(rs != null)rs.close();
			if(stmt != null)rs.close();
			if(pstmt != null)rs.close();
			if(con != null)rs.close();
			
			System.out.println("DB 연결 해제");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
