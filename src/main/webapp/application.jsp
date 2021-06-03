<%@page import="java.time.LocalDate"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%	
	String driver = "com.mysql.jdbc.Driver";
	String jdbcURL = config.getServletContext().getInitParameter("jdbcUrl");
	String jdbcUsername = config.getServletContext().getInitParameter("jdbcUsername");
	String jdbcPassword = config.getServletContext().getInitParameter("jdbcPassword");

	try 
	{
		Class.forName(driver);
	} 
	catch (ClassNotFoundException e) 
	{
		e.printStackTrace();
	}
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Loan Application Form</title>
		<script	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	</head>
	
	<body onload="myFunction()">
		<jsp:include page="header.jsp" />
		<hr />
		<div align="right">
			<a href="index.jsp">Logout</a>
		</div>
		
		<div align=center>
			<h2>eLoan Loan Application</h2>
		</div>
		
		<div>
			<form name="appl" action="user?action=placeloan" method="post">
				<div>
					<table border=1>
						<tbody>							
							<%-- <tr>
								<td>Loan application Number:</td>
								<%
									int applno = 0;
									try 
									{
										connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
										statement = connection.createStatement();
										String sql = "select * from loaninfo order by applno desc limit 1";
																				
										resultSet = statement.executeQuery(sql);
										
										if (resultSet.next() == false) 
										{
											applno = 1;
										} 
										else 
										{
											while (resultSet.next()) 
											{
												applno = resultSet.getInt("applno") + 1;
											}
										}
								%>
								<td>
									<input type="text" id="applno" name="applno" value=<%=applno%> readonly>
								</td>
								<%
										connection.close();
									} 
									catch (Exception e) 
									{
										e.printStackTrace();
									}
								%>
							</tr> --%>
							
							<tr>
								<td>
									<label for="Loantypes">Choose a Loan Type:</label>
								</td>
								<td>
									<select id="loanTypes" name="loanTypes">
										<option value="Default">--Select--</option>
										<option value="AutoLoan">Auto Loan</option>
										<option value="HomeLoan">Home Loan</option>
										<option value="PersonalLoan">Personal Loan</option>
										<option value="GoldLoan">Gold Loan</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td>Loan Amount Required:</td>
								<td>
									<input type="text" id="loanAmountRequested"	name="loanAmountRequested" placeholder="Loan Amount Required" required></td>
							</tr>
							<tr>
								<td>Loan Application Date:</td>
								<td>
									<input type="date" id="loanApplicationDate"	name="loanApplicationDate" readonly value=<%=LocalDate.now()%>></td>
							</tr>
							
							<tr>
								<td>Business Structure:</td>
								<td>
									<input type="radio" id="individual"	name="businessStructure" value="Individual" required> 
									<label for="individual">Individual</label> 
									<br> 
									<input type="radio" id="organisation" name="businessStructure" value="Organisation" required> 
									<label for="organisation">Organisation</label>
									<br>
								</td>
							</tr>
							<tr>
								<td>Billing Indicator:</td>
								<td>
									<input type="radio" id="salaried" name="billingIndicator" value="Salaried" required> 
									<label for="salaried">Salaried</label> 
									<br> 
									<input type="radio"	id="non-salaried" name="billingIndicator" value="Non-Salaried" required>
									<label for="non-salaried">Non-Salaried</label> 
									<br>
								</td>
							</tr>
							
							<tr>
								<td>Tax Indicator:</td>
								<td>
									<input type="radio" id="taxPayee" name="taxIndicator" value="TaxPayee" required>
									<label for="taxPayee">Tax Payee</label> 
									<br> 
									<input type="radio" id="non-taxPayee" name="taxIndicator" value="Non-TaxPayee" required> 
									<label for="non-taxPayee">Non-Tax Payee</label> 
									<br>
								</td>
							</tr>
							<tr>
								<td>Contact Address:</td>
								<td>
									<input type="textarea" id="address" name="address" maxlength="45" placeholder="Enter Address" required>
								</td>
							</tr>
							<tr>
								<td>e-mail ID:</td>
								<td><input type="text" id="emailid" name="emailid" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}" placeholder="Enter Email ID" required></td>
							</tr>
							<tr>
								<td>Mobile Number:</td>
								<td><input type="text" id="mobile" name="mobile" pattern="[6-9]{1}[0-9]{9}" maxlength="10" placeholder="Enter Mobile Number" required></td>
							</tr>
						</tbody>
					</table>
					<br> <br>
					<div>
						<input type="submit" value="Apply Loan"> <input
							type="reset" value="Reset">
					</div>
				</div>
			</form>
		</div>
		<hr />
		<jsp:include page="footer.jsp" />
	</body>
</html>