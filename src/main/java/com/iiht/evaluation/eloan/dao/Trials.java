package com.iiht.evaluation.eloan.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Trials {

	public static void main(String[] args) throws SQLException 
	{
		/*
		 * final long serialVersionUID = 1L; String
		 * jdbcURL="jdbc:mysql://localhost:3306/eloan"; String jdbcUsername="root";
		 * String jdbcPassword=""; Connection jdbcConnection;
		 * 
		 * try { Class.forName("com.mysql.jdbc.Driver"); } catch (ClassNotFoundException
		 * e) { throw new SQLException(e); } jdbcConnection =
		 * DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		 * 
		 * int applno=2; String status_query =
		 * "select status from loaninfo where applno=?"; PreparedStatement statement =
		 * jdbcConnection.prepareStatement(status_query); statement.setInt(1, applno);
		 * ResultSet resultSet = statement.executeQuery();
		 * 
		 * if(resultSet.next()) { if(resultSet.getString(1).equalsIgnoreCase("rejected")
		 * || resultSet.getString(1).equalsIgnoreCase("approved")) {
		 * System.out.println("No permission to edit"); } else if
		 * (resultSet.getString(1).equalsIgnoreCase("new")) {
		 * System.out.println("New Loan"); } }
		 */
		int sanctioned_Loan_Amount = 123123;
		int interest_Rate = 7;
		int loan_Term = 30;
		int term_Payment_Amount = (sanctioned_Loan_Amount) * (1 + (interest_Rate / 100)) ^ (loan_Term);
		
		System.out.println(term_Payment_Amount);
	}

}
