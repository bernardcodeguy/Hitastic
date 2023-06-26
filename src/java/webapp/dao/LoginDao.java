package webapp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.mindrot.jbcrypt.BCrypt;

public class LoginDao {

	public Boolean checkCredentials(String username,String passwd) {
		
		try {
			final String usernameDB = "root";
                        final String passwordDB = "1234";
                        final String urlPort = "localhost:3307";
                        final String databaseName = "hitastic";
                        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
                        final String dbDriver = "com.mysql.cj.jdbc.Driver";
			String sql = "SELECT * FROM users WHERE username=?";
			Class.forName(dbDriver);
			Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
			
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, username);
			ResultSet rs = st.executeQuery();
			
			if(rs.next()) {
				
				String pass = rs.getString("passwd");
				Boolean match = BCrypt.checkpw(passwd, pass);
				
				if(match) {
                                        con.close();
					return true;
				}
			}
			
                        
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return false;
		
	}

}