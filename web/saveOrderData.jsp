<%@ page import="java.sql.*" %>


<%!
    
    int userid ;
    int musicid ;
    String title;
    String artist;
    double price;
%>


<%
	userid = Integer.parseInt(request.getParameter("userid"));
        musicid = Integer.parseInt(request.getParameter("musicid"));
	title = request.getParameter("title");
	artist = request.getParameter("artist");
	price = Double.parseDouble(request.getParameter("price"));
	
	
	
	
	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "INSERT INTO orders(userid,musicid,title,artist,price) VALUES(?,?,?,?,?)";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setInt(1, userid);
        ps.setInt(2, musicid);
	ps.setString(3, title);
	ps.setString(4, artist);
	ps.setDouble(5, price);

 	ps.executeUpdate();
        con.close();
        


        
	String sql2 = "INSERT INTO order_history(userid,musicid,title,artist,price) VALUES(?,?,?,?,?)";
	Class.forName(dbDriver);
	Connection con2 = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps2 = con2.prepareStatement(sql2);
	
	ps2.setInt(1, userid);
        ps2.setInt(2, musicid);
	ps2.setString(3, title);
	ps2.setString(4, artist);
	ps2.setDouble(5, price);

 	ps2.executeUpdate();
        con2.close();
        


        String sql3 = "DELETE FROM cart WHERE musicid=?";
	Class.forName(dbDriver);
	Connection con3 = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps3 = con3.prepareStatement(sql3);	
	ps3.setInt(1, musicid);
 	ps3.executeUpdate();
        con3.close();
   
	
%>


