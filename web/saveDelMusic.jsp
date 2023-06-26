<%@ page import="java.sql.*" %>


<%
	int del_id = Integer.parseInt(request.getParameter("del_id"));

	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "DELETE FROM music WHERE id=?";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);

	ps.setInt(1, del_id);
	
	ps.executeUpdate(); 
	
%>