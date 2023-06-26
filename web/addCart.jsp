<%@ page import="java.sql.*" %>


<%
	int userid = Integer.parseInt(request.getParameter("userid"));
	int musicid = Integer.parseInt(request.getParameter("musicid"));
	String title = request.getParameter("title");
        String artist = request.getParameter("artist");
        double price = Double.parseDouble(request.getParameter("price"));
                
	
	
	
	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
        String sql = "INSERT INTO cart(userid,musicid,title,artist,price) SELECT * FROM (SELECT ? AS userid, ? AS music_id, ? AS title, ? AS artist,? AS price) AS new_value WHERE NOT EXISTS (SELECT musicid FROM cart WHERE musicid = ?) LIMIT 1;";
        Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
        
	ps.setInt(1, userid);
	ps.setInt(2, musicid);
        ps.setString(3, title);
	ps.setString(4, artist);
        ps.setDouble(5, price);
        ps.setInt(6, musicid);

        
 	ps.executeUpdate();

        
        response.sendRedirect("home.jsp");
%>
