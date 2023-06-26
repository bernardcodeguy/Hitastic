<%@ page import="java.sql.*" %>
<%@ taglib prefix="print" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fx" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%!
	int id;
	String fname = "";
	String lname = "";
	String email = "";
	String gender = "";
	
%>


<% 
	if(request.getParameterMap().containsKey("id"))
	{
	     
                id = Integer.parseInt(request.getParameter("id")); 
	    
                request.setAttribute("id", id);
	    
                final String usernameDB = "root";
                final String passwordDB = "1234";
                final String urlPort = "localhost:3307";
                final String databaseName = "hitastic";
                final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
                final String dbDriver = "com.mysql.cj.jdbc.Driver";
		String sql = "SELECT fname,lname,email,gender FROM users WHERE id="+id;
		Class.forName(dbDriver);
		Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
		rs.next();
		
		fname = rs.getString("fname");
		lname = rs.getString("lname");
		email = rs.getString("email");
		gender = rs.getString("gender");
		
		con.close();
		
		
	}
	
%>



	    
	    
	    
	    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
	    <sql:query var="rsimg" dataSource="${db}">
	    SELECT img FROM users WHERE id=?
	    <sql:param value = "${id}" />
	    </sql:query>
            
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
            <sql:query var="rspur" dataSource="${db}">
	    SELECT SUM(price) AS purchase FROM order_history WHERE userid=? AND is_delivered > 0;
	    <sql:param value = "${id}" />
	    </sql:query>
            
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
            <sql:query var="rsor" dataSource="${db}">
	    SELECT COUNT(*) AS order_count FROM order_history WHERE userid=? AND is_delivered > 0;
	    <sql:param value = "${id}" />
	    </sql:query>
            
	    
	    <print:forEach items="${rsimg.rows}" var="user"> 
	    	<print:set var = "img" scope = "session" value = "${user.img}"/>
	    </print:forEach>
            
            <print:forEach items="${rspur.rows}" var="sum"> 
            <print:set var = "sum" scope = "session" value = "${sum.purchase}"/>      
            </print:forEach>
            
            <print:forEach items="${rsor.rows}" var="count"> 
            <print:set var = "counts" scope = "session" value = "${count.order_count}"/>      
            </print:forEach>

		
	<div class="hide-on-med-and-down" style="margin-left:45%;">
		<print:choose>
			<print:when test="${img == null}">
				<div class="con" style="width:100px; height:100px">
					<img src="avi.png" alt="image not found" class="responsive-img circle" id="dp">
				</div>
			</print:when>
			<print:otherwise>
			
				<div class="con" style="width:100px; height:100px">
					<img src=saveimage?id=<print:out value="${id}"></print:out> width="100px" height="100px" alt="image not found" class="responsive-img circle" id="dp">
				</div>	
			</print:otherwise>
		
		</print:choose>
	</div>
	<div class="hide-on-large-only" style="margin-left:40%;">
		<print:choose>
			<print:when test="${img == null}">
				<div class="con" style="width:100px; height:100px">
					<img src="images/placeholder.png" alt="image not found" class="responsive-img circle" id="dp">
				</div>
			</print:when>
			<print:otherwise>
			
				<div class="con" style="width:100px; height:100px">
					<img src=saveimage?id=<print:out value="${id}"></print:out> alt="image not found" class="responsive-img circle" id="dp">
				</div>	
			</print:otherwise>
		
		</print:choose>
	</div>									
	 <br>
	 <br>
	<div>
		
		<p style="font-weight:bold">Full Name: <span style="font-weight:normal"> <%=fname %> <%=lname %></span></p>
		<p style="font-weight:bold">Email Address: <span style="font-weight:normal"><%=email %></span></p>
		<p style="font-weight:bold">Gender: <span style="font-weight:normal"><%=gender %></span></p>
                <p style="font-weight:bold">Total Completed Orders: <span style="font-weight:normal">${counts}</span></p>
		<p style="font-weight:bold">Purchases (Cash): <span style="font-weight:normal"><fmt:formatNumber value="${sum}" type="currency" currencySymbol="£"></fmt:formatNumber></span></p>
		
	
		
	</div>


