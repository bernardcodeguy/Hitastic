/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package webapp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import webapp.User;



public class RegisterDao {
	private final String username = "root";
        private final String passwordDB = "1234";
        private final String urlPort = "localhost:3307";
        private final String databaseName = "hitastic";
        private final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        private final String dbDriver = "com.mysql.cj.jdbc.Driver";
	
	public void loadDriver(String dbDriver) {
		try {
			Class.forName(dbDriver);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	
	
	public Connection getConnection() throws SQLException {
		
		Connection con = DriverManager.getConnection(url,username,passwordDB);
		
		return con;
		
	}
	
	
	public String insert(User user) throws SQLException {
		loadDriver(dbDriver);		
		Connection con = getConnection();	
		String result = "Data entry successfull";
		String sql = "INSERT INTO users(username,fname,lname,email,passwd,gender) VALUES(?,?,?,?,?,?)";	
		PreparedStatement ps;
		
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getFname());
			ps.setString(3, user.getLname());
			ps.setString(4, user.getEmail());
			ps.setString(5, user.getPasswd());
			ps.setString(6, user.getGender());
						
			ps.executeUpdate();
		} catch (Exception e) {
			
			e.printStackTrace();
			result = "Data entry unsuccessfull";
		}
		
		return result;
		
	}
	
	
}
