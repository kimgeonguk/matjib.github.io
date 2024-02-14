package popup;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import board.ConnUtil;
import board.R_BoardVO;



public class PopupDAO
{
	private static PopupDAO instance = null;
	
	
	public static PopupDAO getInstance()
	{
		if(instance == null)
		{
			synchronized (PopupDAO.class)
			{
				instance = new PopupDAO();
			}
		}
		return instance;
		
	}
	
	
	public PopupVO getPopData(String stname)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PopupVO vo = null;
		
		try
		{
			con = ConnUtil.getConnection();
			pstmt = con.prepareStatement("select * from MAINPOPUP where POP_STNAME=?");
			pstmt.setString(1, stname);
			
			rs=pstmt.executeQuery();
			
			if(rs.next())
			{
				vo=new PopupVO();
				vo.setPop_stname(rs.getString("pop_stname"));
				vo.setPop_stadd(rs.getString("pop_stadd"));
				vo.setPop_sttel(rs.getString("pop_sttel"));
				vo.setPop_y(rs.getString("pop_y"));
				vo.setPop_x(rs.getString("pop_x"));
			
			}
		}catch(Exception ex)
		{
			System.out.println("Exception "+ex);
		}
		finally 
		{
			if(rs != null) try {rs.close();} catch(SQLException s1) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException s2) {}
			if(con != null) try {con.close();} catch(SQLException s3) {}
		}	
		return vo;
		
	}
	
	//맛집정보 DAO. R보드에서 헤더로 추려서 정보가져오기.
	public List<R_BoardVO> getArticles(String stname) 
	{ 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<R_BoardVO> articleList = null;
		
		try {
			
			con = ConnUtil.getConnection();
			
			pstmt = con.prepareStatement("select * from (select * from R_BOARD where MR_HEADER=? order by MR_UP DESC) where rownum <= 5");
			pstmt.setString(1, stname);
		
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				articleList = new ArrayList<R_BoardVO>(); 
				
				do {
					
					R_BoardVO article = new R_BoardVO();
			
					article.setMr_image(rs.getString("mr_image"));
					article.setMr_subject(rs.getString("mr_subject"));
					article.setMr_up(rs.getInt("mr_up"));
					article.setMr_num(rs.getInt("mr_num"));
					
					articleList.add(article);
				} while (rs.next());
			}
			
		} catch (Exception s) {
			System.out.println("Exception : " + s);
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException s1) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException s2) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException s3) {
				}
		}
		return articleList;
	}

	//팝업 맛집정보에 들어갈 글 갯수 파악
	public int getPopArticleCount(String stname) { 

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select count(*) from r_board where MR_HEADER=?");
			pstmt.setString(1, stname);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				x = rs.getInt(1);
			}

		} catch (Exception s) {
			System.out.println("Exception : " + s);
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException s1) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException s2) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException s3) {
				}
		}

		return x;
	}

	
}
