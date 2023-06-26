<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
    String title = "Registration";
    String username = "";
%>

<%@ include file="header.jsp" %>

<% 
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if(session.getAttribute("username") == null){
    
        response.sendRedirect("start");
    }else{     
        username = String.valueOf(session.getAttribute("username"));
    }

%>


    <div class="container" id="reg-container"> 
            <div class="card">
                  <div class="card-content">	       
                   <div class="row center-align">
                           <div class="col s12">
                                   <span class="card-title teal-text text-lighten-2">Registration</span>
                           </div>
                   </div>	

                   <form action="register" method="post">
                   <div class="row center-align">
                                   	
                                 <input type="hidden" id="username" name="username" value="<%=username %>">
                                       

                                   <div class="col s12 m6 l6">
                                           <div class=input-field>
                                                   <i class="material-icons prefix">create</i>
                                                   <input type="text" id="fname" name="fname" class="validate"  required>
                                                   <label for="fname" class="active">First Name</label>
                                           </div>
                                   </div>

                                   <div class="col s12 m6 l6">
                                           <div class=input-field>
                                                   <i class="material-icons prefix">create</i>
                                                   <input type="text" id="lname" name="lname" class="validate" required>
                                                   <label for="lname" class="active">Last Name</label>
                                           </div>
                                   </div>

                                   <div class="col s12">
                                           <div class=input-field>
                                                   <i class="material-icons prefix">email</i>
                                                   <input type="email" id="email" name="email" class="validate" required>
                                                   <label for="email" data-error="input error" data-success="" class="active">Email</label>
                                           </div>
                                   </div>

                                   <!-- Password -->

                                   <div class="col s12 m6 l6">
                                           <div class=input-field>
                                                   <i class="material-icons prefix">https</i>
                                                   <input type="password" id="passwd" name="passwd" class="validate" required>
                                                   <label for="pass1" class="active">Password</label>
                                           </div>
                                   </div>

                                   <div class="col s12 m6 l6">
                                           <div class=input-field>
                                                   <i class="material-icons prefix">https</i>
                                                   <input type="password" id="passwd2" name="passwd2" class="validate" required>
                                                   <label for="passwd2" class="active">Confirm Password</label>
                                           </div>
                                   </div>
                                   
                                    <div class="col s12">
                                        
                                        <div class="row">
                                         <div class="col s1" style="margin-top: 15px;">                                           
                                             <i class="small material-icons prefix">wc</i>                                             
                                         </div>
                                         <div class="col s11">
                                            <div class=input-field> 
                                                    <select class="browser-default" id="gender" name="gender">
                                                      <option value="" disabled selected>Gender</option>
                                                      <option value="M">Male</option>
                                                      <option value="F">Female</option>
                                                      <option value="N">Other</option>
                                                    </select>
                                           </div>     
                                         </div> 
                                            
                                            
                                        </div>
                                           
                                   </div>
                                   
                                   

                                   <div class="col s12">
                                           <div class=input-field>	       					
                                                   <input type="submit" class="btn" value="Register">		       					
                                           </div>
                                   </div>
                   </div>

                </form>

                   <div class="row center-align">

                           <p>Already a member? Login <a href="login.jsp">here</a></p>
                           <p>Back to <a href="index.jsp">homepage</a></p>
                   </div>


                  </div>

           </div>	 

    </div>

<%@ include file="mid.jsp" %>


    <script type="text/javascript">
        
        
        $(document).ready(function(){
            M.updateTextFields();
	});
    
    
           
           
       

    </script>

<%@ include file="footer.jsp" %>
