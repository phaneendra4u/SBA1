<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <!--
     Read the values from the admin servlet and cal emi and other details and send to
     to the same admin servlet to update the values in the database 
  -->  
	<jsp:include page="header.jsp" />
	<div align="right">
		<a href="index.jsp">Logout</a>
	</div>
	<h4>EMI Calculator</h4>
	<hr />
	<form>
		<c:choose>
			<c:when
				test="${ApprovedLoanDetails==null || ApprovedLoanDetails.isEmpty() }">
				<p>No Records Found!!</p>
			</c:when>
			<c:otherwise>
				<table border="1" style="text-align: center"
					style="width:100%">
					<thead>
						<tr>
							<th>Loan Application Number</th>
							<th>Sanctioned Amount</th>
							<th>Term Payment Amount</th>
							<th>Payment Start Date</th>
							<th>Loan Closure Date</th>
							<th>EMI</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="approvedLoan" items="${ApprovedLoanDetails}">
							<tr>

								<td>${approvedLoan.applno }</td>
								<td>${approvedLoan.amotsanctioned }</td>
								<td>${approvedLoan.loanterm }</td>
								<td>${approvedLoan.psd }</td>
								<td>${approvedLoan.lcd }</td>
								<td>${approvedLoan.emi }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:otherwise>
		</c:choose>
	</form>

	<hr />
	<jsp:include page="footer.jsp" />
</body>
</html>