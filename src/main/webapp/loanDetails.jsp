<%@page import="com.iiht.evaluation.eloan.model.LoanInfo"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Loan application Details</title>
	</head>
	<body>	
		<h1>Loan Application Details</h1>
		<!-- write the code to display the loan status information 
			     received from usercontrollers' displaystatus method
			-->
		<div align="right">
			<a href="index.jsp">Logout</a>
		</div>
		<hr />
		<table border=1>
			<tbody>
				<thead style="font-weight:bold">
					<tr>					
						<th>Application Number</th>
						<th>Purpose of Loan</th>
						<th>Loan Amount Requested</th>
						<th>Date of Application</th>
						<th>Business Structure</th>
						<th>Business Indicator</th>
						<th>Tax Indicator</th>
						<th>Address</th>
						<th>E-Mail ID</th>
						<th>Mobile Number</th>
						<th>Status of Loan</th>
					</tr>					
				</thead>
				<tr>
					<%
						List loanDetails = (List)request.getSession().getAttribute("loans");
						Iterator lditr = loanDetails.iterator();
						LoanInfo loaninfo = new LoanInfo();
				
						while(lditr.hasNext())
						{
							loaninfo = (LoanInfo)lditr.next();
						}
					%>				
						<td><%= loaninfo.getApplno() %></td>
						<td><%= loaninfo.getPurpose() %></td>
						<td><%= loaninfo.getAmtrequest() %></td>
						<td><%= loaninfo.getDoa() %></td>
						<td><%= loaninfo.getBstructure() %></td>
						<td><%= loaninfo.getBindicator() %></td>
						<td><%= loaninfo.getTindicator() %></td>
						<td><%= loaninfo.getAddress() %></td>
						<td><%= loaninfo.getEmail() %></td>
						<td><%= loaninfo.getMobile() %></td>
						<td><%= loaninfo.getStatus() %></td>  
					
				</tr>
			</tbody>
		</table>	
	</body>
</html>