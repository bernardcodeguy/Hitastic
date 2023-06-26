<%@ page import="java.sql.*" %>


<%
	int edit_id = Integer.parseInt(request.getParameter("edit_id"));
	
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String email = request.getParameter("email");

	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "UPDATE users SET fname=?, lname=?, email=? WHERE id=?";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, fname);
	ps.setString(2, lname);
	ps.setString(3, email);
	ps.setInt(4, edit_id);
	
	ps.executeUpdate();  
	
%>