<header class="header">
	<p id="info" align="right">Balance:  &nbsp;
		<span id="info">User balance&nbsp;
			<a class="buttonHolder" href="/Password">Reset Password?&nbsp;&nbsp;</a>
			<a class="buttonHolder" href="/LogOut">Log Off</a>
		</span>
	</p>
	<div align="center">
	    <img class="divLogoContainer" src="/static/images/OgdenCityPD.png" alt="OgdenCityPDLogo"/>
	</div>
</header>
<div class="menu">
    <ul class="nav btn-group">
    	<% if (request.isUserInRole("ADMIN")) {%>
        <li style="padding:5px"><a class="btn btn-success" href="/Administration">Administration</a></li>
        <%}%>
        <li style="padding:5px"><a class="btn btn-success" href="/Reports">Report</a></li>
        <li style="padding:5px"><a class="btn btn-success" href="/Transaction">Transaction</a></li>
    </ul>
</div>  
<script>

</script>