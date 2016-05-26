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
			    <a href="/PasswordReset" onclick="newPassword()"><!-- type="submit" style="color: #FFFFFF; text-decoration: none;" class="buttonHolder" href="/Password">
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
<!---------------------------------- Add/Edit User Form -------------------------------------->
                    <form id="formNewPassword" name="formNewPass" action="/Administration/NewPassword" method="post">
                        <h2 id="formHeader">Password Change</h2>
                        <table id="newPasswordTable" class="table">

                            <tr>
                                <td>Old Password</td>
                                <td><input type="text" class="input-block-level" id="oldPassword" name="oldPassword" required pattern="[A-Za-z0-9]{8,20}" title="Between 8 and 20 alphanumeric characters" placeholder="Old Password">
                                    <input type="hidden" id="id" name="id">
                                </td>
                            </tr>

                            <tr>
                                <td>New Password</td>
                                <td><input type="text" class="input-block-level" id="newPassword" name="newPassword" required pattern="[A-Za-z0-9]{8,20}" title="Between 8 and 20 alphanumeric characters" placeholder="New Password"></td>
                            </tr>
                            
                            <tr>
                                <td>Retype New Password</td>
                                <td><input type="text" class="input-block-level" id="verifyNewPassword" name="verifyNewPassword" required pattern="[A-Za-z0-9]{8,20}" title="Between 8 and 20 alphanumeric characters" placeholder="Retype New Password"></td>
                            </tr>
                            
                        </table>
                        <input type="submit" value="Submit">
                        <input type="button" onclick="cancel()" value="Cancel">
                    </form>
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

<script type="text/javascript">
//jQuery


function newPassword(){
                $("#formAddEditUser").attr("action", "/Administration/NewPassword");
                userModal.dialog("open");
            }
userModal = $("#formNewPassword").dialog({
    autoOpen: false,
    modal: true,
    resizable: false,
    width: 'auto',
   /* buttons: {
        "Submit": addEditUser,
        Cancel: cancel
    }*/
});
</script>