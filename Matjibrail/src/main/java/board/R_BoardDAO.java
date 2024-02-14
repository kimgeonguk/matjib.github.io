package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.oreilly.servlet.MultipartRequest;

public class R_BoardDAO { // 占쌉쏙옙占쏙옙 占쌜억옙占쏙옙 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙 占쌨쇽옙占쏙옙

	private static R_BoardDAO instance = null;

	public R_BoardDAO() {

	}

	public static R_BoardDAO getInstance() {

		if (instance == null) {
			synchronized (R_BoardDAO.class) {
				instance = new R_BoardDAO();
			}
		}

		return instance;

	}

	public void insertArticle(R_BoardVO article) throws SQLException {

		Connection con = null;
		PreparedStatement pstmt = null;

		int num = article.getMr_num();

		int number = 0; // 占쏙옙占쏙옙 占쏙옙占싱댐옙 占쌉시깍옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙타占쏙옙占쏙옙 占쏙옙占쏙옙

		String sql = "";

		try {

			con = ConnUtil.getConnection();

			sql = "insert into r_board(mr_num, mr_writer, mr_pass, mr_subject, mr_bcheck, mr_header, mr_content, mr_image, mr_postdate) values(board_seq.nextval,?,?,?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, article.getMr_writer());
			pstmt.setString(2, article.getMr_pass());
			pstmt.setString(3, article.getMr_subject());
			pstmt.setInt(4, article.getMr_bcheck());
			pstmt.setString(5, article.getMr_header());
			pstmt.setString(6, article.getMr_content());
			pstmt.setString(7, article.getMr_image());
			pstmt.setTimestamp(8, article.getMr_postdate());

			pstmt.executeUpdate();
		} catch (Exception s) {
			System.out.println("Exception : " + s);
		} finally {
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

	}

	public int getArticleCount() { // 占쏙옙체 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌨소듸옙 占쏙옙占쏙옙

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select count(*) from r_board");

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

	public int getArticleCount(String what, String content) {
		// 占싯삼옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏘개占쏙옙占쏙옙 占싯아븝옙占쏙옙 占쌨소드를 占쏙옙占쏙옙占싸듸옙占쏙옙占쏙옙 占쏙옙占쏙옙(占싯삼옙占쏙옙占쏙옙-what, 占싯삼옙占쏙옙占쏙옙-content占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙)

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select count(*) from r_board where " + what + " like '%" + content + "%'");

			
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
	
	
	public int getArticleCount(String content) {
		// 占쏙옙占쌈몌옙占쏙옙 占싯삼옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏘개占쏙옙占쏙옙 占싯아븝옙占쏙옙 占쌨소드를 占쏙옙占쏙옙占싸듸옙占쏙옙占쏙옙 占쏙옙占쏙옙(占싯삼옙占쏙옙占쏙옙-what, 占싯삼옙占쏙옙占쏙옙-content占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙)
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int x = 0;
		
		try {
			
			con = ConnUtil.getConnection();
			
			pstmt = con.prepareStatement("select count(*) from r_board where mr_header  like '%" + content + "%'");
			
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
	
	
	public int getArticleCount(int bcheck) {
		// 占쏙옙占쌈몌옙占쏙옙 占싯삼옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏘개占쏙옙占쏙옙 占싯아븝옙占쏙옙 占쌨소드를 占쏙옙占쏙옙占싸듸옙占쏙옙占쏙옙 占쏙옙占쏙옙(占싯삼옙占쏙옙占쏙옙-what, 占싯삼옙占쏙옙占쏙옙-content占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙)
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int x = 0;
		
		try {
			
			con = ConnUtil.getConnection();
			
			pstmt = con.prepareStatement("select count(*) from r_board where mr_bcheck=" + bcheck);
			
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

	public List<R_BoardVO> getArticles(int start, int end) { // board table占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌨소드를 List占쏙옙 占쏙옙占쏙옙
		// 占싯삼옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙트占쏙옙 占쌨아울옙(what-占싯삼옙占쏙옙占쏙옙, content-占싯삼옙占쏙옙占쏙옙, start-占쏙옙占쌜뱄옙호, end-占쏙옙占쏙옙호)
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<R_BoardVO> articleList = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select * from (select rownum rmr_num, mr_num, mr_writer, mr_pass, mr_subject, "
							+ "mr_readcount, mr_content, mr_image, mr_up, mr_header, mr_bcheck, mr_postdate from (select * from r_board order by mr_num desc)) "
							+ "where rmr_num>= ? and rmr_num <= ?");

			pstmt.setInt(1, start); // 占쏙옙占쌩울옙 占쏙옙占쏙옙3
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				articleList = new ArrayList<R_BoardVO>(end - start + 1); // 占쏙옙占쌩울옙 占쏙옙占쏙옙4.

				do {

					R_BoardVO article = new R_BoardVO();
					article.setMr_num(rs.getInt("mr_num"));
					article.setMr_header(rs.getString("mr_header"));
					article.setMr_writer(rs.getString("mr_writer"));
					article.setMr_pass(rs.getString("mr_pass"));
					article.setMr_subject(rs.getString("mr_subject"));
					article.setMr_readcount(rs.getInt("mr_readcount"));
					article.setMr_content(rs.getString("mr_content"));
					article.setMr_image(rs.getString("mr_image"));
					article.setMr_bcheck(rs.getInt("mr_bcheck"));
					article.setMr_postdate(rs.getTimestamp("mr_postdate"));
					article.setMr_up(rs.getInt("mr_up"));
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

	public List<R_BoardVO> getArticles(String header, int start, int end) { // board table占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌨소드를
		// List占쏙옙 占쏙옙占쏙옙 -> 占쏙옙占쌩울옙 占쏙옙占쏙옙1 占싯삼옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙트占싸받아울옙(what-占싯삼옙占쏙옙占쏙옙, content-占싯삼옙占쏙옙占쏙옙,
		// start-占쏙옙占쌜뱄옙호,end-占쏙옙占쏙옙호)

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<R_BoardVO> articleList = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement(
					"select * from (select rownum rmr_num, mr_num, mr_writer, mr_pass, mr_subject, mr_readcount, "
												+ "mr_content, mr_image, mr_up, mr_header,mr_bcheck, mr_postdate from (select * from r_board where mr_header like '%"+ header + "%' order by mr_num desc )) "
												+ "where rmr_num>=? and rmr_num<=?");

			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();

			if (rs.next()) {

				articleList = new ArrayList<R_BoardVO>(end - start + 1); // 占쏙옙占쌩울옙 占쏙옙占쏙옙4.

				do {

					R_BoardVO article = new R_BoardVO();
					article.setMr_num(rs.getInt("mr_num"));
					article.setMr_header(rs.getString("mr_header"));
					article.setMr_writer(rs.getString("mr_writer"));
					article.setMr_pass(rs.getString("mr_pass"));
					article.setMr_subject(rs.getString("mr_subject"));
					article.setMr_readcount(rs.getInt("mr_readcount"));
					article.setMr_content(rs.getString("mr_content"));
					article.setMr_image(rs.getString("mr_image"));
					article.setMr_bcheck(rs.getInt("mr_bcheck"));
					article.setMr_postdate(rs.getTimestamp("mr_postdate"));
					article.setMr_up(rs.getInt("mr_up"));

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
	
	
	public List<R_BoardVO> getArticles(String what, String content, int start, int end) { // board table占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌨소드를
		// List占쏙옙 占쏙옙占쏙옙 -> 占쏙옙占쌈몌옙占쏙옙 占싯삼옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙트占싸받아울옙(what-占싯삼옙占쏙옙占쏙옙, content-占싯삼옙占쏙옙占쏙옙,
		// start-占쏙옙占쌜뱄옙호,end-占쏙옙占쏙옙호)
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<R_BoardVO> articleList = null;
		
		try {
			
			con = ConnUtil.getConnection();
			
			pstmt = con.prepareStatement(
					"select * from (select rownum rmr_num, mr_num, mr_writer, mr_pass, mr_subject, mr_readcount, "
							+ "mr_content, mr_image, mr_up, mr_header,mr_bcheck, mr_postdate from (select * from r_board where " + what + " like '%"+ content + "%' order by mr_num desc )) "
							+ "where rmr_num>=? and rmr_num<=?");
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				articleList = new ArrayList<R_BoardVO>(end - start + 1); // 占쏙옙占쌩울옙 占쏙옙占쏙옙4.
				
				do {
					
					R_BoardVO article = new R_BoardVO();
					article.setMr_num(rs.getInt("mr_num"));
					article.setMr_header(rs.getString("mr_header"));
					article.setMr_writer(rs.getString("mr_writer"));
					article.setMr_pass(rs.getString("mr_pass"));
					article.setMr_subject(rs.getString("mr_subject"));
					article.setMr_readcount(rs.getInt("mr_readcount"));
					article.setMr_content(rs.getString("mr_content"));
					article.setMr_image(rs.getString("mr_image"));
					article.setMr_bcheck(rs.getInt("mr_bcheck"));
					article.setMr_postdate(rs.getTimestamp("mr_postdate"));
					article.setMr_up(rs.getInt("mr_up"));
					
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

	public R_BoardVO getArticle(int num) {
		// 占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙 占쏙옙 占쌍듸옙占쏙옙 占싹댐옙 占쌨소듸옙 占쏙옙占쏙옙. 占쏙옙占쏙옙 num占쏙옙 占신곤옙占쏙옙占쏙옙占쏙옙 占싹울옙 占싹놂옙占쏙옙 占쌜울옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 DB占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
		// 占쌨쇽옙占쏙옙

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		R_BoardVO article = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("update r_board set mr_readcount = mr_readcount+1 where mr_num=?");

			pstmt.setInt(1, num);

			pstmt.executeUpdate();

			pstmt = con.prepareStatement("select * from r_board where mr_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				article = new R_BoardVO();

				article.setMr_num(rs.getInt("mr_num"));
				article.setMr_writer(rs.getString("mr_writer"));
				article.setMr_pass(rs.getString("mr_pass"));
				article.setMr_subject(rs.getString("mr_subject"));
				article.setMr_readcount(rs.getInt("mr_readcount"));
				article.setMr_content(rs.getString("mr_content"));
				article.setMr_image(rs.getString("mr_image"));
				article.setMr_postdate(rs.getTimestamp("mr_postdate"));
				article.setMr_up(rs.getInt("mr_up"));

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
		return article;
	}

	// 占쏙옙 占쏢세븝옙占쏙옙 화占썽에占쏙옙 [占쌜쇽옙占쏙옙]占쏙옙튼占쏙옙 占쏙옙占쏙옙 占쏙옙占� updateForm.jsp占쏙옙 占싱듸옙占싹듸옙占쏙옙 占쏙옙크占쏙옙 占심어서 占쏙옙 占쏙옙占쏙옙 화占쏙옙占쏙옙 占쏙옙占쏙옙 ->
	// 占쌜쇽옙占쏙옙占시울옙占쏙옙 占쌜몌옙瞿占쏙옙占쏙옙 占쌕몌옙占쏙옙占쏙옙회占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙킬 占십울옙 占쏙옙占쏙옙

	// 占쏙옙회占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙키占쏙옙 占싸븝옙占쏙옙 占쏙옙占쏙옙占싹곤옙 num占쏙옙 占쌔댐옙占싹댐옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쌨쇽옙占쏙옙 占쏙옙占쏙옙

	public R_BoardVO updateGetArticle(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		R_BoardVO article = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select * from r_board where mr_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				article = new R_BoardVO();

				article.setMr_num(rs.getInt("mr_num"));
				article.setMr_writer(rs.getString("mr_writer"));
				article.setMr_pass(rs.getString("mr_pass"));
				article.setMr_subject(rs.getString("mr_subject"));
				article.setMr_readcount(rs.getInt("mr_readcount"));
				article.setMr_image(rs.getString("mr_image"));
				article.setMr_content(rs.getString("mr_content"));
				article.setMr_postdate(rs.getTimestamp("mr_postdate"));
				article.setMr_up(rs.getInt("mr_up"));
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
		return article;
	}

	public int updateArticle(R_BoardVO article) { // 占쏙옙占쏙옙占싶븝옙占싱쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙 처占쏙옙占쏙옙 占실듸옙占쏙옙 占쌨쇽옙占썲구占쏙옙.(占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙荑∽옙占� -1占쏙옙환, 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 1占쏙옙환, 占쏙옙占쏙옙 占쏙옙占싻쏙옙 0
													// 占쏙옙환

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbpass = "";
		String sql = "";

		int result = -1;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select mr_pass from r_board where mr_writer = ?");

			pstmt.setString(1, article.getMr_writer());

			rs = pstmt.executeQuery();
			// 占쏙옙占쏙옙占쏙옙占쏙옙占� 占쏙옙占쏙옙
			if (rs.next()) {
				dbpass = rs.getString("mr_pass");

				if (dbpass.equals(article.getMr_pass())) { // 占쏙옙橘占싫ｏ옙占� 占쏙옙치占쏙옙 占쏙옙占� --> 占쏙옙占쏙옙 처占쏙옙
					sql = "update r_board set  mr_subject=?, mr_content=?, mr_image=?, mr_postdate=? where mr_writer=?";

					pstmt = con.prepareStatement(sql);

					pstmt.setString(1, article.getMr_subject());
					pstmt.setString(2, article.getMr_content());
					pstmt.setString(3, article.getMr_image());
					pstmt.setTimestamp(4, article.getMr_postdate());
					pstmt.setString(5, article.getMr_writer());
					pstmt.executeUpdate();

					result = 1;

				} else {
					result = 0;
				}

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
		return result;
	}

	public int deleteArticle(int num, String id) { // 占쏙옙 占쏙옙占쏙옙 처占쏙옙占쏙옙 占쌨쇽옙占쏙옙 占쏙옙占쏙옙(DB占쏙옙占쏙옙占쏙옙橘占싫ｏ옙占� 占쏙옙占싹울옙 占쏙옙占쏙옙)

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbpass = "";
		String sql = "";

		int result = -1;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select MR_WRITER from r_board where mr_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dbpass = rs.getString("MR_WRITER");

				if (dbpass.equals(id)) { // 占쏙옙橘占싫ｏ옙占� 占쏙옙치占쏙옙 占쏙옙占� --> 占쏙옙占쏙옙 처占쏙옙

					sql = "delete from r_board where mr_num=?";

					pstmt = con.prepareStatement(sql);

					pstmt.setInt(1, num);

					pstmt.executeUpdate();

					result = 1; // 占쏙옙占쏙옙 占쏙옙占쏙옙
				} else { // 占쏙옙橘占싫ｏ옙占� 틀占쏙옙占쏙옙 占쏙옙占�
					result = 0;
				}

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

		return result;

	}
	
	
	
	   // 異붿쿇�븯湲�
	   public int UpdateRecommend(int num) {
	      
	      int result=0;
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      
	      try {
	         con = ConnUtil.getConnection();
	         pstmt=con.prepareStatement("SELECT mr_up FROM r_board WHERE mr_num=?");
	         pstmt.setInt(1, num);
	         rs=pstmt.executeQuery();
	         
	         int recommand=0;
	         
	         while(rs.next()) {
	            recommand=rs.getInt("mr_up");
	         }
	         
	         pstmt=con.prepareStatement("UPDATE r_board SET mr_up=? WHERE mr_num=?");
	         
	         pstmt.setInt(1, recommand+1);
	         pstmt.setInt(2, num);
	         result=pstmt.executeUpdate();
	      }catch(Exception e) {
	         e.printStackTrace();
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
	      
	      return result;
	   }
	   
	public int DeleteRecommend(int num) {
	      
	      int result=0;
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      
	      try {
	         con = ConnUtil.getConnection();
	         pstmt=con.prepareStatement("SELECT mr_up FROM r_board WHERE mr_num=?");
	         pstmt.setInt(1, num);
	         rs=pstmt.executeQuery();
	         
	         int recommand=0;
	         
	         while(rs.next()) {
	            recommand=rs.getInt("mr_up");
	         }
	         
	         pstmt=con.prepareStatement("UPDATE r_board SET mr_UP=? WHERE mr_num=?");
	         pstmt.setInt(1, recommand-1);
	         pstmt.setInt(2, num);
	         result=pstmt.executeUpdate();
	      }catch(Exception e) {
	         e.printStackTrace();
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
	      
	      return result;
	   }
	   
	   // 異붿쿇�닔 �솗�씤�븯湲� �뀉�뀆 異붿쿇�닔 議고쉶源뚯� 荑쇰━臾몄쓣 �뜥�빞�븯�떎�땲 �뀉�뀆;;;
	public int Recommend(int num) {
	   
	   int recommand=0;
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   
	   try {
	      con = ConnUtil.getConnection();
	      pstmt=con.prepareStatement("SELECT mr_up FROM r_board WHERE mr_num=?");
	      pstmt.setInt(1, num);
	      rs=pstmt.executeQuery();
	      

	      
	      while(rs.next()) {
	         recommand=rs.getInt("mr_up");
	      }
	   }catch(Exception e) {
	      e.printStackTrace();
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
	   
	   return recommand;
	}

	
	
}
