<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%! 
    String title = "Cart";
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
            
    
            
            
    
    
    <!-- Cart  queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/hitastic" user="root" password="1234"/>
	    <sql:query var="rsc" dataSource="${db}">
	    SELECT * FROM cart WHERE userid=?
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
        
        <div class="row">           
            <print:set var="count" value="${1}" scope="session"/>
             <print:choose>
                    <print:when test="${rsc.rowCount < 1}">
                        <div class="col s12">                       
                        <div class="card">
                        <div class="card-content ">
                          <span class="card-title center-align">Cart Empty!</span>                                        
                        </div>
                      </div>
                        
                    </print:when>
                 <print:otherwise>
                     <div class="col s12 m12 l8">
                     
                     <print:forEach items="${rsc.rows}" var="mus">
                        <div class="card">
                          <div class="card-content ">
                            <span class="card-title">Cart (<print:out value="${count}"></print:out>)</span>
                                 
                                <p class="center-align"><span style="font-weight: bold;">Music Title:</span> ${mus.title}</p>
                                <p class="center-align"><span style="font-weight: bold;">Artist(s):</span> ${mus.artist}</p>
                                <p class="center-align"><span style="font-weight: bold;">Price:</span> <fmt:formatNumber value="${mus.price}" type="currency" currencySymbol="£"></fmt:formatNumber></p>
                          </div>
                          <div class="card-action">
                            <a href="#" class="btn red del-music" id="${mus.musicid}">Delete</a>
                          <a href="#" class="btn pay" id="${mus.title}-${mus.artist}-${mus.price}-${sum}-${mus.userid}-${mus.musicid}">Proceed To Payment</a>
                          </div>
                        </div>

                      <print:set var="count" value="${count + 1}" />
                      </print:forEach>
                      </div>
                      <div class="col s12 m12 l4">

                          <div class="card-panel center-align">
                              <p class="card-title" style="font-weight: bold;">Cart Summary</p>
                              <p class="" style="font-weight: bold";>Subtotal <span class="center-align" style="font-weight: normal"><fmt:formatNumber value="${sum}" type="currency" currencySymbol="£"></fmt:formatNumber></span></p>                                
                           </div>
                      </div>
                     
                 </print:otherwise>                   
                </print:choose>
            
            
            
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
  <a class="grey-text text-lighten-4 right" href="#">More...</a>
  </div>
</div>
</footer>

<%@ include file="mid.jsp" %>

<script>
            
            $(document).ready(function(){    
                $(".button-collapse").sideNav();
                $('#modal1').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
                $('#modal3').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
                
                $(document).on('click', '.del-music', function(){
				
                    var del_id = $(this).attr('id')+" "+'${id}';
                    
                    //alert(del_id);
                    
                    $.ajax({

                      url: "delCartData.jsp",
                      type: "POST",
                      data:{del_id:del_id},
                      success:function(data){
                           $("#del-creds").html(data);
                           $('#modal3').modal('open');
                      }


                    }); 
                          
				
                });
                
                $(document).on('click', '#del', function(){
        	

                        $.ajax({

                            url: "saveDelCartData.jsp",
                            type: "POST",
                            data:$("#del-edu_form").serialize(),
                            success:function(data){
                                $('#modal3').modal('close');
                                window.location.reload(true); 
                            }
                       }); 


                });
                
                $(document).on('click', '.pay', function(){
                    
                    var order_details = $(this).attr('id');   
                     
                     
                    $.ajax({

                      url: "orderData.jsp",
                      type: "POST",
                      data:{order_details:order_details},
                      success:function(data){
                             
                           $("#pay-creds").html(data);
                           $('#modal1').modal('open');
                      }
                   });
                     
                });
                
                $(document).on('click', '#buy', function(){
                        $.ajax({

                            url: "saveOrderData.jsp",
                            type: "POST",
                            data:$("#order_form").serialize(),
                            success:function(data){                               
                                $('#modal1').modal('close');
                                alert("Order placed successfully");
                                window.location.reload(true); 
                            }
                       }); 
                });
                
                
                   
            });
                    
</script>







<%@ include file="footer.jsp" %>


<!-- Modal for Deleting Employee Education Credentials-->
    <div id="modal3" class="modal modal-fixed-footer" style="width: 30%; height:20%">
          <form method="POST" id="del-edu_form" action="#">
      <div class="modal-content" >
        <h4 class="center-align">Confirmation</h4>

          <div class="row center-align" id="del-creds">

          </div>

      </div>
      <div class="modal-footer">
        <a href="#" class="modal-close waves-effect waves-light btn-flat teal white-text">No</a>
        <a href="#" class="waves-effect waves-light btn-flat red white-text" id="del" id="del">Yes</a>
      </div>
      </form>
</div> 



<!-- Payment Modal-->
    <div id="modal1" class="modal modal-fixed-footer" style="width: 30%; height:40%">
          <form method="POST" id="order_form" action="#">
      <div class="modal-content" >
        <h4 class="center-align">Confirm Purchase</h4>

          <div class="row center-align" id="pay-creds">

          </div>

      </div>
      <div class="modal-footer">
        <a href="#" class="modal-close waves-effect waves-light btn-flat red white-text">Decline</a>
        <a href="#" class="waves-effect waves-light btn-flat  teal white-text" id="buy" >Buy</a>
      </div>
      </form>
</div>


