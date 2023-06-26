<%@ page import="java.sql.*" %>


<%
	
        int id = Integer.parseInt(request.getParameter("id"));
	
	
	
	
	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "UPDATE orders SET is_delivered=1 WHERE id=?";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setInt(1, id);	
	ps.executeUpdate(); 
        con.close();
        
        String sql1 = "UPDATE order_history SET is_delivered=1 WHERE id=?";
	Class.forName(dbDriver);
	Connection con1 = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps1 = con1.prepareStatement(sql1);
	
	ps1.setInt(1, id);	
	ps1.executeUpdate();
        con1.close();
        

       //out.println(id);
	
%>