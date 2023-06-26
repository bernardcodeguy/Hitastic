<%@ page import="java.sql.*" %>

<%!
	String del_id = "";
	int id2 = 0;
	String ins = "";
%>


<% 
	if(request.getParameterMap().containsKey("del_id"))
	{	     
		del_id = request.getParameter("del_id"); 
		
	}


%>

	<input type="hidden" name="del_id" id="del_id"  value= "<%=del_id%>" />
                        
     <p>Are you sure you want to remove the music from cart?</p> 
