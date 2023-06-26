<%@ page import="java.sql.*" %>
<%@ page import ="org.mindrot.jbcrypt.BCrypt" %>


<%
	String username = String.valueOf(request.getParameter("username"));
        String passwd = String.valueOf(request.getParameter("passwd"));
	
	
	
	
	String passwdcrypt = BCrypt.hashpw(passwd, BCrypt.gensalt());
        
	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
        String sql = "UPDATE users SET passwd=? WHERE username=?";
        Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
        
	ps.setString(1, passwdcrypt);
	ps.setString(2, username);
        
 	ps.executeUpdate();

        

%>
