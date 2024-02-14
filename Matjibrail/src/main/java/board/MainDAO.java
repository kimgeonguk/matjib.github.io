package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MainDAO {

	private static MainDAO instance = null;

	public MainDAO() {

	}

	public static MainDAO getInstance() {

		if (instance == null) {
			synchronized (MainDAO.class) {
				instance = new MainDAO();
			}
		}

		return instance;

	}

	public int getArticleCount(String board, String what, String content) {
		// 검색한 내용이 몇개인지 알아보는 메소드를 오버로딩으로 구현(검색조건-what, 검색내용-content로 변수설정)
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {

			con = ConnUtil.getConnection();

			if (board.equals("i_board")) {
				if(what.equals("writer")) {
				pstmt = con.prepareStatement("select count(*) from i_board where mi_writer like '%" + content + "%'");
				rs = pstmt.executeQuery();

				if (rs.next()) {
					x = rs.getInt(1);
					}
				}
				else if(what.equals("subject")) {
					pstmt = con.prepareStatement("select count(*) from i_board where mi_subject like '%" + content + "%'");
					rs = pstmt.executeQuery();

					if (rs.next()) {
						x = rs.getInt(1);
						}
				}
				else if(what.equals("content")) {
					pstmt = con.prepareStatement("select count(*) from i_board where mi_content like '%" + content + "%'");
					rs = pstmt.executeQuery();

					if (rs.next()) {
						x = rs.getInt(1);
						}
				}
					
			}
			else if(board.equals("f_board")) {
				if(what.equals("writer")) {
				pstmt = con.prepareStatement("select count(*) from f_board where mf_writer like '%" + content + "%'");
				
				rs = pstmt.executeQuery();

				if (rs.next()) {
					x = rs.getInt(1);
				}
				}
				else if(what.equals("subject")){
					pstmt = con.prepareStatement("select count(*) from f_board where mf_subject like '%" + content + "%'");
					
					rs = pstmt.executeQuery();

					if (rs.next()) {
						x = rs.getInt(1);
					}
				}
				else if(what.equals("content")) {
					pstmt = con.prepareStatement("select count(*) from f_board where mf_content like '%" + content + "%'");
					
					rs = pstmt.executeQuery();

					if (rs.next()) {
						x = rs.getInt(1);
					}
				}
			}
			else if(board.equals("r_board")) {
				if(what.equals("writer")) {
				pstmt = con.prepareStatement("select count(*) from r_board where mr_writer like '%" + content + "%'");
				
				rs = pstmt.executeQuery();

				if (rs.next()) {
					x = rs.getInt(1);
				}
				}
				else if(what.equals("subject")) {
					pstmt = con.prepareStatement("select count(*) from r_board where mr_subject like '%" + content + "%'");
					
					rs = pstmt.executeQuery();

					if (rs.next()) {
						x = rs.getInt(1);
					}
				}
				else if(what.equals("content")) {
					pstmt = con.prepareStatement("select count(*) from r_board where mr_content like '%" + content + "%'");
					
					rs = pstmt.executeQuery();

					if (rs.next()) {
						x = rs.getInt(1);
					}
				}
				else if(what.equals("header")) {
					pstmt = con.prepareStatement("select count(*) from r_board where mr_header like '%" + content + "%'");
					
					rs = pstmt.executeQuery();

					if (rs.next()) {
						x = rs.getInt(1);
					}
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

		return x;
	}

	public List<TotalVO> getArticles(String board, String what, String content, int start, int end) { // board table에서
																										// 가져올 메소드를
		// List로 구현 -> 말머리로 검색할 내용을 리스트로받아옴(what-검색조건, content-검색내용,
		// start-시작번호,end-끝번호)

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TotalVO> articleList = null;

		try {

			con = ConnUtil.getConnection();

			if (board.equals("i_board")) {
				if(what.equals("writer")) {
				pstmt = con.prepareStatement("select * from (select rownum rmi_num, mi_num, mi_writer, mi_pass, mi_subject, mi_readcount, "
								+ "mi_content, mi_image, mi_postdate from (select * from i_board where mi_writer like '%" + content + "%' )) "
								+ "where rmi_num>=? and rmi_num<=?");
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();

				if (rs.next()) {

					articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

					do {

						TotalVO article = new TotalVO();
						article.setMi_num(rs.getInt("mi_num"));
						article.setMi_writer(rs.getString("mi_writer"));
						article.setMi_pass(rs.getString("mi_pass"));
						article.setMi_subject(rs.getString("mi_subject"));
						article.setMi_readcount(rs.getInt("mi_readcount"));
						article.setMi_content(rs.getString("mi_content"));
						article.setMi_image(rs.getString("mi_image"));
						article.setMi_postdate(rs.getTimestamp("mi_postdate"));

						articleList.add(article);
					} while (rs.next());
				}
				}
				else if(what.equals("subject")) {
					pstmt = con.prepareStatement("select * from (select rownum rmi_num, mi_num, mi_writer, mi_pass, mi_subject, mi_readcount, "
							+ "mi_content, mi_image, mi_postdate from (select * from i_board where mi_subject like '%" + content + "%' )) "
							+ "where rmi_num>=? and rmi_num<=?");
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

				do {

					TotalVO article = new TotalVO();
					article.setMi_num(rs.getInt("mi_num"));
					article.setMi_writer(rs.getString("mi_writer"));
					article.setMi_pass(rs.getString("mi_pass"));
					article.setMi_subject(rs.getString("mi_subject"));
					article.setMi_readcount(rs.getInt("mi_readcount"));
					article.setMi_content(rs.getString("mi_content"));
					article.setMi_image(rs.getString("mi_image"));
					article.setMi_postdate(rs.getTimestamp("mi_postdate"));

					articleList.add(article);
				} while (rs.next());
			}
				}
				else if(what.equals("content")) {
					pstmt = con.prepareStatement("select * from (select rownum rmi_num, mi_num, mi_writer, mi_pass, mi_subject, mi_readcount, "
							+ "mi_content, mi_image, mi_postdate from (select * from i_board where mi_content like '%" + content + "%' )) "
							+ "where rmi_num>=? and rmi_num<=?");
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

				do {

					TotalVO article = new TotalVO();
					article.setMi_num(rs.getInt("mi_num"));
					article.setMi_writer(rs.getString("mi_writer"));
					article.setMi_pass(rs.getString("mi_pass"));
					article.setMi_subject(rs.getString("mi_subject"));
					article.setMi_readcount(rs.getInt("mi_readcount"));
					article.setMi_content(rs.getString("mi_content"));
					article.setMi_image(rs.getString("mi_image"));
					article.setMi_postdate(rs.getTimestamp("mi_postdate"));

					articleList.add(article);
				} while (rs.next());
			}
				}
			}

			else if (board.equals("f_board")) {
				if(what.equals("writer")) {
				pstmt = con.prepareStatement(
						"select * from (select rownum rmf_num, mf_num, mf_writer, mf_pass, mf_subject, mf_readcount, "
								+ "mf_content, mf_image, mf_postdate from (select * from f_board where mf_writer like '%" + content + "%' )) "
								+ "where rmf_num>=? and rmf_num<=?");
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);

				rs = pstmt.executeQuery();

				if (rs.next()) {

					articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

					do {

						TotalVO article = new TotalVO();
						article.setMf_num(rs.getInt("mf_num"));
						article.setMf_writer(rs.getString("mf_writer"));
						article.setMf_pass(rs.getString("mf_pass"));
						article.setMf_subject(rs.getString("mf_subject"));
						article.setMf_readcount(rs.getInt("mf_readcount"));
						article.setMf_content(rs.getString("mf_content"));
						article.setMf_image(rs.getString("mf_image"));
						article.setMf_postdate(rs.getTimestamp("mf_postdate"));

						articleList.add(article);
					} while (rs.next());
				}
				}
				else if(what.equals("subject")) {
					pstmt = con.prepareStatement(
							"select * from (select rownum rmf_num, mf_num, mf_writer, mf_pass, mf_subject, mf_readcount, "
									+ "mf_content, mf_image, mf_postdate from (select * from f_board where mf_subject like '%" + content + "%' )) "
									+ "where rmf_num>=? and rmf_num<=?");
					
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);

					rs = pstmt.executeQuery();

					if (rs.next()) {

						articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

						do {

							TotalVO article = new TotalVO();
							article.setMf_num(rs.getInt("mf_num"));
							article.setMf_writer(rs.getString("mf_writer"));
							article.setMf_pass(rs.getString("mf_pass"));
							article.setMf_subject(rs.getString("mf_subject"));
							article.setMf_readcount(rs.getInt("mf_readcount"));
							article.setMf_content(rs.getString("mf_content"));
							article.setMf_image(rs.getString("mf_image"));
							article.setMf_postdate(rs.getTimestamp("mf_postdate"));

							articleList.add(article);
						} while (rs.next());
					}
				}
				else if(what.equals("content")) {
					pstmt = con.prepareStatement(
							"select * from (select rownum rmf_num, mf_num, mf_writer, mf_pass, mf_subject, mf_readcount, "
									+ "mf_content, mf_image, mf_postdate from (select * from f_board where mf_content like '%" + content + "%' )) "
									+ "where rmf_num>=? and rmf_num<=?");
					
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);

					rs = pstmt.executeQuery();

					if (rs.next()) {

						articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

						do {

							TotalVO article = new TotalVO();
							article.setMf_num(rs.getInt("mf_num"));
							article.setMf_writer(rs.getString("mf_writer"));
							article.setMf_pass(rs.getString("mf_pass"));
							article.setMf_subject(rs.getString("mf_subject"));
							article.setMf_readcount(rs.getInt("mf_readcount"));
							article.setMf_content(rs.getString("mf_content"));
							article.setMf_image(rs.getString("mf_image"));
							article.setMf_postdate(rs.getTimestamp("mf_postdate"));

							articleList.add(article);
						} while (rs.next());
					}
				}
			}

			else if (board.equals("r_board")) {
				if(what.equals("writer")) {
				pstmt = con.prepareStatement(
						"select * from (select rownum rmr_num, mr_num, mr_writer, mr_pass, mr_subject, mr_readcount, "
								+ "mr_content, mr_image, mr_up, mr_header, mr_bcheck, mr_postdate from (select * from r_board where mr_writer like '%"
								+ content + "%' order by mr_num desc )) where rmr_num>=? and rmr_num<=?");
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				rs = pstmt.executeQuery();

				if (rs.next()) {

					articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

					do {

						TotalVO article = new TotalVO();
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

						articleList.add(article);
					} while (rs.next());
				}
				}
				else if(what.equals("subject")) {
					pstmt = con.prepareStatement(
							"select * from (select rownum rmr_num, mr_num, mr_writer, mr_pass, mr_subject, mr_readcount, "
									+ "mr_content, mr_image, mr_up, mr_header, mr_bcheck, mr_postdate from (select * from r_board where mr_subject like '%"
									+ content + "%' order by mr_num desc )) where rmr_num>=? and rmr_num<=?");
					
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);
					
					rs = pstmt.executeQuery();

					if (rs.next()) {

						articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

						do {

							TotalVO article = new TotalVO();
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

							articleList.add(article);
						} while (rs.next());
					}
				}
				else if(what.equals("content")) {
					pstmt = con.prepareStatement(
							"select * from (select rownum rmr_num, mr_num, mr_writer, mr_pass, mr_subject, mr_readcount, "
									+ "mr_content, mr_image, mr_up, mr_header, mr_bcheck, mr_postdate from (select * from r_board where mr_content like '%"
									+ content + "%' order by mr_num desc )) where rmr_num>=? and rmr_num<=?");
					
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);
					
					rs = pstmt.executeQuery();

					if (rs.next()) {

						articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

						do {

							TotalVO article = new TotalVO();
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

							articleList.add(article);
						} while (rs.next());
					}
				}
				else if(what.equals("header")) {
					pstmt = con.prepareStatement(
							"select * from (select rownum rmr_num, mr_num, mr_writer, mr_pass, mr_subject, mr_readcount, "
									+ "mr_content, mr_image, mr_up, mr_header, mr_bcheck, mr_postdate from (select * from r_board where mr_header like '%"
									+ content + "%' order by mr_num desc )) where rmr_num>=? and rmr_num<=?");
					
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);
					
					rs = pstmt.executeQuery();

					if (rs.next()) {

						articleList = new ArrayList<TotalVO>(end - start + 1); // 나중에 수정4.

						do {

							TotalVO article = new TotalVO();
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

							articleList.add(article);
						} while (rs.next());
					}
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
		return articleList;
	}
}
