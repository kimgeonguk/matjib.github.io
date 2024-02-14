package board;

import javax.naming.*;
import javax.sql.*;
import java.sql.*;

public class ConnUtil {

	private static DataSource ds;
	
	static {
	
	try {
	
	InitialContext ctx = new InitialContext();
	ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mydb");
	 
	}catch(NamingException ne) {	}
	
	}
	
	public static Connection getConnection() throws SQLException{
		
		
		return ds.getConnection();
	}
}