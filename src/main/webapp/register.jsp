<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>eLoan User Registration</title>
	</head>
	<body>
		<jsp:include page="header.jsp" />
		<div align="right"><a href="index.jsp">Home</a></div>
		<hr />
		<div align=center>
			<h2>eLoan User Registration</h2>
			<form action="user?action=registerNewUser" autocomplete="off" method="post">
				<div>
					<label for="loginid">Enter Login ID</label>				
					<input type="text" id="loginid" name="loginid" required>
				</div>
				<br>	
				
				<div>
					<label for="password">Enter Password</label>				
					<input type="password" id="password" name="password" required>
				</div>
				<br>
				
				<div>
					<input type="submit" value="Register User">
				</div>				
			</form>
		</div>
		<hr />
		<jsp:include page="footer.jsp" />
	</body>
</html>