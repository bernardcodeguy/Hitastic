<%@ page import="java.sql.*" %>


<%
	int edit_id = Integer.parseInt(request.getParameter("edit_id"));
	
	String title = request.getParameter("title");
	String artist = request.getParameter("artist");
	double price = Double.parseDouble(request.getParameter("price"));
	String duration = request.getParameter("duration");

	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "UPDATE music SET title=?, artist=?, price=?, duration=? WHERE id=?";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, title);
	ps.setString(2, artist);
	ps.setDouble(3, price);
	ps.setString(4, duration);
	ps.setInt(5, edit_id);
	
	ps.executeUpdate();  
	
%>
