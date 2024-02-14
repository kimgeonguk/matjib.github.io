package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.oreilly.servlet.MultipartRequest;

public class F_BoardDAO { // �Խ��� �۾��� ��ɵ��� ������ �޼���

	private static F_BoardDAO instance = null;

	public F_BoardDAO() {

	}

	public static F_BoardDAO getInstance() {

		if (instance == null) {
			synchronized (F_BoardDAO.class) {
				instance = new F_BoardDAO();
			}
		}

		return instance;

	}

	public void insertArticle(F_BoardVO article) throws SQLException {

		Connection con = null;
		PreparedStatement pstmt = null;

		int num = article.getMf_num();

		int number = 0; // ���� ���̴� �Խñ��� ������ ��Ÿ���� ����

		String sql = "";

		try {

			con = ConnUtil.getConnection();

			sql = "insert into f_board(mf_num, mf_writer, mf_pass, mf_subject, mf_content, mf_image, mf_postdate) values(board_seq.nextval,?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, article.getMf_writer());
			pstmt.setString(2, article.getMf_pass());
			pstmt.setString(3, article.getMf_subject());
			pstmt.setString(4, article.getMf_content());
			pstmt.setString(5, article.getMf_image());
			pstmt.setTimestamp(6, article.getMf_postdate());

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

	public int getArticleCount() { // ��ü ���� ������ ������ �޼ҵ� ����

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select count(*) from f_board");

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
		// �˻��� ������ ����� �˾ƺ��� �޼ҵ带 �����ε����� ����(�˻�����-what, �˻�����-content�� ��������)

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select count(*) from f_board where " + what + " like '%" + content + "%'");

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

	public List<F_BoardVO> getArticles(int start, int end) { // board table���� ������ �޼ҵ带 List�� ����
		// �˻��� ������ ����Ʈ�� �޾ƿ�(what-�˻�����, content-�˻�����, start-���۹�ȣ, end-����ȣ)
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<F_BoardVO> articleList = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select * from (select rownum rmf_num, mf_num, mf_writer, mf_pass, mf_subject, "
							+ "mf_readcount, mf_content, mf_image, mf_postdate from (select * from f_board order by mf_num desc)) "
							+ "where rmf_num>= ? and rmf_num <= ?");

			pstmt.setInt(1, start); // ���߿� ����3
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				articleList = new ArrayList<F_BoardVO>(end - start + 1); // ���߿� ����4.

				do {

					F_BoardVO article = new F_BoardVO();
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

	public List<F_BoardVO> getArticles(String what, String content, int start, int end) { // board table���� ������ �޼ҵ带
		// List�� ���� -> ���߿� ����1 �˻��� ������ ����Ʈ�ι޾ƿ�(what-�˻�����, content-�˻�����,
		// start-���۹�ȣ,end-����ȣ)

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<F_BoardVO> articleList = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement(
					"select * from (select rownum rmf_num, mf_num, mf_writer, mf_pass, mf_subject, mf_readcount, "
							+ "mf_content, mf_image, mf_postdate from (select * from f_board where " + what + " like '%"+ content + "%' )) "
							+ "where rmf_num>=? and rmf_num<=?");

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				articleList = new ArrayList<F_BoardVO>(end - start + 1); // ���߿� ����4.

				do {

					F_BoardVO article = new F_BoardVO();
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

	public F_BoardVO getArticle(int num) {
		// �� ������ ������ �� ������ �� �� �ֵ��� �ϴ� �޼ҵ� ����. ���� num�� �Ű������� �Ͽ� �ϳ��� �ۿ� ���� ���������� DB���� ������
		// �޼���

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		F_BoardVO article = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("update f_board set mf_readcount = mf_readcount+1 where mf_num=?");

			pstmt.setInt(1, num);

			pstmt.executeUpdate();

			pstmt = con.prepareStatement("select * from f_board where mf_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				article = new F_BoardVO();

				article.setMf_num(rs.getInt("mf_num"));
				article.setMf_writer(rs.getString("mf_writer"));
				article.setMf_pass(rs.getString("mf_pass"));
				article.setMf_subject(rs.getString("mf_subject"));
				article.setMf_readcount(rs.getInt("mf_readcount"));
				article.setMf_content(rs.getString("mf_content"));
				article.setMf_image(rs.getString("mf_image"));
				article.setMf_postdate(rs.getTimestamp("mf_postdate"));

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

	// �� �󼼺��� ȭ�鿡�� [�ۼ���]��ư�� ���� ��� updateForm.jsp�� �̵��ϵ��� ��ũ�� �ɾ �� ���� ȭ���� ���� ->
	// �ۼ����ÿ��� �۸�Ϻ���� �ٸ�����ȸ���� ������ų �ʿ� ����

	// ��ȸ���� ������Ű�� �κ��� �����ϰ� num�� �ش��ϴ� ���� �������� �޼��� ����

	public F_BoardVO updateGetArticle(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		F_BoardVO article = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select * from f_board where mf_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				article = new F_BoardVO();

				article.setMf_num(rs.getInt("mf_num"));
				article.setMf_writer(rs.getString("mf_writer"));
				article.setMf_pass(rs.getString("mf_pass"));
				article.setMf_subject(rs.getString("mf_subject"));
				article.setMf_readcount(rs.getInt("mf_readcount"));
				article.setMf_image(rs.getString("mf_image"));
				article.setMf_content(rs.getString("mf_content"));
				article.setMf_postdate(rs.getTimestamp("mf_postdate"));
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

	public int updateArticle(F_BoardVO article) { // �����ͺ��̽����� ���� ���� ó���� �ǵ��� �޼��屸��.(���� ���� ��쿡�� -1��ȯ, ���� ������ 1��ȯ, ���� ���н� 0
													// ��ȯ

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbpass = "";
		String sql = "";

		int result = -1;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select mf_pass from f_board where mf_writer = ?");

			pstmt.setString(1, article.getMf_writer());

			rs = pstmt.executeQuery();
			// ��������� ����
			if (rs.next()) {
				dbpass = rs.getString("mf_pass");

				if (dbpass.equals(article.getMf_pass())) { // ��й�ȣ�� ��ġ�� ��� --> ���� ó��
					sql = "update f_board set  mf_subject=?, mf_content=?, mf_image=?, mf_postdate=? where mf_writer=?";

					pstmt = con.prepareStatement(sql);

					pstmt.setString(1, article.getMf_subject());
					pstmt.setString(2, article.getMf_content());
					pstmt.setString(3, article.getMf_image());
					pstmt.setTimestamp(4, article.getMf_postdate());
					pstmt.setString(5, article.getMf_writer());
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

	public int deleteArticle(int num, String id) { // �� ���� ó���� �޼��� ����(DB������й�ȣ�� ���Ͽ� ����)

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbpass = "";
		String sql = "";

		int result = -1;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select MF_WRITER from f_board where mf_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dbpass = rs.getString("MF_WRITER");

				if (dbpass.equals(id)) { // ��й�ȣ�� ��ġ�� ��� --> ���� ó��

					sql = "delete from f_board where mf_num=?";

					pstmt = con.prepareStatement(sql);

					pstmt.setInt(1, num);

					pstmt.executeUpdate();

					result = 1; // ���� ����
				} else { // ��й�ȣ�� Ʋ���� ���
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

}
