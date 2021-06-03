<%@page import="com.iiht.evaluation.eloan.model.LoanInfo"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Edit Loan Details</title>
	</head>
	<body>
		<jsp:include page="header.jsp"/>
		
		<div align=center>
			<h2>eLoan - Edit Loan Details</h2>
		</div>
		<div align="right"><a href="index.jsp">Logout</a></div>
		<hr />
		<div>
			<form name="appl" action="user?action=editLoanProcess" method="post">
				<div>
				<%
						List loanDetails = (List)request.getSession().getAttribute("loans");
						Iterator lditr = loanDetails.iterator();
						LoanInfo loaninfo = new LoanInfo();
				
						while(lditr.hasNext())
						{
							loaninfo = (LoanInfo)lditr.next();
						}
				%>
					<table border=1>
						<tbody>							
							<tr>
								<td>Loan application Number:</td>								
								<td>
									<input type="text" id="applno" name="applno" value=<%=loaninfo.getApplno()%> readonly>
								</td>								
							</tr>
							
							<tr>
								<td>
									<label for="Loantypes">Loan Type:</label>
								</td>
								<td>
									<input type="text" id="loantype" name="loantype" value=<%=loaninfo.getPurpose()%> readonly>
								</td>
							</tr>
							
							<tr>
								<td>Loan Amount Required:</td>
								<td>
									<input type="text" id="loanAmountRequested"	name="loanAmountRequested" value=<%= loaninfo.getAmtrequest() %> required></td>
							</tr>
							<tr>
								<td>Loan Application Date:</td>
								<td>
									<input type="date" id="loanApplicationDate"	name="loanApplicationDate" value=<%=loaninfo.getDoa()%> readonly></td>
							</tr>
							
							<tr>
								<td>Business Structure:</td>
								<td>
									<%
										String selected_bStructure = loaninfo.getBstructure(); 
										
										if(selected_bStructure.equalsIgnoreCase("individual"))
										{
									%>
											<input type="radio" id="individual"	name="businessStructure" value="Individual" checked="true" required> 
											<label for="individual">Individual</label> 
											<br>
											<input type="radio" id="organisation" name="businessStructure" value="Organisation" required> 
											<label for="organisation">Organisation</label>
											<br>
									<%	
										}
										else if(selected_bStructure.equalsIgnoreCase("organisation"))
										{
									%>
											<input type="radio" id="individual"	name="businessStructure" value="Individual" required> 
											<label for="individual">Individual</label> 
											<br>
											<input type="radio" id="organisation" name="businessStructure" value="Organisation" checked="true" required> 
											<label for="organisation">Organisation</label>
											<br>
									<%	
										}										
									%>										
								</td>
							</tr>
							<tr>
								<td>Billing Indicator:</td>
								<td>									
									<%
										String selected_bIndicator = loaninfo.getBindicator(); 
										
										if(selected_bIndicator.equalsIgnoreCase("Salaried"))
										{
									%>
											<input type="radio" id="salaried" name="billingIndicator" value="Salaried" checked="true" required> 
											<label for="salaried">Salaried</label> 
											<br> 
											<input type="radio"	id="non-salaried" name="billingIndicator" value="Non-Salaried" required>
											<label for="non-salaried">Non-Salaried</label> 
											<br>
									<%	
										}
										else if(selected_bIndicator.equalsIgnoreCase("Non-Salaried"))
										{
									%>
											<input type="radio" id="salaried" name="billingIndicator" value="Salaried" required> 
											<label for="salaried">Salaried</label> 
											<br> 
											<input type="radio"	id="non-salaried" name="billingIndicator" value="Non-Salaried" checked="true" required>
											<label for="non-salaried">Non-Salaried</label> 
											<br>
									<%	
										}										
									%>	
								</td>
							</tr>
							
							<tr>
								<td>Tax Indicator:</td>
								<td>
									<%
										String selected_tIndicator = loaninfo.getTindicator(); 
										
										if(selected_tIndicator.equalsIgnoreCase("TaxPayee"))
										{
									%>
											<input type="radio" id="taxPayee" name="taxIndicator" value="TaxPayee" checked="true" required>
											<label for="taxPayee">Tax Payee</label> 
											<br> 
											<input type="radio" id="non-taxPayee" name="taxIndicator" value="Non-TaxPayee" required> 
											<label for="non-taxPayee">Non-Tax Payee</label> 
											<br> 
									<%	
										}
										else if(selected_tIndicator.equalsIgnoreCase("Non-Non-TaxPayee"))
										{
									%>
											<input type="radio" id="taxPayee" name="taxIndicator" value="TaxPayee" required>
											<label for="taxPayee">Tax Payee</label> 
											<br> 
											<input type="radio" id="non-taxPayee" name="taxIndicator" value="Non-TaxPayee" checked="true" required> 
											<label for="non-taxPayee">Non-Tax Payee</label> 
											<br>
									<%	
										}										
									%>	
									
								</td>
							</tr>
							<tr>
								<td>Contact Address:</td>
								<td>
									<input type="textarea" id="address" name="address" maxlength="45" value=<%=loaninfo.getAddress()%> required>
								</td>
							</tr>
							<tr>
								<td>e-mail ID:</td>
								<td><input type="text" id="emailid" name="emailid" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}" value=<%=loaninfo.getEmail()%> required></td>
							</tr>
							<tr>
								<td>Mobile Number:</td>
								<td><input type="text" id="mobile" name="mobile" pattern="[6-9]{1}[0-9]{9}" maxlength="10" value=<%=loaninfo.getMobile()%> required></td>
							</tr>
						</tbody>
					</table>
					<br> <br>
					<div>
						<input type="submit" value="Edit Loan Details"> 
					</div>
				</div>
			</form>
		</div>
		
		<jsp:include page="footer.jsp"/>
	</body>
</html>