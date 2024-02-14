package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConn {

	public Connection con;
	public Statement stmt;
	public PreparedStatement pstmt;
	public ResultSet rs;
	
	
	public DBConn() {			// 기본생성자
	
		try {
			Context initCtx = new InitialContext();
			Context ctx = (Context)initCtx.lookup("java:comp/env");
			DataSource source = (DataSource)ctx.lookup("mydb");
			
			con = source.getConnection();
			
			System.out.println("DB 커넥션풀 연결 성공");
		}catch(Exception e) {
			e.printStackTrace();
		}

	}
	
	
	public void close() {
		try {
			if(rs != null)rs.close();
			if(stmt != null)stmt.close();
			if(pstmt != null)pstmt.close();
			if(con != null)con.close();
			
			System.out.println("DB 커넥션풀 해제");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
