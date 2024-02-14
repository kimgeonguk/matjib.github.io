package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import member.MemberVO;

public class RecommendDAO {

	
	
	// �뵒鍮� �뿰寃�
	private Connection getConnection() {
		Connection con = null;
		try {
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mydb");
			
			con = ds.getConnection();
		}catch(Exception e) {
			System.out.println("Connection");
		}
		return con;
		
	}
	
	public void recommendInsert(int num, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try { 
			con = getConnection();
			pstmt = con.prepareStatement("insert into recommend values(?,?)");
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		
		}catch(Exception e) {
			System.out.println("Exception "+e);
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException s1) {}
			if(pstmt != null) try {pstmt.close();}catch(SQLException s2) {}
			if(con != null) try {con.close();}catch(SQLException s3) {}
		}
	}
	
	
	public int recommendCheck(int num, String id) {
		
		//異붿쿇 以묐났梨꾪겕
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int check = -1;
		
		try {
			con = getConnection();
			
			String strQuery = "select id from recommend where num=?";
			
			pstmt = con.prepareStatement(strQuery);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String dbid = rs.getString("id");
				if(id.equals(dbid)) check = 1;
				else check = 0;
			}
		}catch(Exception ex) {
			System.out.println("Exception " + ex);
		}finally {
			if(rs != null) 
				try { 
					rs.close();
					}catch(SQLException s1) {
						
					}
			if(pstmt != null) 
				try { 
					pstmt.close();
					}catch(SQLException s2) {
						
					}
			if(con != null) 
				try { 
					con.close();
					}catch(SQLException s3) {
						
					}
		}
		return check;
	}
	
	
	
	public int recommendDelete(int num, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 1;
		String dbId = "";	
		
		try {
			con = getConnection();
			String strQuery = "select id from RECOMMEND where num=?";
			pstmt = con.prepareStatement(strQuery);
			
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbId = rs.getString("id");
				if(dbId.equals(id)) {
					pstmt = con.prepareStatement("delete from RECOMMEND where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					result = 2;
				}
				result = 3;
			}
		}catch(Exception ex) {
			System.out.println("Exception " + ex);
		}finally {
			if(rs != null) 
				try { 
					rs.close();
					}catch(SQLException s1) {
						
					}
			if(pstmt != null) 
				try { 
					pstmt.close();
					}catch(SQLException s2) {
						
					}
			if(con != null) 
				try { 
					con.close();
					}catch(SQLException s3) {
						
					}
		}
		return result;
	}
	
	
}
