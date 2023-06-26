<%@ page import="java.sql.*" %>

<%!
	int edit_id;
	String fname = "";
	String lname = "";
	String email = "";
        
	
%>


<% 
	if(request.getParameterMap().containsKey("edit_id"))
	{
	     
	    edit_id = Integer.parseInt(request.getParameter("edit_id")); 
	    
                final String usernameDB = "root";
                final String passwordDB = "1234";
                final String urlPort = "localhost:3307";
                final String databaseName = "hitastic";
                final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
                final String dbDriver = "com.mysql.cj.jdbc.Driver";
		String sql = "SELECT fname,lname,email FROM users WHERE id="+edit_id;
		Class.forName(dbDriver);
		Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
		rs.next();
		
		fname = rs.getString("fname");
		lname = rs.getString("lname");
		email = rs.getString("email");
		
	}
        

        
%>
	
	
        <div class="col s12">
                <div class=input-field>		
                        <input type="hidden" id="edit_id" name="edit_id" value="<%=edit_id%>">
                </div>
         </div>
	
	 <div class="col s12 m6 l6">
		<div class=input-field>
			<label>First Name:</label><br>
			<input type="text" id="fname" name="fname" value="<%=fname%>">
		</div>
	</div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Last Name:</label><br>
			<input type="text" id="lname" name="lname" value="<%=lname%>">
			
		</div>
	</div>
	
	
	
	
	<div class="col s12">
		<div class=input-field>
			<label>Email:</label><br>
			<input type="text" id="email" name="email" value="<%=email%>">
		</div>
	</div>
		
	