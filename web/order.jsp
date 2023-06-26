<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%! 
    String title = "Orders";
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
        <print:set var = "id"  value = "${user.id}"/>      
    </print:forEach>
            
    
            
       <!-- Cart count queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
	    <sql:query var="rsci" dataSource="${db}">
	    SELECT * FROM cart WHERE userid=?
            <sql:param value = "${id}" />
	    </sql:query>     
    
    
    <!-- Order  queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
	    <sql:query var="rsc" dataSource="${db}">
	    SELECT * FROM orders WHERE userid=? AND is_delivered < 1
            <sql:param value = "${id}" />
	    </sql:query>
            
    <!-- Order  queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
	    <sql:query var="rsch" dataSource="${db}">
	    SELECT * FROM order_history WHERE userid=?
            <sql:param value = "${id}" />
	    </sql:query> 
    
    
    <!-- Cart sum queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
	    <sql:query var="rscsum" dataSource="${db}">
	    SELECT SUM(price) AS summ FROM cart WHERE userid=?
            <sql:param value = "${id}" />
	    </sql:query>
            
         <print:forEach items="${rscsum.rows}" var="sum"> 
        <print:set var = "sum" scope = "session" value = "${sum.summ}"/>      
        </print:forEach>
            
            
    
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
                            <print:when test="${rsci.rowCount < 1}">
                                
                            </print:when>
                            <print:otherwise>
                                <span class="new badge red">
                            <print:out value="${rsci.rowCount}"></print:out>
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
                            <print:when test="${rsci.rowCount < 1}">                                
                            </print:when>
                            <print:otherwise>
                                <span class="new badge red">
                            <print:out value="${rsci.rowCount}"></print:out>
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
        
        <ul class="collapsible">
            <li >
              <div class="collapsible-header"><i class="material-icons">add_shopping_cart</i>Orders</div>
              <div class="collapsible-body">
                  <print:choose>
                      <print:when test="${rsc.rowCount < 1}">
                            
                            <span>No recent order yet</span>
                          
                      </print:when>
                      <print:otherwise>
                          <ul class="collection">
                            <print:forEach items="${rsc.rows}" var="order">   
                              <li class="collection-item avatar ">
                                <img src="cover.jpg" alt="" class="circle">
                                <span class="title">${order.title}</span>
                                <p> ${order.artist} (Artist(s))<br>
                                    £${order.price}0 (Price)<br>
                                </p>
                                <p style="font-style: italic; font-size: 12px;"> 
                                   <span style="font-style: italic; font-size: 12px;">Ordered on:</span>
                                   ${order.time_order}
                                </p>
                                
                                <a  class="secondary-content download-btn"  id="${order.id}">
                                    <i class="material-icons">arrow_downward</i>
                                    <audio hidden>
                                        <source src="order.ogg" type="audio/ogg">
                                        <source src="order.mp3" type="audio/mpeg">
                                    </audio>
                                </a>
                              </li>
                          </print:forEach>

                        </ul>
                          
                      </print:otherwise>      
                      
                      
                  </print:choose>                
              </div>
            </li>
            <li class="active">
              <div class="collapsible-header"><i class="material-icons">history</i>Order History</div>
              <div class="collapsible-body">
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
            </li>
        </ul>
        
                
        
        
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
            
                $('.collapsible').collapsible();
              

             $(document).on('click', '.download-btn', function(){
                 
                    var id = $(this).attr('id');

                       $(".download-btn").attr("href", "order.mp3");
                       $(".download-btn").attr("download");

                        

                        $.ajax({
                        url: "deliverOrder.jsp",
                        type: "POST",
                        data:{id:id},
                        success:function(data){   
                            
                            window.location.reload(true);
                            
                        }
                    }); 
            });


        });
        
                    
</script>

<%@ include file="footer.jsp" %>