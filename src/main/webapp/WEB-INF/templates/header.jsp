<header class="header">
	<p id="info" align="right">
		<span id="info">
			<% String name = request.getRemoteUser();%>
			<%=name %>
			logged in as: 
			<% if (request.isUserInRole("ADMIN") && request.isUserInRole("USER")) {%>
				Administrator/User
			<%} else if(request.isUserInRole("ADMIN")){%>
				Administrator
			<%} else if(request.isUserInRole("USER")){%>
				User
			<%} %>	  
			&nbsp;&nbsp;Balance:  &nbsp;&nbsp;
			&nbsp;&nbsp;User balance &nbsp;&nbsp;
			<a class="buttonHolder" href="/Password">&nbsp;Reset Password&nbsp;&nbsp;</a>
			<a class="buttonHolder" href="/LogOut">&nbsp;Log Off</a>
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
        	<li style="padding:5px"><a class="btn btn-success" href="/Administration">Administration</a></li>
        <%}%>
        <li style="padding:5px"><a class="btn btn-success" href="/Reports">Report</a></li>
        
        <% if (request.isUserInRole("USER")) {%>
        	<li style="padding:5px"><a class="btn btn-success" href="/Transaction">Transaction</a></li>
        <%}%>
    </ul>
</div>  
<script>

</script>