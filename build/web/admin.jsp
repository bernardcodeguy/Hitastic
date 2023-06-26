<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%! 
    String title = "Admin Panel";
    String key = "";
    String newUserName = "";
%>

<%@ include file="header.jsp" %>
	
<%	
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		
	if(session.getAttribute("key") == null){
            response.sendRedirect("index.jsp");
	}else{
            
            key = String.valueOf(session.getAttribute("key"));
    }



	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "hitastic";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "SELECT SUM(price) FROM order_history WHERE is_delivered > 0";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	Statement ps = con.createStatement();
	ResultSet rs = ps.executeQuery(sql);
	rs.next();
	
	double sum = rs.getDouble(1);
	
	String currencyForm = String.format("£%,.2f", sum);
	
%>


<%
   
    
         String username1 = "root";
        String passwordDB1 = "1234";
        String urlPort1 = "localhost:3307";
        String databaseName1 = "hitastic";
        String url1 = "jdbc:mysql://"+urlPort+"/"+databaseName;
        String dbDriver1 = "com.mysql.cj.jdbc.Driver";
        String sql1 = "SELECT username FROM users ORDER BY id DESC LIMIT 1";
        
        
        Connection con1 = null;
        Statement st1 = null;
        ResultSet rs1 = null;
        
        String lastUserName = "";
        String newUserName = "";
        String prefix = "user";
        String str = String.format("%04d", 1);
        
        
            Class.forName(dbDriver1);
            con1 = DriverManager.getConnection(url1,username1,passwordDB1);
            st1 = con1.createStatement();
            rs1 = st1.executeQuery(sql1);
            
            if(rs1.next()){
                lastUserName = rs1.getString("username");
                String [] name = lastUserName.split("r");
                int number = Integer.parseInt(name[1])+1;
                String uid = String.format("%04d", number);
                
                
                newUserName = prefix+uid;
                
                
            }else{
                
                newUserName = prefix+str;
                
            }
            con1.close();


    
 %> 

<!-- Navigation Bar -->	
	<div class="navbar">
 	<nav>
        <div class="nav-wrapper teal lighten-3">
        	<div class="container">
        	<a href="admin.jsp" class="brand-logo">Hitastic!</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="#" class="add-user">Add New User</a></li>
                <li><a href="#" class="add-music">Add New Music</a></li>
                <li><a href="adminlogout">Log out</a></li>
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <li><a href="#" class="add-user">Add New User</a></li>
                <li><a href="#" class="add-music">Add New Music</a></li>
                <li><a href="adminlogout">Logout</a></li>
            </ul>
        	
        	</div>
            
        </div>
    </nav>
    </div>


<div class="container">
    
    <!<!-- All Users query -->
    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
    <sql:query var="rowuser" dataSource="${db}">
        SELECT * FROM users ORDER BY fname ASC
      </sql:query>
        
      <sql:query var="rowmusic" dataSource="${db}">
	    SELECT * FROM music  ORDER BY title ASC
      </sql:query>
            
      <sql:query var="roworder" dataSource="${db}">
	    SELECT * FROM order_history
      </sql:query>
            
      <sql:query var="rowpen" dataSource="${db}">
	    SELECT * FROM order_history WHERE is_delivered < 1
      </sql:query>
            
            
            
       <sql:query var="rowcomplete" dataSource="${db}">
	    SELECT * FROM order_history WHERE is_delivered > 0
      </sql:query>
            
      <!-- Order History  queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
	    <sql:query var="rsch" dataSource="${db}">
	    SELECT * FROM order_history
	    </sql:query> 
        
    <div class="row c-row">
        <div class="col s6 m6 l3 c-col">
            <div class="card-panel c-card">
                    <div class="row">
                            <div class="col s12">
                                    <p class="center-align" style="font-size:0.9em">No. of Users</p>
                            </div>
                            <div class="col s12">
                                    <h4 class="center-align flow-text" style="font-weight: bold;"><print:out value="${rowuser.rowCount}"></print:out></h4>
                            </div>
                    </div>   		
            </div> 
        </div>
         <div class="col s6 m6 l3 c-col">
            <div class="card-panel c-card">
                    <div class="row">
                            <div class="col s12">
                                <p class="center-align" style="font-size:0.9em">No. of Products<br> (Music)</p>
                            </div>
                            <div class="col s12">
                                    <h4 class="center-align flow-text" style="font-weight: bold;"><print:out value="${rowmusic.rowCount}"></print:out></h4>
                            </div>
                    </div>   		
            </div> 
        </div>
        <div class="col s6 m6 l3 c-col">
            <div class="card-panel c-card">
                    <div class="row">
                            <div class="col s12">
                                <p class="center-align" style="font-size:0.9em">No. of Orders</p>
                            </div>
                            <div class="col s12">
                                    <h4 class="center-align flow-text" style="font-weight: bold;"><print:out value="${roworder.rowCount}"></print:out></h4>
                            
                                    <p class="center-align" style="font-style: italic; font-size: 12px;">                                   
                                   <span class="red-text" style="font-style: italic; font-size: 12px;">Pending:</span>
                                   (${rowpen.rowCount})
                                    </p>
                                    
                                    <p class="center-align" style="font-style: italic; font-size: 12px;">                                   
                                   <span class="green-text" style="font-style: italic; font-size: 12px;">Delivered:</span>
                                   (${rowcomplete.rowCount})
                                    </p>
                                    
                            </div>
                    </div>   		
            </div> 
        </div>
        <div class="col s6 m6 l3 c-col">
            <div class="card-panel c-card">
                    <div class="row">
                            <div class="col s12">
                                <p class="center-align" style="font-size:0.9em">Sales<br> (Cash)</p>
                            </div>
                            <div class="col s12">
                                    <h4 class="center-align flow-text" style="font-weight: bold;"> <%= currencyForm %></h4>
                            </div>
                    </div>   		
            </div> 
        </div>
        
        
        
    </div>
    <div class="row">
	    <div class="col s12">
	      <ul id="tabs-swipe-demo" class="tabs">
                  <li class="tab col s4"><a href="#test-swipe-1" class="black-text active">All Users </a> </li>
		  <li class="tab col s4"><a class="black-text" href="#test-swipe-2">All Products</a></li>
		  <li class="tab col s4"><a class="black-text" href="#test-swipe-3">All Orders</a></li>
		    
		  </ul>
	    </div>
            <div id="test-swipe-1" class="col s12" style="height: 50vh;overflow-y: auto; scrollbar-width: auto;" onmouseover="this.style.overflow='auto'" onmouseout="this.style.overflow='hidden'">
	    
	    	<div class="card-panel">
	    		<table class="">
			        <thead>
			          <tr>
			          	  <th>#</th>
			              <th>User Full Name</th>
			              <th>Email</th>
			              <th>Gender</th>
			              <th>Action</th>
			          </tr>
			        </thead>
			        <tbody>
			        
			        	<print:set var="count_user" value="${1}" scope="session"/>								
	      				<print:forEach items="${rowuser.rows}" var="user" >
	      					<tr>
	      						<td>
	      							<print:out value="${count_user}"></print:out>
	      						</td>
	      						<td>
	      							<print:out value="${user.fname} "></print:out>
	      							<print:out value="${user.lname}"></print:out>
	      							
	      						</td>
	      						<td>
	      							<print:out value="${user.email}"></print:out>
	      						</td>
	      						<td>
	      							<print:out value="${user.gender}"></print:out>
	      							
	      						</td>
                                                        
                                                        
                                                            
	      						<td>
	      							<a class="btn-small btn-floating waves-effect waves-light teal lighten-3 edit-user" id="${user.id}"><i class="material-icons">create</i></a>
	      							<a class="btn-small btn-floating waves-effect waves-light teal lighten-3 view" id="${user.id}"><i class="material-icons">remove_red_eye</i></a>
	      							<a class="btn small btn-floating waves-effect waves-light red del_user" id="${user.id}"><i class="material-icons">delete</i></a>
	      						</td>
	      					</tr>
	      					<print:set var="count_user" value="${count_user + 1}" />
						</print:forEach>
			        </tbody>
	        	</table>
	    	</div>
	    </div>
            <div id="test-swipe-2" class="col s12" style="height: 50vh;overflow-y: auto; scrollbar-width: auto;" onmouseover="this.style.overflow='auto'" onmouseout="this.style.overflow='hidden'">
	    
	    	<div class="card-panel">
	    		<table class="">
			        <thead>
			          <tr>
			          	  <th>#</th>
			              <th>Music Title</th>
			              <th>Artist(s)</th>
			              <th>Price(£)</th>
			              <th>Duration</th>
                                      <th>Sales</th>
                                      <th>Action</th>
			          </tr>
			        </thead>
			        <tbody>
			        
			        	<print:set var="count_music" value="${1}" scope="session"/>								
	      				<print:forEach items="${rowmusic.rows}" var="music" >
	      					<tr>
	      						<td>
	      							<print:out value="${count_music}"></print:out>
	      						</td>
	      						<td>
	      							<print:out value="${music.title} "></print:out>			
	      						</td>
	      						<td>
	      							<print:out value="${music.artist}"></print:out>
	      						</td>
	      						<td>
	      							<print:out value="${music.price}"></print:out>0
	      							
	      						</td>
                                                        <td>
	      							<print:out value="${music.duration}"></print:out>
	      							
	      						</td>
                                                        
                                                        <sql:query var="rowsales" dataSource="${db}">
                                                            SELECT * FROM order_history WHERE is_delivered > 0 AND musicid=?
                                                            <sql:param value = "${music.id}" />
                                                           
                                                      </sql:query>
                                                           
                                                        <td>
                                                            <print:out value="${rowsales.rowCount}"></print:out>

                                                        </td>
                                                         
	      						<td>
	      							
	      							<a class="btn-small btn-floating waves-effect waves-light teal lighten-3 edit-music" id="${music.id}"><i class="material-icons">create</i></a>
	      							<a class="btn small btn-floating waves-effect waves-light red del_music" id="${music.id}"><i class="material-icons">delete</i></a>
	      						</td>
	      					</tr>
	      					<print:set var="count_music" value="${count_music + 1}" />
						</print:forEach>
			        </tbody>
	        	</table>
	    	</div>
	    </div>
            <div id="test-swipe-3" class="col s12" style="height: 50vh;overflow-y: auto; scrollbar-width: auto;" onmouseover="this.style.overflow='auto'" onmouseout="this.style.overflow='hidden'">
	    
	    	<div class="card-panel">
	    		<print:choose>
                      <print:when test="${rsch.rowCount < 1}">
                            
                            <span>No recent order yet</span>
                          
                      </print:when>
                      <print:otherwise>
                          <ul class="collection">
                            <print:forEach items="${rsch.rows}" var="orderh">   
                              <li class="collection-item avatar ">
                                <img src="cover.jpg" alt="" class="circle">
                                <span class="title">${orderh.title}</span>
                                <p> ${orderh.artist} (Artist(s))<br>
                                    £${orderh.price}0 (Price)<br>
                                </p>
                                <p style="font-style: italic; font-size: 12px;"> 
                                   
                                   <span style="font-style: italic; font-size: 12px;">Ordered on:</span>
                                   ${orderh.time_order}
                                </p>
                                <print:choose>
                                    <print:when test="${orderh.is_delivered < 1}">
                                        
                                        <p class="red-text" style="font-style: italic; font-size: 12px;">  
                                            Pending Delivery
                                         </p>
                                    </print:when>
                                    <print:otherwise>
                                        <p class="green-text" style="font-style: italic; font-size: 12px;">  
                                            Delivered
                                         </p>
                                    </print:otherwise>
                                    
                                </print:choose>
                                
                                
                              </li>
                          </print:forEach>

                        </ul>
                          
                      </print:otherwise>      
                      
                      
                  </print:choose>
	    	</div>
	    </div>
    </div>
</div>





<%@ include file="mid.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		$(".button-collapse").sideNav();
		
		$('#modal1').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
		$('#modal2').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
		$('#modal3').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
		$('#modal4').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
                
                $('#modal5').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
		
		$(document).on('click','.view', function() {
			
			 var id = $(this).attr('id');
		 
			   $.ajax({

		          url: "viewUser.jsp",
		          type: "POST",
		          data:{id:id},
		          success:function(data){
                                $('#mod-1').html(data);
                                $('#modal1').modal('open'); 
		          }
		     });  
	   });
		
	
		
        //Delete data
        $(document).on('click','.del_user', function() {


             var del_id = $(this).attr('id');
             
             
             
              $.ajax({

                  url: "delUserData.jsp",
                  type: "POST",
                  data:{del_id:del_id},
                  success:function(data){
                       $("#del-user").html(data);
                       $('#modal2').modal('open');
                  }


             });  

        });
        
        $(document).on('click', '#del', function(){
        	

            $.ajax({

                url: "saveDelUser.jsp",
                type: "POST",
                data:$("#del-edu_form").serialize(),
                success:function(data){
               	  $('#modal2').modal('close');
		 window.location.reload(true); 
                }
           }); 
      });
      
      
      $(document).on('click', '.edit-music', function(){
          
          var edit_id = $(this).attr('id');

            $.ajax({

                url: "updateMusic.jsp",
                type: "POST",
                 data:{edit_id:edit_id},
                success:function(data){
                   $('#edit-creds').html(data);
		   $('#modal3').modal('open'); 

                }
           }); 
      });
      
      
      $(document).on('click', '#update-edu', function(){
                $.ajax({

                url: "saveMusicData.jsp",
                type: "POST",
                data:$("#update-edu_form").serialize(),
                success:function(data){
                       $('#modal3').modal('close');
                       window.location.reload(true);
                }
           }); 
	});
        
        
        $(document).on('click', '.edit-user', function(){
          
          var edit_id = $(this).attr('id');

            $.ajax({

                url: "updateUser.jsp",
                type: "POST",
                 data:{edit_id:edit_id},
                success:function(data){
                   $('#edit-creds').html(data);
		   $('#modal3').modal('open'); 

                }
           }); 
      });
      
      
      $(document).on('click', '#update-edu', function(){
                $.ajax({

                url: "saveUserData.jsp",
                type: "POST",
                data:$("#update-edu_form").serialize(),
                success:function(data){
                       $('#modal3').modal('close');
                       window.location.reload(true);
                }
           }); 
	});
        
        
      
      
      //Delete music data
        $(document).on('click','.del_music', function() {


             var del_id = $(this).attr('id');
             
             
             
              $.ajax({

                  url: "delMusicData.jsp",
                  type: "POST",
                  data:{del_id:del_id},
                  success:function(data){
                       $("#del-user").html(data);
                       $('#modal2').modal('open');
                  }


             });  

        });
        
        
        
        //Delete music data
        $(document).on('click', '#del', function(){
        	

            $.ajax({

                url: "saveDelMusic.jsp",
                type: "POST",
                data:$("#del-edu_form").serialize(),
                success:function(data){
               	  $('#modal2').modal('close');
		 window.location.reload(true); 
                }
           }); 
      });
        
        $(document).on('click', '.add-user', function(){
        	
                $('#modal4').modal('open'); 
            
      });
      
      $(document).on('click', '#create', function(){
                $.ajax({

                url: "saveCreateData.jsp",
                type: "POST",
                data:$("#create-user_form").serialize(),
                success:function(data){
                       $('#modal4').modal('close');
                       window.location.reload(true);
                }
           }); 
	});
        
        $(document).on('click', '.add-music', function(){
        	
                $('#modal5').modal('open'); 
            
      });
      
      $(document).on('click', '#create-product', function(){
                $.ajax({

                url: "saveCreateMusic.jsp",
                type: "POST",
                data:$("#create-music_form").serialize(),
                success:function(data){
                       $('#modal5').modal('close');
                       window.location.reload(true);
                }
           }); 
	});
      
 	
	});
	

</script>


<%@ include file="footer.jsp" %>



<!-- Viewing Users Credentials-->
	  <div id="modal1" class="modal modal-fixed-footer" style="height:40%; " >
	    <div class="modal-content" >
	      <h4 class="center-align">USER DETAILS</h4>
	      	<div class="row center-align" id="mod-1">  
	      	 
				      	
	      	</div>
	      
	    </div>
	    <div class="modal-footer">
	      <a href="" class="modal-close waves-effect waves-light btn-flat red-text">Close</a>
	    </div>
	  </div>

<!-- Modal for Deleting User-->
	  <div id="modal2" class="modal modal-fixed-footer" style="width: 30%; height:20%">
	  	<form method="POST" id="del-edu_form" action="#">
	    <div class="modal-content" >
	      <h4 class="center-align">Confirmation</h4>
	      
	      	<div class="row center-align" id="del-user">
	      	
	      	</div>
	      
	    </div>
	    <div class="modal-footer">
	      <a href="#" class="modal-close waves-effect waves-light btn-flat teal white-text">No</a>
	      <a href="#" class="waves-effect waves-light btn-flat red white-text" id="del" id="del">Yes</a>
	    </div>
	    </form>
	  </div>



<!-- Modal for Editing  Credentials-->
    <div id="modal3" class="modal modal-fixed-footer" style="width: 40%; height: 40%;">
          <form method="POST" id="update-edu_form" action="#">
      <div class="modal-content" >
        <h4 class="center-align">Edit</h4>
          <div class="row center-align" id="edit-creds">

          </div>

      </div>
      <div class="modal-footer">
        <a href="#" class="modal-close waves-effect waves-light btn red">Close</a>
        <a href="#" class="waves-effect waves-light btn" id="update-edu">Update</a>
      </div>
      </form>
    </div>


  

<!-- Modal for Adding  User Credentials-->
    <div id="modal4" class="modal modal-fixed-footer" style="width: 40%; height: 60%;">
          <form method="POST" id="create-user_form" action="#">
      <div class="modal-content" >
        <h4 class="center-align">Add User</h4>
          <div class="row center-align" id="edit-creds">
                <div class="col s12">
                 
                <div class=input-field>	
                    <label>Username:</label><br>
                    <input type="text" id="username" name="username" value="<%=newUserName %>" readonly>
                </div>
         </div>
	
	 <div class="col s12 m6 l6">
		<div class=input-field>
			<label>First Name:</label><br>
			<input type="text" id="fname" name="fname" >
		</div>
	</div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Last Name:</label><br>
			<input type="text" id="lname" name="lname" >
			
		</div>
	</div>

	<div class="col s12">
		<div class=input-field>
			<label>Email:</label><br>
			<input type="text" id="email" name="email" >
		</div>
	</div>
                
         <div class="col s12">
                                        
            
             
             
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
      <div class="modal-footer">
        <a href="#" class="modal-close waves-effect waves-light btn red">Close</a>
        <a href="#" class="waves-effect waves-light btn" id="create">Create</a>
      </div>
      </form>
    </div>
                
                
<!-- Modal for Adding  User Music-->
    <div id="modal5" class="modal modal-fixed-footer" style="width: 40%; height: 40%;">
          <form method="POST" id="create-music_form" action="#">
      <div class="modal-content" >
        <h4 class="center-align">Add Product</h4>
          <div class="row center-align" id="edit-creds">
               
              <div class="col s12 m6 l6">
		<div class=input-field>
			<label>Title</label><br>
			<input type="text" id="title" name="title" >
		</div>
	</div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Artist</label><br>
			<input type="text" id="artist" name="artist" >
			
		</div>
	</div>
	
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Price (£)</label><br>
			<input type="text" id="price" name="price" >
		</div>
	</div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Duration</label><br>
			<input type="text" id="duration" name="duration" >
			
		</div>
	</div>	
	
          </div>

      </div>
      <div class="modal-footer">
        <a href="#" class="modal-close waves-effect waves-light btn red">Close</a>
        <a href="#" class="waves-effect waves-light btn" id="create-product">Create</a>
      </div>
      </form>
    </div>