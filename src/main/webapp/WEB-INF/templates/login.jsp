<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta name="viewport" content ="width=device-width, user-scalable=no">
		<link rel="stylesheet" href="/static/css/bootstrap.css">
		<link rel="stylesheet" href="/static/css/bootstrap.min.css">
		<link rel="stylesheet" href="/static/css/styles.css">
		<link rel="stylesheet" href="/static/css/indexStyleSheet.css">
		<script src="/static/js/jquery.js"></script>
		<title>Strike Force - Electronic Checkbook</title>
	</head>
<body>
	<header class="header">
		<img class="logo" src= "/static/images/OgdenCityPD.png" alt= "OgdenCityPDLogo"/>
	</header>
	
    <div class="container">
	
      <form action="doLogin" method="post" class="form-signin">
      	<div class="formDiv">
	        <h2 class="form-signin-heading">Please Login</h2>
	        <label class="loginLabel">Email:</label>
	        <input type="text" class="input-block-level" name="username" id="username" autofocus>

	        <label class="loginLabel">Password:</label>
	        <input type="password" class="input-block-level" id="password" name="password">

	        <button class="btn btn-large btn-primary" type="submit">Sign in</button>
        </div>
        <%//${error_div}%>

      </form>

    </div> <!-- /container -->
    <div class="footer">&copy;Ogden City Police Department</div>
	<%  
		 response.setHeader("Pragma","no-cache");  
		 response.setHeader("Cache-Control","no-store");  
		 response.setHeader("Expires","0");  
		 response.setDateHeader("Expires",-1);  
	 %>  
  	
<script>

</script>
</body>
</html>

<%--
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<tags:template pageTitle="Application">
    <jsp:attribute name="head">
        I'm header content!
    </jsp:attribute>
    <jsp:attribute name="footer">
        I'm footer content!
    </jsp:attribute>
    <jsp:body>
        <body>
        <h1>Hello world!</h1>
        </body>
    </jsp:body>
</tags:template>
--%>