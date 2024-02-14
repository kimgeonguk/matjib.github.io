package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.oreilly.servlet.MultipartRequest;

public class BoardDAO { // �Խ��� �۾��� ��ɵ��� ������ �޼���

	private static BoardDAO instance = null;

	public BoardDAO() {

	}

	public static BoardDAO getInstance() {

		if (instance == null) {
			synchronized (BoardDAO.class) {
				instance = new BoardDAO();
			}
		}

		return instance;

	}

	public void insertArticle(I_BoardVO article) throws SQLException {

		Connection con = null;
		PreparedStatement pstmt = null;

		int num = article.getMi_num();

		int number = 0; // ���� ���̴� �Խñ��� ������ ��Ÿ���� ����

		String sql = "";

		try {

			con = ConnUtil.getConnection();

			sql = "insert into i_board(mi_num, mi_writer, mi_pass, mi_subject, mi_content, mi_image, mi_postdate) values(board_seq.nextval,?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, article.getMi_writer());
			pstmt.setString(2, article.getMi_pass());
			pstmt.setString(3, article.getMi_subject());
			pstmt.setString(4, article.getMi_content());
			pstmt.setString(5, article.getMi_image());
			pstmt.setTimestamp(6, article.getMi_postdate());

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

			pstmt = con.prepareStatement("select count(*) from i_board");

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

			pstmt = con.prepareStatement("select count(*) from i_board where " + what + " like '%" + content + "%'");

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

	public List<I_BoardVO> getArticles(int start, int end) { // board table���� ������ �޼ҵ带 List�� ����
		// �˻��� ������ ����Ʈ�� �޾ƿ�(what-�˻�����, content-�˻�����, start-���۹�ȣ, end-����ȣ)
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<I_BoardVO> articleList = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select * from (select rownum rmi_num, mi_num, mi_writer, mi_pass, mi_subject, "
							+ "mi_readcount, mi_content, mi_image, mi_postdate from (select * from i_board order by mi_num desc)) "
							+ "where rmi_num>= ? and rmi_num <= ?");

			pstmt.setInt(1, start); // ���߿� ����3
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				articleList = new ArrayList<I_BoardVO>(end - start + 1); // ���߿� ����4.

				do {

					I_BoardVO article = new I_BoardVO();
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

	public List<I_BoardVO> getArticles(String what, String content, int start, int end) { // board table���� ������ �޼ҵ带
		// List�� ���� -> ���߿� ����1 �˻��� ������ ����Ʈ�ι޾ƿ�(what-�˻�����, content-�˻�����,
		// start-���۹�ȣ,end-����ȣ)

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<I_BoardVO> articleList = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement(
					"select * from (select rownum rmi_num, mi_num, mi_writer, mi_pass, mi_subject, mi_readcount, "
							+ "mi_content, mi_image, mi_postdate from (select * from i_board where " + what + " like '%"+ content + "%' )) "
							+ "where rmi_num>=? and rmi_num<=?");

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				articleList = new ArrayList<I_BoardVO>(end - start + 1); // ���߿� ����4.

				do {

					I_BoardVO article = new I_BoardVO();
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

	public I_BoardVO getArticle(int num) {
		// �� ������ ������ �� ������ �� �� �ֵ��� �ϴ� �޼ҵ� ����. ���� num�� �Ű������� �Ͽ� �ϳ��� �ۿ� ���� ���������� DB���� ������
		// �޼���

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		I_BoardVO article = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("update i_board set mi_readcount = mi_readcount+1 where mi_num=?");

			pstmt.setInt(1, num);

			pstmt.executeUpdate();

			pstmt = con.prepareStatement("select * from i_board where mi_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				article = new I_BoardVO();

				article.setMi_num(rs.getInt("mi_num"));
				article.setMi_writer(rs.getString("mi_writer"));
				article.setMi_pass(rs.getString("mi_pass"));
				article.setMi_subject(rs.getString("mi_subject"));
				article.setMi_readcount(rs.getInt("mi_readcount"));
				article.setMi_content(rs.getString("mi_content"));
				article.setMi_image(rs.getString("mi_image"));
				article.setMi_postdate(rs.getTimestamp("mi_postdate"));

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

	public I_BoardVO updateGetArticle(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		I_BoardVO article = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select * from i_board where mi_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				article = new I_BoardVO();

				article.setMi_num(rs.getInt("mi_num"));
				article.setMi_writer(rs.getString("mi_writer"));
				article.setMi_pass(rs.getString("mi_pass"));
				article.setMi_subject(rs.getString("mi_subject"));
				article.setMi_readcount(rs.getInt("mi_readcount"));
				article.setMi_image(rs.getString("mi_image"));
				article.setMi_content(rs.getString("mi_content"));
				article.setMi_postdate(rs.getTimestamp("mi_postdate"));
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

	public int updateArticle(I_BoardVO article) { // �����ͺ��̽����� ���� ���� ó���� �ǵ��� �޼��屸��.(���� ���� ��쿡�� -1��ȯ, ���� ������ 1��ȯ, ���� ���н� 0
													// ��ȯ

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbpass = "";
		String sql = "";

		int result = -1;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select mi_pass from i_board where mi_writer = ?");

			pstmt.setString(1, article.getMi_writer());

			rs = pstmt.executeQuery();
			// ��������� ����
			if (rs.next()) {
				dbpass = rs.getString("mi_pass");

				if (dbpass.equals(article.getMi_pass())) { // ��й�ȣ�� ��ġ�� ��� --> ���� ó��
					sql = "update i_board set  mi_subject=?, mi_content=?, mi_image=?, mi_postdate=? where mi_writer=?";

					pstmt = con.prepareStatement(sql);

					pstmt.setString(1, article.getMi_subject());
					pstmt.setString(2, article.getMi_content());
					pstmt.setString(3, article.getMi_image());
					pstmt.setTimestamp(4, article.getMi_postdate());
					pstmt.setString(5, article.getMi_writer());
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

	public int deleteArticle(int num, String pass) { // �� ���� ó���� �޼��� ����(DB������й�ȣ�� ���Ͽ� ����)

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbpass = "";
		String sql = "";

		int result = -1;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select mi_pass from i_board where mi_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dbpass = rs.getString("mi_pass");

				if (dbpass.equals(pass)) { // ��й�ȣ�� ��ġ�� ��� --> ���� ó��

					sql = "delete from i_board where mi_num=?";

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
