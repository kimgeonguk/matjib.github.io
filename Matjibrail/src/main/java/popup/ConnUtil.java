package popup;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class ConnUtil
{
	private static DataSource ds;
	
	static {
	try
	{
		InitialContext ctx = new InitialContext();
		ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mydb");
	}catch(NamingException e) {}
	}
	
	public static Connection getConnection() throws SQLException{
		return ds.getConnection();
		
	}
	
	
}
