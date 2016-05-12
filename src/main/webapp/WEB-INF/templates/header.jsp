<header class="header">
	<p id="info" align="right">
		<span id="info">
			<% String name = request.getRemoteUser();%>
			<%=name %>
			logged in as: 
			<% int balance = Integer.MIN_VALUE;%>
			<% if(request.getAttribute("balance") != null) balance = (Integer)request.getAttribute("balance");%>
			<% if(request.isUserInRole("ADMIN") && request.isUserInRole("USER")) {%>
				Administrator/User
			<%} else if(request.isUserInRole("ADMIN")){%>
				Administrator
			<%} else if(request.isUserInRole("USER")){%>
				User
			<%} %>	  
			<% if(balance != Integer.MIN_VALUE) {%>
				Balance: $<%=balance%>	
			<%}	%>
			<a type="submit" style="color: #FFFFFF; text-decoration: none;" class="buttonHolder" href="/Password">&nbsp;&nbsp;&nbsp;
				<button style="background-color:darkgreen;" label="Reset Password">Reset Password</button>
			</a>
			<a style="color: #FFFFFF; text-decoration: none;" class="buttonHolder" href="/LogOut">&nbsp;
				<button style="background-color:darkred;" label="Log Off">Log Off</button>
			</a>
		</span>
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