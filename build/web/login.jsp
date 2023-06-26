
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
    String title = "Log In";
    String username = "";
%>

<%@ include file="header.jsp" %>

<% 
    
    if(session.getAttribute("username") == null){
    
        
    }else{
        
        username = String.valueOf(session.getAttribute("username"));
    }

%>

<div class="container" id="reg-container"> 
		 <div class="card">
		       <div class="card-content">	       
		       	<div class="row center-align">
		       		<div class="col s12">
		       			<span class="card-title teal-text text-lighten-2">Log In</span>
		       		</div>
		       	</div>	
		       		       	
		       	<form action="login" method="post">
		       	<div class="row center-align">

		       			<div class="col s12">
		       				<div class=input-field>
                                                    <i class="material-icons prefix">person</i>
                                                    <%if(username.equals("")) {%>
                                                    <input type="text" id="username" class="validate" name="username" data-length="10"  required>
                                                    <%} else { %>
                                                    
                                                    <input type="text" id="username" class="validate" name="username" data-length="10" value="<%=username %>" >
                                                    <%} %>
                                                    
                                                    <label for="username" data-error="input error" data-success="" class="active">Username</label>
		       				</div>
		       			</div>
		       			
		       			<!-- Password -->
		       			
		       			<div class="col s12">
		       				<div class=input-field>
		       					<i class="material-icons prefix">https</i>
		       					<input type="password" id="passwd" class="validate" name="passwd"  required>
		       					<label for="passwd" class="active">Password</label>
		       				</div>
		       			</div>
		       				       			
		       			
		       			<div class="col s12">
		       				<div class=input-field>	       					
		       					<input type="submit" class="btn" value="Log in">		       					
		       				</div>
		       			</div>
		       	</div>
		       			       	
		     </form>
		     
		     	<div class="row center-align">
		     	
		     		<p>Not a member yet? Signup <a href="start">here</a></p>
		     		<p>Back to <a href="index.jsp">homepage</a></p>
		     	</div>
		     
		         	       	         
		       </div>
		     
		</div>	 
	 
	 </div>




<%@ include file="mid.jsp" %>


<script>
	
        $(document).ready(function(){
                M.updateTextFields();
        })
        
</script>

<%@ include file="footer.jsp" %>