<%@ page import="java.sql.*" %>



<%
	String del_id = request.getParameter("del_id");
	
        String [] ids = del_id.split(" ");
	
	int musicid = Integer.parseInt(ids[0]);
        int userid = Integer.parseInt(ids[1]);
	
	
        
	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
        String sql = "DELETE FROM cart WHERE userid=? AND musicid=?";
        Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);

	ps.setInt(1, userid);
        ps.setInt(2, musicid);
	
	ps.executeUpdate();

        

%>