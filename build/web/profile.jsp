<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! 
    String title = "Profile";
    String username = "";
%>

<%@ include file="header.jsp" %>

<% 
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    if(session.getAttribute("username") == null){
        
        response.sendRedirect("index.jsp");
            
    }else{
        
        username = String.valueOf(session.getAttribute("username"));
    }

%>


<header>
    <!-- User details query -->
    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
    <sql:query var="rs" dataSource="${db}">
    SELECT * FROM users WHERE username=?
    <sql:param value = "${username}" />
    </sql:query>
	    
	    
	    
    <print:forEach items="${rs.rows}" var="user"> 
        <print:set var = "id" scope = "session" value = "${user.id}"/>
        <print:set var = "username" scope = "session" value = "${user.username}"/>
        <print:set var = "fname" scope = "session" value = "${user.fname}"/>
        <print:set var = "lname" scope = "session" value = "${user.lname}"/>              
        <print:set var = "email" scope = "session" value = "${user.email}"/>
        <print:set var = "gender" scope = "session" value = "${user.gender}"/>
        <print:set var = "img" scope = "session" value = "${user.img}"/>
    </print:forEach>
            
            
    <!-- Cart count queries -->
    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
    <sql:query var="rsc" dataSource="${db}">
    SELECT * FROM cart WHERE userid=?
    <sql:param value = "${id}" />
    </sql:query>
    
  <!-- Navigation Bar -->	
	<div class="navbar">
 	<nav>
        <div class="nav-wrapper teal lighten-3">
        	<div class="container">
        	<a href="home.jsp" class="brand-logo">Hitastic!</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="home.jsp"><i class="material-icons left">music_note</i>Products</a></li>
                <li><a href="search.jsp"><i class="material-icons left">search</i>Search</a></li>
                <li><a href="order.jsp"><i class="material-icons left">history</i>Orders</a></li>                
                <li>
                    <a href="cart.jsp"><i class="material-icons left">shopping_cart</i>Cart
                        <print:choose>
                            <print:when test="${rsc.rowCount < 1}">
                                
                            </print:when>
                            <print:otherwise>
                                <span class="new badge red">
                            <print:out value="${rsc.rowCount}"></print:out>
                                 </span>
                            </print:otherwise>                          
                        </print:choose>
                        
                    </a>
                </li>
                <li><a href="profile.jsp"><i class="material-icons left">person</i>Profile</a></li>
                <li><a href="logout"><i class="material-icons left">logout</i> Log out</a></li>
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <li><a href="home.jsp">Products</a></li>
                <li><a href="search.jsp">Search</a></li>
                <li><a href="order.jsp">Orders</a></li>                
                <li>
                    <a href="cart.jsp">Cart
                        <print:choose>
                            <print:when test="${rsc.rowCount < 1}">                                
                            </print:when>
                            <print:otherwise>
                                <span class="new badge red">
                            <print:out value="${rsc.rowCount}"></print:out>
                                 </span>
                            </print:otherwise>                          
                        </print:choose>
                    </a>
                </li>
                <li><a href="profile.jsp">Profile</a></li>
                <li><a href="logout">Log out</a></li>
            </ul>
        	
        	</div>
            
        </div>
    </nav>
     
    </div>  
    
</header>
<main>
    
  <div class="container">
            
            
            
            
		
		
		<div class="row c-row" style="margin-top: 150px;">
			<div class="col c-col s12 m12 l4">
			
				<div class="card-panel c-card">
					<div class="row">
                                        <div class="col s6">
                                        <print:choose>
                                                <print:when test="${img == null}">
                                                        <div class="con" style="width:100px; height:100px">
                                                                <a href="#" class="" id="upload-img"><img src="avi.png" alt="image not found" class="responsive-img circle" id="dp"></a>
                                                        </div>
                                                </print:when>
                                                <print:otherwise>

                                                        <div class="con" style="width:100px; height:100px">
                                                                <a href="#" id="upload-img" onMouseOver="" ><img src=saveimage?id=<print:out value="${id}"></print:out> width="100px" height="100px"alt="image not found" class="responsive-img circle" id="dp"></a>
                                                        </div>	
                                                </print:otherwise>
                                                

                                        </print:choose>

                                        </div>
                                        <div class="col s6" style="margin-top:10px;">
                                                <p style="font-weight:bold;font-size:1.3em">
                                                <print:out value="${fname}"></print:out> <print:out value="${lname}"></print:out><br>
                                                <span style="font-weight:normal; font-size:0.7em">
                                                    <print:choose>
                                                        <print:when test="${gender eq 'M'}">  
                                                                        <print:out value="Male"></print:out><br>        
                                                        </print:when>
                                                        <print:otherwise>
                                                                        <print:out value="Female"></print:out><br>
                                                        </print:otherwise>
                                                    </print:choose> 
                                                
                                                </span>
                                                </p>									
                                        </div>
                                </div>
                                <br>
                                <br>
                                <hr>


                                <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Email Address:					
                                        </div>
                                        <div class="col s8">		
                                                <print:out value="${email}"></print:out><br>				
                                        </div>

                                </div>
                                <hr>
                                <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Username:					
                                        </div>
                                        <div class="col s8">		
                                                <print:out value="${username}"></print:out><br> 				
                                        </div>

                                </div>
                                  <hr>
                                
                                <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Gender:					
                                        </div>
                                        <div class="col s8" >			
                                                <print:choose>
                                                        <print:when test="${gender eq 'M'}">  
                                                                        <print:out value="Male"></print:out><br>        
                                                        </print:when>
                                                        <print:otherwise>
                                                                        <print:out value="Female"></print:out><br>
                                                        </print:otherwise>
                                                </print:choose> 				
                                        </div>
                                     <hr>
                                </div>					
                        </div>

                </div>
                 
                 <div class="col s12 m12 l8 c-col">
				<ul class="collapsible c-card">
				  <li>
				    <div class="collapsible-header"><i class="material-icons">settings</i>Password Settings</div>
				    <div class="collapsible-body">
				    	<form action="" method="post" id="update-pass">
					       	<div class="row center-align">
									
									<div class="col s12">
					       				<div class=input-field>
					       					<input type="hidden" id="username" class="validate" name="username"  value="${username}" required>
					       				</div>
					       			</div>
									
					       			<div class="col s12">
					       				<div class=input-field>
					       					<i class="material-icons prefix">https</i>
					       					<input type="password" id="passwd" class="validate" name="passwd"  required>
					       					<label for="passwd" class="active">New Password</label>
					       				</div>
					       			</div>
					       			
					       			<!-- Password -->
					       			
					       			<div class="col s12">
					       				<div class=input-field>
					       					<i class="material-icons prefix">https</i>
					       					<input type="password" id="passwd2" class="validate" name="passwd2"  required>
					       					<label for="passwd2" class="active">Confirm Password</label>
					       				</div>
					       			</div>
					       				       			
					       			
					       			<div class="col s12">
					       				<div class=input-field>	       					
					       					<a href="#" class="submit btn" id="save-pass"> Save Changes</a>		       					
					       				</div>
					       			</div>
					       	</div>      	
		     		</form>
				    </div>
				    
				  </li>
				  <li>
				    <div class="collapsible-header"><i class="material-icons">person</i>Profile Settings</div>
				    <div class="collapsible-body">
				    
				    	<form action="register" method="post" id="update-pro">
		       			<div class="row center-align">
		       			
		       			<div class="col s12">
		       				<div class=input-field>
		       					<input type="hidden" id="username" class="validate" name="username"  value="${username}" required>
		       				</div>
					    </div>
		       			
		       			<div class="col s12 m6 l6">
		       				<div class=input-field>
		       					<i class="material-icons prefix">create</i>
		       					<input type="text" id="fname" name="fname" class="validate"  value="${fname}" required>
		       					<label for="fname" class="active">First Name</label>
		       				</div>
		       			</div>
		       			
		       			<div class="col s12 m6 l6">
		       				<div class=input-field>
		       					<i class="material-icons prefix">create</i>
		       					<input type="text" id="lname" name="lname" class="validate" value="${lname}"required>
		       					<label for="lname" class="active">Last Name</label>
		       				</div>
		       			</div>
		       			
		       			
		       			<!-- Email -->
		       			
		       			<div class="col s12">
		       				<div class=input-field>
		       					<i class="material-icons prefix">create</i>
		       					<input type="text" id="email" name="email" class="validate" value="${email}" required>
		       					<label for="depart" class="active">Email</label>
		       				</div>
		       			</div>
		       			
		       			
		       			
		       			<div class="col s12">
		       				<div class=input-field>	       					
		       					<a href="#" class="submit btn" id="save-profile"> Save Changes</a>		       					
		       				</div>
					   </div>
		       		</div>
		       			       	
		     	</form>

		</div>
			
			</ul>
				
		</div>
			
	  </div>

	</div>  
  
</main>

                                                        <footer class="page-footer teal lighten-3">
          <div class="container">
            <div class="row">
              <div class="col l6 s12">
                <h5 class="white-text">Hitastic!</h5>
                <p class="grey-text text-lighten-4">Hitastic! Online music site</p>
              </div>
              <div class="col l4 offset-l2 s12">
                <h5 class="white-text">Contact Us</h5>
                <ul>
                  <li><a class="grey-text text-lighten-3" href="#!">groups@gmail.com</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">+4478394847</a></li>
                  
                </ul>
              </div>
            </div>
          </div>
          <div class="footer-copyright">
            <div class="container">
            © 2022 Copyright Text
            <a class="grey-text text-lighten-4 right" href="#">More Links</a>
            </div>
          </div>
        </footer>


<%@ include file="mid.jsp" %>

<script>
            $(document).ready(function(){
                $(".button-collapse").sideNav();
                $('#modal1').modal();
                
                 $(document).on('click', '#save-pass', function(){				 
				 var username = $("#username").val();
				 var passwd = $("#passwd").val();
				 var passwd2 = $("#passwd2").val();
                                 
			 
				 if(passwd != passwd2 || passwd == '' || passwd2 == ''){
					 alert("Password mismatches or Empty password field");
				 }else{
                                        
					 
					  $.ajax({

			          url: "savePassData.jsp",
			          type: "POST",
			          data:$("#update-pass").serialize(),
			          success:function(data){
                                             window.location.reload(true);
                                             alert("Password changed successfully");
			          }
			     });
					  
			    }
		});
                
                $(document).on('click', '#save-profile', function(){
				 
				 var username = $("#username").val();
				 var fname = $("#fname").val();
				 var lname = $("#lname").val();
				 var email = $("#email").val();
				 
				 
				 //alert(email);
				  if(username == '' || fname == '' ||lname == '' || email == ''){
					 alert("Field(s) Empty error!!");
				 }else{
					 
					  $.ajax({

			          url: "saveProfileData.jsp",
			          type: "POST",
			          data:$("#update-pro").serialize(),
			          success:function(data){			        	 
			        	alert("Changes made successfully");
                                        window.location.reload(true);
			          }
			     });
					  
			    } 
			});
                        
                $(document).on('click', '#upload-img', function(){
				$('#modal1').modal('open');			    
			}); 
                   
            });
                    
</script>


<%@ include file="footer.jsp" %>



<!-- Modal for Adding Profile Photo-->
	  <div id="modal1" class="modal modal-fixed-footer" style="height:40%; width:50%">
	  	<form action="saveimage" method="post" enctype="multipart/form-data">
		    <div class="modal-content" >
		      <h4 class="center-align">ADD PROFILE PHOTO</h4>
		      <p class="center-align red-text">Square and (512 * 512 or less dimension) Images are recommended for better display</p>
		      	<div class="row center-align" id="">  
		      	 
		      	<div class="col s12">
					<div class=input-field>		
						<input type="hidden" id="userid" name="userid" value="${id}">
					</div>
			     </div>   						 
					<div class="col s12">
						<div class = "file-field input-field" >
		                  <div class = "btn">
		                     <span>Browse</span>
		                     <input type = "file" name="img" />
		                  </div>                  
		                  <div class = "file-path-wrapper">
		                     <input class = "file-path validate" type = "text"
		                        placeholder = "Upload file" name="img" required/>
		                  </div>
		               </div>   
					</div>  
					<div class="col s12">
				      <div class=input-field>	       					
				       	<input type="submit" class="btn" value="Save Changes">		       					
				     </div>  	
		      	</div>
		      
		    </div>
		    </div>
	    </form>
 	</div>