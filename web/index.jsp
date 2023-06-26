<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! 
    String title = "Start Page";
%>

<%@ include file="header.jsp" %>




 <div class="container" id="reg-container">
 	
    <div class="card">
            <div class="card-content">
                    <div class="row"></div>
                    <span class="card-title center-align blue-text text-ligthen-1 center-align" style="font-size: 2em;">HITASTIC! <br> MUSIC PURCHASE PLATFORM</span>
                    <br>
                    <br>
                    <p class="blue-text text-accent-4 center-align" style="font-size:1.3em">For more info:</p>
                    <br>
                    <div class="contain center-align">
                            <p class="blue-text text-accent-4" style="font-size:1.3em">Email:</p>
                            <p class="purple-text lighten-2" style="font-size:1.3em">hitastic.co.uk</p>
                    </div>

                    <div class="contain center-align">
                            <p class="blue-text text-accent-4 " style="font-size:1.3em">Website:</p>
                            <p class="purple-text lighten-2" style="font-size:1.3em"><a href="#">www.hitastic.co.uk</a></p>
                    </div>

                    <br> 
                    <br>

                    <div class="hide-on-med-and-down card-action center-align">
                    <a href="start" class="white-text  btn waves-effect waves-light">Register</a>
            <a href="login.jsp" class="white-text  btn waves-effect waves-light">Log in</a>	
            <a href="adminindex.jsp" class="white-text  btn waves-effect waves-light">Admin</a>		
                    </div>

                    <div class="row">
                      <div class="hide-on-large-only card-action center-align">
                            <div class="col s12">
                                    <a href="start" class="white-text  btn waves-effect waves-light" style="margin-top:5%; width:80%">Register</a>
                            </div>
                            <div class="col s12">
                                    <a href="login.jsp" class="white-text  btn waves-effect waves-light" style="margin-top:5%; width:80%">Log in</a>
                            </div>
                            <div class="col s12">
                                    <a href="adminindex.jsp" class="white-text  btn waves-effect waves-light" style="margin-top:5%; width:80%">Admin</a>		
                            </div>

                    </div>
                    </div>


            </div>
    </div> 	
 </div>

    

<%@ include file="mid.jsp" %>

<%@ include file="footer.jsp" %>
