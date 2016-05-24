<head>
<style>
.dropbtn {
    background-color: darkgreen;
    color: white;
    padding: 5px;
    border: none;
    cursor: pointer;
}
.dropdown {
    position: relative;
    display: inline-block;
}
.dropdown-content {
    display: none;
    right:0;
    position: absolute;
    text-align:left;
    background-color: #f9f9f9;
    min-width: 150px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}
.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}
.dropdown-content a:hover {background-color: #f1f1f1}
.dropdown:hover .dropdown-content {
    display: block;
}
.dropdown:hover .dropbtn {
    background-color: #3e8e41;
}
</style>
</head>
<header class="header">
	<p id="info" align="right">
		<span id="info">
			 
			Logged in as:
			<% String name = request.getRemoteUser();%>
			<%=name %>
			<% int balance = Integer.MIN_VALUE;%>
			<% if(request.getAttribute("balance") != null) balance = (Integer)request.getAttribute("balance");%>
			<%-- <% if(request.isUserInRole("ADMIN") && request.isUserInRole("USER")) {%>
				Administrator/User
			<%} else if(request.isUserInRole("ADMIN")){%>
				Administrator
			<%} else if(request.isUserInRole("USER")){%>
				User
			<%} %>	 --%>  
			<% if(balance != Integer.MIN_VALUE) {%>
				Balance: $<%=balance%>	
			<%}	%>
			<span class="dropdown">&nbsp;
			  <button class="dropbtn">Options</button>&nbsp;
			  <span class="dropdown-content">
			    <a href="/Profile">Profile Information</a>
			    <a href="/PasswordReset"><!-- type="submit" style="color: #FFFFFF; text-decoration: none;" class="buttonHolder" href="/Password">
				<button style="background-color:darkgreen;" label="Reset Password" -->Reset Password
				</a>
			    <a href="/LogOut"><!-- style="color: #FFFFFF; text-decoration: none;" class="buttonHolder" href="/LogOut">
				<button style="background-color:darkred;" label="Log Off"> -->Log Off
				</a> 
			  </span>
			</span>
		</span>
			

 			
			<!-- 
			
		
	</p>
	<!--align="center"-->
	<div id="center">
	    <img class="logo" src="/static/images/WMNSF.png" alt="WMNSFLogo"/>
	</div>
	
</header>
<div class="menu">
    <ul class="nav btn-group">
    	<% if (request.isUserInRole("ADMIN")) {%>
        	<li style="padding:5px"><a class="btn btn-success" style="background-color:darkgreen;" href="/Administration">Administration</a></li>
        <%}%>
        <li style="padding:5px"><a class="btn btn-success" style="background-color:darkgreen;" href="/Reports">Report</a></li>
        
        <% if (request.isUserInRole("USER")) {%>
        	<li style="padding:5px"><a class="btn btn-success" style="background-color:darkgreen;" href="/Transaction">Transaction</a></li>
        <%}%>
    </ul>
</div>  
<script>

</script>