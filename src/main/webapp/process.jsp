<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Process Loan</title>
	</head>
	<body>
		<!-- write the code to read application number, and send it to admincontrollers
			     callemi method to calculate the emi and other details also provide links
			     to logout and admin home page
			-->
		<jsp:include page="header.jsp" />
		<div align="right">
			<a href="index.jsp">Logout</a> 
			<br>
			<a href="adminhome1.jsp">Home</a>
		</div>
		<h4>Process Loan Application</h4>
		<hr />
		<form action="admin?action=callemi" method="post">
			<div>
				<label>Loan Application Number</label> 
				<input type="text" id="applno" name="applno" placeholder="Enter the Application Number" required>
			</div>
			<br>
			<div>
				<button type="submit" value="submit">Submit</button>
			</div>
	
		</form>
		<hr />
		<jsp:include page="footer.jsp" />
	
	</body>
</html>