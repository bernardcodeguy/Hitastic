
package webapp.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SaveImgDao {
        final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	
	public void loadDriver(String dbDriver) {
		try {
			Class.forName(dbDriver);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	
	
	public Connection getConnection() throws SQLException {
		
		Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
		
		return con;
		
	}
	
	public String insert(int id, InputStream img) throws SQLException {
		loadDriver(dbDriver);		
		Connection con = getConnection();	
		String result = "Data entry successfull";
		String sql = "UPDATE users SET img=? WHERE id=? ";	
		PreparedStatement ps;
		
		try {
			ps = con.prepareStatement(sql);
			ps.setBlob(1, img);
			ps.setInt(2, id);
		
			ps.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = "Data entry unsuccessfull";
		}
		
		return result;	
	}
    
}
