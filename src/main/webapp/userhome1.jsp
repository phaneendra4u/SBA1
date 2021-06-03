<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>User Home</title>
	</head>
	
	<body>
		<!-- write the html code to display hyperlinks for user functionalities -->
		<jsp:include page="header.jsp" />
		<h4>User Dash Board</h4>
		<div align="right">			
			<a href="index.jsp">Logout</a>
		</div>
		<a href="application.jsp">Apply for Loan</a>
		<br>
		<a href="trackloan.jsp">Track Loan Application</a>
		<br>
		<a href="editloan.jsp">Edit Loan Application</a>
		<jsp:include page="footer.jsp" />
	</body>
</html>