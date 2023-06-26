<%@ page import="java.sql.*" %>
<%@ page import ="org.mindrot.jbcrypt.BCrypt" %>

<%
	
	String username = request.getParameter("username");
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String email = request.getParameter("email");
        String defaultPasswd = "1234";
        String gender = request.getParameter("gender");
        
        
        String passwdcrypt = BCrypt.hashpw(defaultPasswd, BCrypt.gensalt());

	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "INSERT INTO users(username,fname,lname,email,passwd,gender) VALUES(?,?,?,?,?,?)";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, username);
	ps.setString(2, fname);
	ps.setString(3, lname);
	ps.setString(4, email);
	ps.setString(5, passwdcrypt);
	ps.setString(6, gender);
	
	ps.executeUpdate();  
	
%>