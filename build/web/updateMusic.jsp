<%@ page import="java.sql.*" %>

<%!
	int edit_id;
	String title = "";
	String artist = "";
	double price;
        String duration = "";
	
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
		String sql = "SELECT title,artist,price,duration FROM music WHERE id="+edit_id;
		Class.forName(dbDriver);
		Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
		rs.next();
		
		title = rs.getString("title");
		artist = rs.getString("artist");
		price = rs.getDouble("price");
		duration = rs.getString("duration");
	}
        

        
%>
	
	
        <div class="col s12">
                <div class=input-field>		
                        <input type="hidden" id="edit_id" name="edit_id" value="<%=edit_id%>">
                </div>
         </div>
	
	 <div class="col s12 m6 l6">
		<div class=input-field>
			<label>Title</label><br>
			<input type="text" id="title" name="title" value="<%=title%>">
		</div>
	</div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Artist</label><br>
			<input type="text" id="artist" name="artist" value="<%=artist%>">
			
		</div>
	</div>
	
	
	
	
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Price (£)</label><br>
			<input type="text" id="price" name="price" value="<%=price%>">
		</div>
	</div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Duration</label><br>
			<input type="text" id="duration" name="duration" value="<%=duration%>">
			
		</div>
	</div>	
