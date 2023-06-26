<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
    String title = "Home";
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
    <!-- User ID query -->
    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
	    <sql:query var="rsu" dataSource="${db}">
	    SELECT id FROM users WHERE username=?
	    <sql:param value = "${username}" />
    </sql:query>
            
            
            
    <print:forEach items="${rsu.rows}" var="user"> 
        <print:set var = "id" scope = "session" value = "${user.id}"/>      
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
    
            
   <div class="page-body" style="height: 80vh;">
    
    
    
    <div class="container" style="margin-top:20px;">
        <nav class="teal lighten-3">
        <div class="nav-wrapper">
            <form class="white-text" method="post" action="search.jsp">
            <div class="input-field">
              <input id="search" type="search" placeholder="Search music by artist or title" name="keyword" required>
              <label class="label-icon" for="search"><i class="material-icons">search</i></label>
              <i class="material-icons">close</i>
            </div>
          </form>
        </div>
      </nav>
    </div>

    <div class="container">       
        <div class="row">
            <!-- All music queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
	    <sql:query var="rs" dataSource="${db}">
	    SELECT * FROM music
	    </sql:query>
            
             <print:forEach items="${rs.rows}" var="music"> 
                 <div class="col s6 m6 l3">                
                    <div class="card">
                       <div class="card-image">
                         <img src="cover.jpg" width="200" height="200">

                       </div>
                       <div class="card-content">
                           <p><span style="font-weight: bold">Music Title: </span> <print:out value="${music.title}"></print:out></p>
                           <p><span style="font-weight: bold">Artist Name: </span> <print:out value="${music.artist}"></print:out></p>
                           <p><span style="font-weight: bold">Duration: </span> <print:out value="${music.duration}"></print:out></p>
                           <p><span style="font-weight: bold">Price: £</span>  <print:out value="${music.price}"></print:out>0</p>
                           
                       </div>
                       <div class="card-action">
                           <form   method="post" action="addCart.jsp">
                            
                            <input type="hidden" name="title" id="title" value="${music.title}" 
                                 class="form-control" >
                            <input type="hidden" name="artist" id="artist" value="${music.artist}" 
                             class="form-control" >
                            <input type="hidden" name="price" id="price" value="${music.price}" 
                             class="form-control" >
                            <input type="hidden" name="musicid" id="musicid" value="${music.id}" 
                             class="form-control" >
                            <input type="hidden" name="userid" id="userid" value="${id}" 
                             class="form-control" >
  
                            <button type="submit" class="btn btn-primary" id="join_meeting"><i class="material-icons">shopping_cart</i>  Add To Cart</button>
                            
                        </form>

                       </div>
                     </div>               
                </div>
             </print:forEach>
            
       
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
                $(document).on('click', '.add-to-cart', function(){
				
                    var musicid = $(this).attr('id');
                    var userid = '${id}';
                    $.ajax({
                        url: "addCart.jsp",
                        type: "POST",
                        data:{musicid:musicid,userid:userid},
                        success:function(data){
                             window.location.reload(true);
                        }


                    }); 
                          
				
                });
                   
            });
                    
</script>


<%@ include file="footer.jsp" %>