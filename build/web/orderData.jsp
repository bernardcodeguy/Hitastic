<%@ page import="java.sql.*" %>


<%! 

    String title = "";
    String artist = "";
    double price;
    double sum;
    String userid = "";
    String musicid = "";
    String fakeCardPlaceholder = "12947643-12836";

%>


<%	
        String order_details = request.getParameter("order_details");
	String [] data = order_details.split("-");
	
        title = data[0];
        artist = data[1];
        price = Double.parseDouble(data[2]);
        userid = data[4];
        musicid = data[5];
      
	
%>

		
<input type="hidden" id="userid" name="userid" value="<%=userid %>">
<input type="hidden" id="musicid" name="musicid" value="<%=musicid %>">
<input type="hidden" id="title" name="title" value="<%=title %>">
<input type="hidden" id="artist" name="artist" value="<%=artist %>">
<input type="hidden" id="price" name="price" value="<%=price %>">

<div class="col s12">
        <div class=input-field>
        <label for="card">Credit Card Number</label><br>
        <input class="active" id="" type="text"  id="card" name="card" value="<%=fakeCardPlaceholder %>" readonly="">
        </div>
</div>

<div class="col s12">
        <div class=input-field>
                <label for="amount">Amount Deducted</label><br>
                <input type="text" id="amount" name="amount" value="    -(£ <%=price%>0)" readonly>

        </div>
</div>
