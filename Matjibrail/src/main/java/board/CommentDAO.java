package board;
import java.sql.*;
import java.util.*;

public class CommentDAO {
   private static CommentDAO instance = null;
   
   public CommentDAO() {}
   
   public static CommentDAO getInstance() {
      
      if(instance == null) {
         synchronized (CommentDAO.class) {
            instance = new CommentDAO();
         }
      }
      return instance;
   }
   
   // 占싱곤옙占쏙옙 占쌉쏙옙占쏙옙 占쌜억옙占쏙옙 占쏙옙占쏙옙占� 占싹놂옙占싹놂옙 占쌨소듸옙占� 占쌩곤옙占싹몌옙 占쏙옙
   public void insertArticle(CommentVO article) {
      
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      int num = article.getNum();
      int ref = article.getRef();
      int step = article.getStep();
      int depth = article.getDepth();
      
      int number = 0;
      
      String sql = "";
      
      try {
         con = ConnUtil.getConnection();
         pstmt = con.prepareStatement("select max(num) from comments");
         rs = pstmt.executeQuery();
         
         if(rs.next()) number = rs.getInt(1)+1;//占쏙옙占쏙옙
         else number = 1;//占쏙옙占쏙옙占쏙옙 占싣댐옙 占쏙옙占�
         
         if(num != 0) {//  占썰변占쏙옙占싹곤옙占�
            sql = "update comments set step=step+1 where ref=? and step > ?";
            pstmt = con.prepareStatement(sql);
            
            pstmt.setInt(1, ref);
            pstmt.setInt(2, step);
            
            pstmt.executeUpdate();
            
            step = step+1;
            depth = depth+1;
         }else {// 占쏙옙占쏙옙占쏙옙 占쏙옙占�
            ref=number;
            step=0;
            depth=0;
         }
         // 占쏙옙占쏙옙占쏙옙 占쌩곤옙占싹댐옙 占쏙옙占쏙옙 占쌜쇽옙
         sql = "insert into comments(num, writer, email, subject, pass, regdate,"
               +" ref, step, depth, content, c_num)"
               +"values(comments_seq.nextval,?,?,?,?,?,?,?,?,?,?)";

         
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, article.getWriter());
         pstmt.setString(2, article.getEmail());
         pstmt.setString(3, article.getSubject());
         pstmt.setString(4, article.getPass());
         pstmt.setTimestamp(5, article.getRegdate());
         pstmt.setInt(6, ref);
         pstmt.setInt(7, step);
         pstmt.setInt(8, depth);
         pstmt.setString(9, article.getContent());
         pstmt.setInt(10, article.getC_num());
         
         pstmt.executeUpdate();
      
         
      }catch(Exception ex) {
         System.out.println("Exception" + ex);
      }finally {
         if(rs != null)
            try {
               rs.close();
            }catch(SQLException s1) {
               
            }
         if(pstmt != null)
            try {
               pstmt.close();
            }catch(SQLException s1) {
               
            }
         if(con != null)
            try {
               con.close();
            }catch(SQLException s1) {
               
            }
      }
   }
   
   // 占쏙옙체 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌨소듸옙 占쏙옙占쏙옙
   public int getArticleCount(int c_num) {
      
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      int x = 0;
      
      try {
         con = ConnUtil.getConnection();
         pstmt = con.prepareStatement("select count(*) from comments where c_num=?");
		pstmt.setInt(1, c_num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            x = rs.getInt(1);
         }
      }catch(Exception se) {
         System.out.println("Exception" +se);
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
      
      return x;
   }
   
   // 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙 占쏘개占쏙옙占쏙옙 占싯아븝옙占쏙옙 占쌨소듸옙(占싯삼옙占쏙옙占쏙옙(what), 占싯삼옙占쏙옙占쏙옙(content))
   public int getArticleCount(String what, String content) {
      
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      int x = 0;
      
      try {
         con = ConnUtil.getConnection();
         pstmt = con.prepareStatement("select count(*) from comments where "+what+" like '%"+content+"%'");
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            x = rs.getInt(1);
         }
      }catch(Exception se) {
         System.out.println("Exception" +se);
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
      
      return x;
   }
   
  
   public List<CommentVO> getArticles(int start, int end, int c_num) {   // 占쏙옙占쏙옙 1
      
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List<CommentVO> articleList = null;
      
      try {
         
         con = ConnUtil.getConnection();
      
         pstmt = con.prepareStatement(
               "select * from (select rownum rnum, num, writer, email, subject, pass, "
               + "regdate, readcount, ref, step, depth, content, c_num from "
               + "(select * from comments order by ref desc, step asc) ) where rnum >= ? and rnum <=? and c_num=? order by num asc");
         
         
//         pstmt=con.prepareStatement(
//                     "select * from(select rownum rnum, writer, email, subject, pass,"
//                      + "regdate,readcount, ref, step, depth, content, ip from "
//                      + "(select * from comments order by ref desc, step asc)) "
//                      + "where rnum >= ? and rnum <=?");
         
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         pstmt.setInt(3, c_num);
         
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            
            articleList = new ArrayList<CommentVO>(end - start+1);
            
            do {
               
               CommentVO article = new CommentVO();
               
               article.setNum(rs.getInt("num"));
               article.setWriter(rs.getString("writer"));
               article.setEmail(rs.getString("email"));
               article.setSubject(rs.getString("subject"));
               article.setPass(rs.getString("pass"));
               article.setRegdate(rs.getTimestamp("regdate"));
               article.setReadcount(rs.getInt("readcount"));
               article.setRef(rs.getInt("ref"));
               article.setStep(rs.getInt("step"));
               article.setDepth(rs.getInt("depth"));
               article.setContent(rs.getString("content"));
               article.setC_num(rs.getInt("c_num"));

               articleList.add(article);
               
            }while(rs.next());
         }
         
      }catch(Exception se) {
         System.out.println("Exception" +se);
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
      return articleList;
   }
   
   public List<CommentVO> getArticles(String what, String content, int start, int end)  {   // 占쏙옙占쏙옙 1
      
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List<CommentVO> articleList = null;
      // �닚�꽌 諛섎��룄 �빐蹂�
      try {
         
         con = ConnUtil.getConnection();
         // 占쏙옙占쏙옙2
         // pstmt = con.prepareStatement("select * from comments order by num desc");
         pstmt = con.prepareStatement(
               "select * from (select rownum rnum, num, writer, email, subject, pass, "
               + "regdate, readcount, ref, step, depth, content, c_num from "
               + "(select * from comments where "+what+" like '%"+content+"%'order by ref desc, step asc)) where rnum >= ? and rnum <=?");
         
         
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            
            articleList = new ArrayList<CommentVO>(end - start+1);
            
            do {
               
               CommentVO article = new CommentVO();
               
               article.setNum(rs.getInt("num"));
               article.setWriter(rs.getString("writer"));
               article.setEmail(rs.getString("email"));
               article.setSubject(rs.getString("subject"));
               article.setPass(rs.getString("pass"));
               article.setRegdate(rs.getTimestamp("regdate"));
               article.setReadcount(rs.getInt("readcount"));
               article.setRef(rs.getInt("ref"));
               article.setStep(rs.getInt("step"));
               article.setDepth(rs.getInt("depth"));
               article.setContent(rs.getString("content"));
               article.setC_num(rs.getInt("c_num"));

               articleList.add(article);
               
            }while(rs.next());
         }
         
      }catch(Exception se) {
         System.out.println("Exception" +se);
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
      return articleList;
   }
   
   /*
    * 占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쌍듸옙占쏙옙 占쌔억옙占쏙옙
    * 占쎌리占쏙옙 占쏙옙 num占쏙옙 占신곤옙占쏙옙占쏙옙占쏙옙 占쌔쇽옙 占싹놂옙占쏙옙 占쌜울옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占싶븝옙占싱쏙옙占쏙옙 占쏙옙占쏙옙占싶억옙占쏙옙
      占쏙옙占쏙옙占싶븝옙占싱쏙옙占쏙옙占쏙옙 占쏙옙 占싹놂옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌨소듸옙 占쏙옙占쏙옙
    */
   
   public CommentVO getArticle(int num, int c_num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      CommentVO article = null;
      
      try {
         
         con = ConnUtil.getConnection();
         pstmt = con.prepareStatement("update comments set readcount =readcount+1 where num=? and c_num=?");
         pstmt.setInt(1, num);
         pstmt.setInt(2, c_num);
         pstmt.executeUpdate();
         
         pstmt = con.prepareStatement("select * from comments where num=? and c_num=?");
         pstmt.setInt(1, num);
         pstmt.setInt(2, c_num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            article = new CommentVO();
            article.setNum(rs.getInt("num"));
            article.setWriter(rs.getString("writer"));
            article.setEmail(rs.getString("email"));
            article.setSubject(rs.getString("subject"));
            article.setPass(rs.getString("pass"));
            article.setRegdate(rs.getTimestamp("regdate"));
            article.setReadcount(rs.getInt("readcount"));
            article.setRef(rs.getInt("ref"));
            article.setStep(rs.getInt("step"));
            article.setDepth(rs.getInt("depth"));
            article.setContent(rs.getString("content"));
            article.setC_num(rs.getInt("c_num"));
         }
         
      }catch(Exception se) {
         System.out.println("Exception" +se);
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
      
      return article;
   }
   
   /*
    * 占쏙옙 占쏢세븝옙占쏙옙 화占썽에占쏙옙 占쏙옙 占쏙옙占쏙옙 占쏙옙튼占쏙옙 占쏙옙占쏙옙 占쏙옙占� updateForm.jsp占쏙옙 占싱듸옙占싹듸옙占쏙옙 占쏙옙크占쏙옙 占심억옙占쏙옙占실뤄옙
    * 占쏙옙 占쏙옙占쏙옙 화占쏙옙占쏙옙 占쏙옙占쏙옙占쌔억옙占쏙옙
    * 
    * 占쏙옙 占쏙옙占쏙옙 占시울옙占쏙옙 占쏙옙 占쏙옙占� 占쏙옙占쏙옙占� 占쌕몌옙占쏙옙 占쏙옙회占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占십요가 占쏙옙占쏙옙
    * 
    * 占쏙옙회占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙키占쏙옙 占싸븝옙占쏙옙 占쏙옙占쏙옙占싹곤옙 num占쏙옙 占쌔댐옙占싹댐옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쌨소듸옙 占쏙옙占쏙옙
    */
   
   public CommentVO updateGetArticle(int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      CommentVO article = null;
      
      try {
         
         con = ConnUtil.getConnection();
         pstmt = con.prepareStatement("select * from comments where num=?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            article = new CommentVO();
            article.setNum(rs.getInt("num"));
            article.setWriter(rs.getString("writer"));
            article.setEmail(rs.getString("email"));
            article.setSubject(rs.getString("subject"));
            article.setPass(rs.getString("pass"));
            article.setRegdate(rs.getTimestamp("regdate"));
            article.setReadcount(rs.getInt("readcount"));
            article.setRef(rs.getInt("ref"));
            article.setStep(rs.getInt("step"));
            article.setDepth(rs.getInt("depth"));
            article.setContent(rs.getString("content"));
         }
         
      }catch(Exception se) {
         System.out.println("Exception" +se);
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
      
      return article;
   }
   
   /*
    * 占쏙옙占쏙옙占싶븝옙占싱쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙 처占쏙옙占쏙옙 占실억옙占쏙옙占�
    * 占쏙옙占쏙옙 占쏙옙占쏙옙처占쏙옙 占쏙옙 占쌨소듸옙 占쏙옙占쏙옙
    */
   public int updateArticle(CommentVO article) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      String dbpasswd = "";
      String sql = "";
      
      int result = -1;
      try {
         con = ConnUtil.getConnection();
         pstmt = con.prepareStatement("select pass from comments where num=?");
         
         pstmt.setInt(1, article.getNum());
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            dbpasswd = rs.getString("pass");
            if(dbpasswd.equals(article.getPass())) {
            // 占쏙옙橘占싫ｏ옙占� 占쏙옙치占싹몌옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
               sql = "update comments set writer=?, email=?, subject=?, content=? where num=?";
               pstmt = con.prepareStatement(sql);
               
               pstmt.setString(1, article.getWriter());
               pstmt.setString(2, article.getEmail());
               pstmt.setString(3, article.getSubject());
               pstmt.setString(4, article.getContent());
               pstmt.setInt(5, article.getNum());
               
               pstmt.executeUpdate();
               result = 1;   // 占쏙옙占쏙옙占쏙옙占쏙옙
            }else {
               result = 0;
            }
         }
         
      }catch(Exception se) {
         System.out.println("Exception" +se);
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
   
   /*
    * 占쏙옙 占쏙옙占쏙옙 처占쏙옙
    * 
    * 占쏙옙占쏙옙占싶븝옙占싱쏙옙占쏙옙占쏙옙 占쏙옙橘占싫ｏ옙占� 占쏙옙占싹울옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쌨소드를 占쏙옙占쏙옙占쏙옙
    */
   public int deleteArticle(int num, String id) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      String dbid = "";
      String sql = "";
      
      int result = -1;
      try {
         con = ConnUtil.getConnection();
         pstmt = con.prepareStatement("select writer from comments where num=?");
         
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            dbid = rs.getString("writer");
            if(dbid.equals(id)) {
            // 占쏙옙橘占싫ｏ옙占� 占쏙옙치占싹몌옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
               sql = "delete from comments where num=?";
               pstmt = con.prepareStatement(sql);
               
               pstmt.setInt(1, num);
               
               pstmt.executeUpdate();
               result = 1;   // 占쏙옙占쏙옙 占쏙옙占쏙옙
            }else {
               result = 0;   // 占쏙옙橘占싫� 틀占쏙옙
            }
         }
         
      }catch(Exception se) {
         System.out.println("Exception" +se);
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
   
   
// 비번앖이 삭제가능하게 실행
	/*
	 * public int deleteMember(String id) { Connection con = null; PreparedStatement
	 * pstmt = null; ResultSet rs = null;
	 * 
	 * String dbPass = "";
	 * 
	 * int result = -1;
	 * 
	 * try { con = ConnUtil.getConnection(); String strQuery =
	 * "select id from member where id=?"; pstmt = con.prepareStatement(strQuery);
	 * 
	 * pstmt.setString(1, id); rs = pstmt.executeQuery();
	 * 
	 * if(rs.next()) { dbPass = rs.getString("id"); if(dbPass.equals(id)) { pstmt =
	 * con.prepareStatement("delete from member where id=?"); pstmt.setString(1,
	 * id); pstmt.executeUpdate();
	 * 
	 * result = 1; }else { result = 0; } } }catch(Exception ex) {
	 * System.out.println("Exception " + ex); }finally { if(rs != null) try {
	 * rs.close(); }catch(SQLException s1) {
	 * 
	 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s2) {
	 * 
	 * } if(con != null) try { con.close(); }catch(SQLException s3) {
	 * 
	 * } } return result; }
	 */
   
   
   
   
   
   
   
}










/*
 * package board; import java.sql.*; import java.util.*;
 * 
 * 
 * 
 * public class CommentDAO { private static CommentDAO instance = null;
 * 
 * public CommentDAO() {}
 * 
 * public static CommentDAO getInstance() {
 * 
 * if(instance == null) { synchronized (CommentDAO.class) { instance = new
 * CommentDAO(); } } return instance; }
 * 
 * 
 * public void insertArticle(CommentVO article) {
 * 
 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
 * 
 * int num = article.getNum(); int ref = article.getRef(); int step =
 * article.getStep(); int depth = article.getDepth();
 * 
 * int number = 0;
 * 
 * String sql = "";
 * 
 * try { con = ConnUtil.getConnection(); pstmt =
 * con.prepareStatement("select max(num) from comments"); rs =
 * pstmt.executeQuery();
 * 
 * if(rs.next()) number = rs.getInt(1)+1;//占쏙옙占쏙옙 else number = 1;//占쏙옙占쏙옙占쏙옙 占싣댐옙 占쏙옙占�
 * 
 * if(num != 0) {// 占썰변占쏙옙占싹곤옙占� sql =
 * "update comments set step=step+1 where ref=? and step > ?"; pstmt =
 * con.prepareStatement(sql);
 * 
 * pstmt.setInt(1, ref); pstmt.setInt(2, step);
 * 
 * pstmt.executeUpdate();
 * 
 * step = step+1; depth = depth+1; }else {// 占쏙옙占쏙옙占쏙옙 占쏙옙占� ref=number; step=0;
 * depth=0; } // 占쏙옙占쏙옙占쏙옙 占쌩곤옙占싹댐옙 占쏙옙占쏙옙 占쌜쇽옙 sql =
 * "insert into comments(num, writer, email, subject, pass, regdate,"
 * +" ref, step, depth, content)"
 * +"values(comments_seq.nextval,?,?,?,?,?,?,?,?,?)";
 * 
 * 
 * pstmt = con.prepareStatement(sql); pstmt.setString(1, article.getWriter());
 * pstmt.setString(2, article.getEmail()); pstmt.setString(3,
 * article.getSubject()); pstmt.setString(4, article.getPass());
 * pstmt.setTimestamp(5, article.getRegdate()); pstmt.setInt(6, ref);
 * pstmt.setInt(7, step); pstmt.setInt(8, depth); pstmt.setString(9,
 * article.getContent());
 * 
 * pstmt.executeUpdate();
 * 
 * 
 * }catch(Exception ex) { System.out.println("Exception" + ex); }finally { if(rs
 * != null) try { rs.close(); }catch(SQLException s1) {
 * 
 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s1) {
 * 
 * } if(con != null) try { con.close(); }catch(SQLException s1) {
 * 
 * } } }
 * 
 * // 占쏙옙체 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌨소듸옙 占쏙옙占쏙옙 public int getArticleCount() {
 * 
 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
 * 
 * int x = 0;
 * 
 * try { con = ConnUtil.getConnection(); pstmt =
 * con.prepareStatement("select count(*) from comments"); rs =
 * pstmt.executeQuery();
 * 
 * if(rs.next()) { x = rs.getInt(1); } }catch(Exception se) {
 * System.out.println("Exception" +se); }finally { if(rs != null) try {
 * rs.close(); }catch(SQLException s1) {
 * 
 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s2) {
 * 
 * } if(con != null) try { con.close(); }catch(SQLException s3) {
 * 
 * } }
 * 
 * return x; }
 * 
 * // 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙 占쏘개占쏙옙占쏙옙 占싯아븝옙占쏙옙 占쌨소듸옙(占싯삼옙占쏙옙占쏙옙(what), 占싯삼옙占쏙옙占쏙옙(content)) public
 * int getArticleCount(String what, String content) {
 * 
 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
 * 
 * int x = 0;
 * 
 * try { con = ConnUtil.getConnection(); pstmt =
 * con.prepareStatement("select count(*) from comments where "+what+" like '%"
 * +content+"%'"); rs = pstmt.executeQuery();
 * 
 * if(rs.next()) { x = rs.getInt(1); } }catch(Exception se) {
 * System.out.println("Exception" +se); }finally { if(rs != null) try {
 * rs.close(); }catch(SQLException s1) {
 * 
 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s2) {
 * 
 * } if(con != null) try { con.close(); }catch(SQLException s3) {
 * 
 * } }
 * 
 * return x; }
 * 
 * 
 * public List<CommentVO> getArticles(int start, int end) {
 * 
 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
 * List<CommentVO> articleList = null;
 * 
 * try {
 * 
 * con = ConnUtil.getConnection(); // 占쏙옙占쏙옙2 // pstmt =
 * con.prepareStatement("select * from comments order by num desc"); pstmt =
 * con.prepareStatement(
 * "select * from (select rownum rnum, num, writer, email, subject, pass, " +
 * "regdate, readcount, ref, step, depth, content from " +
 * "(select * from comments order by ref desc, step asc)) where rnum >= ? and rnum <=?"
 * );
 * 
 * 
 * // pstmt=con.prepareStatement( //
 * "select * from(select rownum rnum, writer, email, subject, pass," // +
 * "regdate,readcount, ref, step, depth, content, ip from " // +
 * "(select * from comments order by ref desc, step asc)) " // +
 * "where rnum >= ? and rnum <=?");
 * 
 * pstmt.setInt(1, start); pstmt.setInt(2, end);
 * 
 * rs = pstmt.executeQuery();
 * 
 * if(rs.next()) {
 * 
 * articleList = new ArrayList<CommentVO>(end - start+1);
 * 
 * do {
 * 
 * CommentVO article = new CommentVO();
 * 
 * article.setNum(rs.getInt("num")); article.setWriter(rs.getString("writer"));
 * article.setEmail(rs.getString("email"));
 * article.setSubject(rs.getString("subject"));
 * article.setPass(rs.getString("pass"));
 * article.setRegdate(rs.getTimestamp("regdate"));
 * article.setReadcount(rs.getInt("readcount"));
 * article.setRef(rs.getInt("ref")); article.setStep(rs.getInt("step"));
 * article.setDepth(rs.getInt("depth"));
 * article.setContent(rs.getString("content"));
 * 
 * articleList.add(article);
 * 
 * }while(rs.next()); }
 * 
 * }catch(Exception se) { System.out.println("Exception" +se); }finally { if(rs
 * != null) try { rs.close(); }catch(SQLException s1) {
 * 
 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s2) {
 * 
 * } if(con != null) try { con.close(); }catch(SQLException s3) {
 * 
 * } } return articleList; }
 * 
 * public List<CommentVO> getArticles(String what, String content, int start,
 * int end) { // 占쏙옙占쏙옙 1
 * 
 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
 * List<CommentVO> articleList = null;
 * 
 * try {
 * 
 * con = ConnUtil.getConnection(); // 占쏙옙占쏙옙2 // pstmt =
 * con.prepareStatement("select * from comments order by num desc"); pstmt =
 * con.prepareStatement(
 * "select * from (select rownum rnum, num, writer, email, subject, pass, " +
 * "regdate, readcount, ref, step, depth, content from " +
 * "(select * from comments where "+what+" like '%"
 * +content+"%'order by ref desc, step asc)) where rnum >= ? and rnum <=?");
 * 
 * 
 * pstmt.setInt(1, start); pstmt.setInt(2, end);
 * 
 * rs = pstmt.executeQuery();
 * 
 * if(rs.next()) {
 * 
 * articleList = new ArrayList<CommentVO>(end - start+1);
 * 
 * do {
 * 
 * CommentVO article = new CommentVO();
 * 
 * article.setNum(rs.getInt("num")); article.setWriter(rs.getString("writer"));
 * article.setEmail(rs.getString("email"));
 * article.setSubject(rs.getString("subject"));
 * article.setPass(rs.getString("pass"));
 * article.setRegdate(rs.getTimestamp("regdate"));
 * article.setReadcount(rs.getInt("readcount"));
 * article.setRef(rs.getInt("ref")); article.setStep(rs.getInt("step"));
 * article.setDepth(rs.getInt("depth"));
 * article.setContent(rs.getString("content"));
 * 
 * articleList.add(article);
 * 
 * }while(rs.next()); }
 * 
 * }catch(Exception se) { System.out.println("Exception" +se); }finally { if(rs
 * != null) try { rs.close(); }catch(SQLException s1) {
 * 
 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s2) {
 * 
 * } if(con != null) try { con.close(); }catch(SQLException s3) {
 * 
 * } } return articleList; }
 * 
 * 
 * 
 * public CommentVO getArticle(int num) { Connection con = null;
 * PreparedStatement pstmt = null; ResultSet rs = null; CommentVO article =
 * null;
 * 
 * try {
 * 
 * con = ConnUtil.getConnection(); pstmt =
 * con.prepareStatement("update comments set readcount =readcount+1 where num=?"
 * ); pstmt.setInt(1, num); pstmt.executeUpdate();
 * 
 * pstmt = con.prepareStatement("select * from comments where num=?");
 * pstmt.setInt(1, num); rs = pstmt.executeQuery();
 * 
 * if(rs.next()) { article = new CommentVO(); article.setNum(rs.getInt("num"));
 * article.setWriter(rs.getString("writer"));
 * article.setEmail(rs.getString("email"));
 * article.setSubject(rs.getString("subject"));
 * article.setPass(rs.getString("pass"));
 * article.setRegdate(rs.getTimestamp("regdate"));
 * article.setReadcount(rs.getInt("readcount"));
 * article.setRef(rs.getInt("ref")); article.setStep(rs.getInt("step"));
 * article.setDepth(rs.getInt("depth"));
 * article.setContent(rs.getString("content")); }
 * 
 * }catch(Exception se) { System.out.println("Exception" +se); }finally { if(rs
 * != null) try { rs.close(); }catch(SQLException s1) {
 * 
 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s2) {
 * 
 * } if(con != null) try { con.close(); }catch(SQLException s3) {
 * 
 * } }
 * 
 * return article; }
 * 
 * 
 * public CommentVO updateGetArticle(int num) { Connection con = null;
 * PreparedStatement pstmt = null; ResultSet rs = null; CommentVO article =
 * null;
 * 
 * try {
 * 
 * con = ConnUtil.getConnection(); pstmt =
 * con.prepareStatement("select * from comments where num=?"); pstmt.setInt(1,
 * num); rs = pstmt.executeQuery();
 * 
 * if(rs.next()) { article = new CommentVO(); article.setNum(rs.getInt("num"));
 * article.setWriter(rs.getString("writer"));
 * article.setEmail(rs.getString("email"));
 * article.setSubject(rs.getString("subject"));
 * article.setPass(rs.getString("pass"));
 * article.setRegdate(rs.getTimestamp("regdate"));
 * article.setReadcount(rs.getInt("readcount"));
 * article.setRef(rs.getInt("ref")); article.setStep(rs.getInt("step"));
 * article.setDepth(rs.getInt("depth"));
 * article.setContent(rs.getString("content")); }
 * 
 * }catch(Exception se) { System.out.println("Exception" +se); }finally { if(rs
 * != null) try { rs.close(); }catch(SQLException s1) {
 * 
 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s2) {
 * 
 * } if(con != null) try { con.close(); }catch(SQLException s3) {
 * 
 * } }
 * 
 * return article; }
 * 
 * 
 * 占쏙옙占쏙옙占싶븝옙占싱쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙 처占쏙옙占쏙옙 占실억옙占쏙옙占� 占쏙옙占쏙옙 占쏙옙占쏙옙처占쏙옙 占쏙옙 占쌨소듸옙 占쏙옙占쏙옙
 * 
 * public int updateArticle(CommentVO article) { Connection con = null;
 * PreparedStatement pstmt = null; ResultSet rs = null;
 * 
 * String dbpasswd = ""; String sql = "";
 * 
 * int result = -1; try { con = ConnUtil.getConnection(); pstmt =
 * con.prepareStatement("select pass from comments where num=?");
 * 
 * pstmt.setInt(1, article.getNum()); rs = pstmt.executeQuery();
 * 
 * if(rs.next()) { dbpasswd = rs.getString("pass");
 * if(dbpasswd.equals(article.getPass())) { // 占쏙옙橘占싫ｏ옙占� 占쏙옙치占싹몌옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 sql
 * = "update comments set writer=?, email=?, subject=?, content=? where num=?";
 * pstmt = con.prepareStatement(sql);
 * 
 * pstmt.setString(1, article.getWriter()); pstmt.setString(2,
 * article.getEmail()); pstmt.setString(3, article.getSubject());
 * pstmt.setString(4, article.getContent()); pstmt.setInt(5, article.getNum());
 * 
 * pstmt.executeUpdate(); result = 1; // 占쏙옙占쏙옙占쏙옙占쏙옙 }else { result = 0; } }
 * 
 * }catch(Exception se) { System.out.println("Exception" +se); }finally { if(rs
 * != null) try { rs.close(); }catch(SQLException s1) {
 * 
 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s2) {
 * 
 * } if(con != null) try { con.close(); }catch(SQLException s3) {
 * 
 * } } return result;
 * 
 * }
 * 
 * 
 * 占쏙옙 占쏙옙占쏙옙 처占쏙옙
 * 
 * 占쏙옙占쏙옙占싶븝옙占싱쏙옙占쏙옙占쏙옙 占쏙옙橘占싫ｏ옙占� 占쏙옙占싹울옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쌨소드를 占쏙옙占쏙옙占쏙옙
 * 
 * public int deleteArticle(int num, String pass) { Connection con = null;
 * PreparedStatement pstmt = null; ResultSet rs = null;
 * 
 * String dbpasswd = ""; String sql = "";
 * 
 * int result = -1; try { con = ConnUtil.getConnection(); pstmt =
 * con.prepareStatement("select pass from comments where num=?");
 * 
 * pstmt.setInt(1, num); rs = pstmt.executeQuery();
 * 
 * if(rs.next()) { dbpasswd = rs.getString("pass"); if(dbpasswd.equals(pass)) {
 * // 占쏙옙橘占싫ｏ옙占� 占쏙옙치占싹몌옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 sql = "delete from comments where num=?";
 * pstmt = con.prepareStatement(sql);
 * 
 * pstmt.setInt(1, num);
 * 
 * pstmt.executeUpdate(); result = 1; // 占쏙옙占쏙옙 占쏙옙占쏙옙 }else { result = 0; // 占쏙옙橘占싫�
 * 틀占쏙옙 } }
 * 
 * }catch(Exception se) { System.out.println("Exception" +se); }finally { if(rs
 * != null) try { rs.close(); }catch(SQLException s1) {
 * 
 * } if(pstmt != null) try { pstmt.close(); }catch(SQLException s2) {
 * 
 * } if(con != null) try { con.close(); }catch(SQLException s3) {
 * 
 * } } return result; } }
 */