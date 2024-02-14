package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.oreilly.servlet.MultipartRequest;

public class I_BoardDAO { 

	private static I_BoardDAO instance = null;

	public I_BoardDAO() {

	}

	public static I_BoardDAO getInstance() {

		if (instance == null) {
			synchronized (I_BoardDAO.class) {
				instance = new I_BoardDAO();
			}
		}

		return instance;

	}

	public void insertArticle(I_BoardVO article) throws SQLException {

		Connection con = null;
		PreparedStatement pstmt = null;

		int num = article.getMi_num();

		int number = 0; // �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�떛�뙋�삕 �뜝�뙃�떆源띿삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕���뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕

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

	public int getArticleCount() { // �뜝�룞�삕泥� �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�뙣�냼�벝�삕 �뜝�룞�삕�뜝�룞�삕

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
		// �뜝�떙�궪�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�룜媛쒎뜝�룞�삕�뜝�룞�삕 �뜝�떙�븘釉앹삕�뜝�룞�삕 �뜝�뙣�냼�뱶瑜� �뜝�룞�삕�뜝�룞�삕�뜝�떥�벝�삕�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕(�뜝�떙�궪�삕�뜝�룞�삕�뜝�룞�삕-what, �뜝�떙�궪�삕�뜝�룞�삕�뜝�룞�삕-content�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕)

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

	public List<I_BoardVO> getArticles(int start, int end) { // board table�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�뙣�냼�뱶瑜� List�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕
		// �뜝�떙�궪�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�듃�뜝�룞�삕 �뜝�뙣�븘�슱�삕(what-�뜝�떙�궪�삕�뜝�룞�삕�뜝�룞�삕, content-�뜝�떙�궪�삕�뜝�룞�삕�뜝�룞�삕, start-�뜝�룞�삕�뜝�뙗諭꾩삕�샇, end-�뜝�룞�삕�뜝�룞�삕�샇)
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<I_BoardVO> articleList = null;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select * from (select rownum rmi_num, mi_num, mi_writer, mi_pass, mi_subject, "
							+ "mi_readcount, mi_content, mi_image, mi_postdate from (select * from i_board order by mi_num desc)) "
							+ "where rmi_num>= ? and rmi_num <= ?");

			pstmt.setInt(1, start); // �뜝�룞�삕�뜝�뙥�슱�삕 �뜝�룞�삕�뜝�룞�삕3
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				articleList = new ArrayList<I_BoardVO>(end - start + 1); // �뜝�룞�삕�뜝�뙥�슱�삕 �뜝�룞�삕�뜝�룞�삕4.

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

	public List<I_BoardVO> getArticles(String what, String content, int start, int end) { 

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

				articleList = new ArrayList<I_BoardVO>(end - start + 1); // �뜝�룞�삕�뜝�뙥�슱�삕 �뜝�룞�삕�뜝�룞�삕4.

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

	public int updateArticle(I_BoardVO article) { 

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
			
			if (rs.next()) {
				dbpass = rs.getString("mi_pass");

				if (dbpass.equals(article.getMi_pass())) { // �뜝�룞�삕艅섇뜝�떕節륁삕�뜝占� �뜝�룞�삕移섇뜝�룞�삕 �뜝�룞�삕�뜝占� --> �뜝�룞�삕�뜝�룞�삕 泥섇뜝�룞�삕
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

	public int deleteArticle(int num, String id) { 

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbpass = "";
		String sql = "";

		int result = -1;

		try {

			con = ConnUtil.getConnection();

			pstmt = con.prepareStatement("select MI_WRITER from i_board where mi_num = ?");

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dbpass = rs.getString("MI_WRITER");

				if (dbpass.equals(id)) { 

					sql = "delete from i_board where mi_num=?";

					pstmt = con.prepareStatement(sql);

					pstmt.setInt(1, num);

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
	
	  
	   public int UpdateRecommand(int num) {
	      
	      int result=0;
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      
	      try {
	         con = ConnUtil.getConnection();
	         pstmt=con.prepareStatement("SELECT mi_RECOMMAND FROM i_board WHERE mi_num=?");
	         pstmt.setInt(1, num);
	         rs=pstmt.executeQuery();
	         
	         int recommand=0;
	         
	         while(rs.next()) {
	            recommand=rs.getInt("mi_RECOMMAND");
	         }
	         
	         pstmt=con.prepareStatement("UPDATE i_board SET mi_recommand=? WHERE mi_num=?");
	         
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
	   
	public int DeleteRecommand(int num) {
	      
	      int result=0;
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      
	      try {
	         con = ConnUtil.getConnection();
	         pstmt=con.prepareStatement("SELECT mi_RECOMMAND FROM i_board WHERE mi_num=?");
	         pstmt.setInt(1, num);
	         rs=pstmt.executeQuery();
	         
	         int recommand=0;
	         
	         while(rs.next()) {
	            recommand=rs.getInt("mi_RECOMMAND");
	         }
	         
	         pstmt=con.prepareStatement("UPDATE i_board SET mi_recommand=? WHERE mi_num=?");
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
	   
	
	public int Recommand(int num) {
	   
	   int recommand=0;
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   
	   try {
	      con = ConnUtil.getConnection();
	      pstmt=con.prepareStatement("SELECT mi_RECOMMAND FROM i_board WHERE mi_num=?");
	      pstmt.setInt(1, num);
	      rs=pstmt.executeQuery();
	      

	      
	      while(rs.next()) {
	         recommand=rs.getInt("mi_RECOMMAND");
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
