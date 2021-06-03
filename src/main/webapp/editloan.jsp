<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Edit Loan Application</title>
	</head>
	<body>
		<!-- read the application number to edit from user and send to 
		     user controller to edit info
		-->
		<jsp:include page="header.jsp" />
			<form action="user?action=editloan" method="post">
				<div align="right">
					<a href="index.jsp">Logout</a>
				</div>
				<hr />
				<div>
					<label>Loan Application Number to be tracked</label>
					<input type="text" id="applno" name="applno" placeholder="Application Number" required>
				</div>
				<br>
				<div>
					<button type="submit" value="submit">Submit</button>
				</div>
			</form>
		<jsp:include page="footer.jsp" />	
	</body>
</html>