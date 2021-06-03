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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Display All Loans</title>
	</head>
	<body>
		<!-- write code to display all the loan details 
	             which are received from the admin controllers' listall method
		--> 
		<center><h2>Loan Applications</h2></center>
		<div align="right">			
			<a href="index.jsp">Logout</a>
		<hr />
		<%
		    try
		    {		        
		    	connection=(Connection)DriverManager.getConnection(jdbcURL,jdbcUsername,jdbcPassword);
		        statement=connection.createStatement();
		        ResultSet rs=statement.executeQuery("select * from loaninfo;");
		%>
		    <table border=1 align=center style="text-align:center">
		    	<thead>
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
		        
		<%
				while(rs.next())
		        {
		%>
		            <tr>
		                <td><%=rs.getInt(1) %></td>
		                <td><%=rs.getString(2) %></td>
		                <td><%=rs.getInt(3) %></td>
		                <td><%=rs.getString(4) %></td>
		                <td><%=rs.getString(5) %></td>
		                <td><%=rs.getString(6) %></td>
		                <td><%=rs.getString(7) %></td>
		                <td><%=rs.getString(8) %></td>
		                <td><%=rs.getString(9) %></td>
		                <td><%=rs.getString(10) %></td>
		                <td><%=rs.getString(11) %></td>
		            </tr>
		<%
				}
		%>
				</tbody>
			</table>
			<br>
		<%
			}
		    catch(Exception e)
			{
		        out.print(e.getMessage());
		%>
			<br>
		<%
		    }
		    finally
		    {
		        statement.close();
		        connection.close();
		    }
		%>		
	</body>
</html>