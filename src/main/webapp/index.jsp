<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>eLoan system</title>
	</head>
	<body>
		<!-- write the html code to read user credentials and send it to validateservlet
		    to validate and user servlet's registernewuser method if create new user
		    account is selected
		-->
		<jsp:include page="header.jsp" />
		<hr />
		<div align=center>
			<h2>eLoan Login</h2>
			<form action="user?action=validate" method="post">
				<div>
					<label for="loginid">Enter Login ID</label>										
					<input type="text" id="loginid" name="loginid" autocomplete=off placeholder="Enter your Login ID" required>					
				</div>
				<br>
				<div>
					<label for="password">Enter Password</label>					
					<input type="password" id="password" name="password" placeholder="Enter your Password" required>				
				</div>
				<br>
				<div>
					<input type="submit" value="Login">
				</div>
				<br>	
				<a href="register.jsp">New User? Register Here</a>
			</form>
		</div>
		<hr />
		<jsp:include page="footer.jsp" />
	</body>
</html>