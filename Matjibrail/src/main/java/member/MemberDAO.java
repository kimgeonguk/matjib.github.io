package member;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import javax.naming.*;

public class MemberDAO {

	private Connection getConnection() {
		Connection con = null;
		try {
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mydb");
			
			con = ds.getConnection();
		}catch(Exception e) {
			System.out.println("Connection 占쏙옙占쏙옙 占쏙옙占쏙옙 ~~~");
		}
		return con;
	}
	
	
	public boolean idCheck(String id) {
		boolean result = true;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
		
			con = getConnection();
			
			pstmt = con.prepareStatement("select * from member where id=?");
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(!rs.next()) result = false;
			
		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			if(rs != null) try { rs.close();}catch(SQLException s1) {}
			if(pstmt != null) try { pstmt.close();}catch(SQLException s2) {}
			if(con != null) try { con.close();}catch(SQLException s3) {}
		}
		return result;
	}
	

	public Vector<ZipCodeVO> zipcodeRead(String dong) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Vector<ZipCodeVO> vecList = new Vector<ZipCodeVO>();
		
		try {
			
		con = getConnection();
		String strQuery = "select * from zipcode where dong like '"+dong+"%'";
		
		pstmt = con.prepareStatement(strQuery);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			ZipCodeVO tempZipcode = new ZipCodeVO();
			tempZipcode.setZipcode(rs.getString("zipcode"));
			tempZipcode.setSido(rs.getString("sido"));
			tempZipcode.setGugun(rs.getString("gugun"));
			tempZipcode.setDong(rs.getString("dong"));
			tempZipcode.setRi(rs.getString("ri"));
			tempZipcode.setBunji(rs.getString("bunji"));
			
		
			vecList.addElement(tempZipcode);
		}
		}catch(SQLException se) {
			se.printStackTrace();
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
		return vecList;
	}
	
	

	public boolean memberInsert(MemberVO vo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		
		try { 
			con = getConnection();
			String strQuery = "insert into member values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPass());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getEnglish());
			pstmt.setString(5, vo.getEmail());
			pstmt.setString(6, vo.getPhone1());
			pstmt.setString(7, vo.getPhone2());
			pstmt.setString(8, vo.getPhone3());
			pstmt.setString(9, vo.getZipcode());
			pstmt.setString(10, vo.getAddress1());
			pstmt.setString(11, vo.getAddress2());
			pstmt.setString(12, vo.getLikefood());
			pstmt.setString(13, vo.getRole());
			
			int count = pstmt.executeUpdate();
			if(count > 0) flag = true;
		
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
		return flag;
	}
	

	public int loginCheck(String id, String pass) {
		
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int check = -1;
		
		try {
			con = getConnection();
			
			String strQuery = "select pass from member where id=?";
			
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String dbPass = rs.getString("pass");
				if(pass.equals(dbPass)) check = 1;
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
	
	/*
	 * 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 클占쏙옙占싹몌옙 占쏙옙占쏙옙 占싸깍옙占쏙옙占쏙옙 회占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙 占쌍듸옙占쏙옙 占싱몌옙 화占썽에 占쏙옙占쏙옙占쌍억옙占쏙옙占�
	 * 占쏙옙占실울옙 占쏙옙占쏙옙占� 占쏙옙占싱듸옙 占쏙옙占쏙옙占쏙옙 회占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쌨소드가 占십울옙占쏙옙
	   StudentDAO占쏙옙 占쏙옙占싱듸옙 占쏙옙占쏙옙占쏙옙 회占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쌨소드를 占쌩곤옙占싹몌옙 占쏙옙
	 */
	
	public MemberVO getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO vo = null;
		
		try {
			con = getConnection();
			String strQuery = "select * from member where id=?";
			
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				vo = new MemberVO();
				vo.setId(rs.getString("id"));
				vo.setPass(rs.getString("pass"));
				vo.setName(rs.getString("name"));
				vo.setEnglish(rs.getString("english"));
				vo.setEmail(rs.getString("email"));
				vo.setPhone1(rs.getString("Phone1"));
				vo.setPhone2(rs.getString("Phone2"));
				vo.setPhone3(rs.getString("Phone3"));
				vo.setZipcode(rs.getString("zipcode"));
				vo.setAddress1(rs.getString("Address1"));
				vo.setAddress2(rs.getString("Address2"));
				vo.setLikefood(rs.getString("likefood"));
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
	 return vo;
	}		
	
	
	
	

	public void updateMember(MemberVO vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			String strQuery = "update member set pass=?, english=?, email=?, phone1=?, phone2=?, phone3=?, zipcode=?, address1=?, address2=?, likefood=? where id=?";
			pstmt = con.prepareStatement(strQuery);
			
			pstmt.setString(1, vo.getPass());
			pstmt.setString(2, vo.getEnglish());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getPhone1());
			pstmt.setString(5, vo.getPhone2());
			pstmt.setString(6, vo.getPhone3());
			pstmt.setString(7, vo.getZipcode());
			pstmt.setString(8, vo.getAddress1());
			pstmt.setString(9, vo.getAddress2());
			pstmt.setString(10, vo.getLikefood());
			pstmt.setString(11, vo.getId());
			
			pstmt.executeUpdate();
			
		}catch(Exception ex) {
			System.out.println("Exception " + ex);
		}finally {
			if(pstmt != null) 
				try { 
					pstmt.close();
					}catch(SQLException s1) {
						
					}
			if(con != null) 
				try { 
					con.close();
					}catch(SQLException s2) {
						
					}
		}
	}
	

	public int deleteMember(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String dbPass = "";	
		
		int result = -1;
		
		try {
			con = getConnection();
			String strQuery = "select pass from member where id=?";
			pstmt = con.prepareStatement(strQuery);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbPass = rs.getString("pass");
				if(dbPass.equals(pass)) {
					pstmt = con.prepareStatement("delete from member where id=?");
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					
					result = 1;	
				}else {
					result = 0;
				}
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
	
	
	
	public String findId(String english, String email) {
		String id = null;
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		
		try {
		    con = getConnection();
			String sql = "select id from member where english=? and email=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, english);
			pstmt.setString(2, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				id = rs.getString("id");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	

		public String findPw(String id, String english, String email) {
			String pass = null;
			  Connection con = null;
			  PreparedStatement pstmt = null;
			  ResultSet rs = null;
			
			try {
			    con = getConnection();
				String sql = "select pass from member where id=? and english=? and email=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, english);
				pstmt.setString(3, email);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					pass = rs.getString("pass");
				}
					
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pass;
		}

	
}
