package com.iiht.evaluation.eloan.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;

import com.iiht.evaluation.eloan.dto.LoanDto;
import com.iiht.evaluation.eloan.model.ApprovedLoan;
import com.iiht.evaluation.eloan.model.LoanInfo;
import com.iiht.evaluation.eloan.model.User;
import com.mysql.cj.protocol.Resultset;

public class ConnectionDao 
{
	private static final long serialVersionUID = 1L;
	private String jdbcURL;
	private String jdbcUsername;
	private String jdbcPassword;
	private Connection jdbcConnection;

	public ConnectionDao(String jdbcURL, String jdbcUsername, String jdbcPassword) 
	{
		this.jdbcURL = jdbcURL;
		this.jdbcUsername = jdbcUsername;
		this.jdbcPassword = jdbcPassword;
	}

	public  Connection connect() throws SQLException 
	{
		if (jdbcConnection == null || jdbcConnection.isClosed()) 
		{
			try 
			{
				Class.forName("com.mysql.jdbc.Driver");
			}
			catch (ClassNotFoundException e) 
			{
				throw new SQLException(e);
			}
			jdbcConnection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		}
		return jdbcConnection;
	}

	public void disconnect() throws SQLException 
	{
		if (jdbcConnection != null && !jdbcConnection.isClosed()) 
		{
			jdbcConnection.close();
		}
	}



	// put the relevant DAO methods here..

	//Method to validate user Login
	public String validateUser(User user) throws SQLException 
	{
		String viewPage = null;
		this.connect();

		try 
		{
			String query = "select * from user where username=? and password=?";

			PreparedStatement pst = connect().prepareStatement(query);
			pst.setString(1, user.getUsername());
			pst.setString(2, user.getPassword());

			ResultSet rs = pst.executeQuery();

			if (rs.next()) 
			{
				if (user.getUsername().equals("admin")) 
				{
					viewPage = "adminhome1.jsp";
				} 
				else 
				{
					viewPage = "userhome1.jsp";
				}
			} 
			else 
			{
				viewPage = "index.jsp";
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}

		this.disconnect();

		return viewPage;
	}

	public void registerNewUser(User user) throws SQLException 
	{
		this.connect();

		String query = "insert into user (username,password) values(?,?)";

		PreparedStatement pst = connect().prepareStatement(query);
		pst.setString(1, user.getUsername());
		pst.setString(2, user.getPassword());

		pst.executeUpdate();

		this.disconnect();
	}

	public void newLoanApplication(LoanInfo loanInfo) throws SQLException 
	{
		this.connect();

		String query = "insert into loaninfo(purpose, amtrequest, doa, bstructure, bindicator, tindicator, address, email, mobile, status, username) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		PreparedStatement pst = connect().prepareStatement(query);

		pst.setString(1, loanInfo.getPurpose()); 
		pst.setInt(2, loanInfo.getAmtrequest()); 
		pst.setString(3, loanInfo.getDoa());
		pst.setString(4, loanInfo.getBstructure()); 
		pst.setString(5, loanInfo.getBindicator());
		pst.setString(6, loanInfo.getTindicator());
		pst.setString(7, loanInfo.getAddress()); 
		pst.setString(8, loanInfo.getEmail()); 
		pst.setString(9, loanInfo.getMobile());
		pst.setString(10, loanInfo.getStatus()); 
		pst.setString(11, loanInfo.getUsername());

		int result = pst.executeUpdate(); 

		this.disconnect();
	}

	public List<LoanInfo> getLoanDetails(String applno, String username) throws SQLException 
	{
		this.connect();
		
		String query = "select * from loaninfo where applno=? and username=?";
		
		PreparedStatement pst = connect().prepareStatement(query);
		
		pst.setString(1, applno);
		pst.setString(2, username);
		
		ResultSet rs = pst.executeQuery();
		
		List<LoanInfo> loans = new ArrayList<LoanInfo>();
		
		while(rs.next())
		{
			LoanInfo loaninfo = new LoanInfo(rs.getString(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12));
			loans.add(loaninfo);
		}		
		
		this.disconnect();
		return loans;
	}

	public void editLoanDetails(LoanInfo loanInfo) throws SQLException 
	{
		this.connect();
		
		String status_query = "select status from loaninfo where applno=?";
		PreparedStatement statement = jdbcConnection.prepareStatement(status_query);
		statement.setString(1, loanInfo.getApplno());
		ResultSet resultSet = statement.executeQuery();

		if(resultSet.next())
		{
			if(resultSet.getString(1).equalsIgnoreCase("rejected") || resultSet.getString(1).equalsIgnoreCase("approved"))
			{
				System.out.println("No permission to edit");
			}
			else if(resultSet.getString(1).equalsIgnoreCase("new") || resultSet.getString(1).equalsIgnoreCase("pending") )
			{
				String query = "update loaninfo set amtrequest=?, bstructure=?, bindicator=?, tindicator=?, address=?, email=?, mobile=? where applno=?";
				
				PreparedStatement pst = connect().prepareStatement(query);
				pst.setInt(1, loanInfo.getAmtrequest());
				pst.setString(2, loanInfo.getBstructure());
				pst.setString(3, loanInfo.getBindicator());
				pst.setString(4, loanInfo.getTindicator());
				pst.setString(5, loanInfo.getAddress());
				pst.setString(6, loanInfo.getEmail());
				pst.setString(7, loanInfo.getMobile());
				pst.setString(8, loanInfo.getApplno());
				
				pst.executeUpdate();
			}
		}
		
		this.disconnect();
	}

	public void changeStatus(int applno, String loanStatus) throws SQLException 
	{
		this.connect();
		
		String query = "update loaninfo set status=? where applno=?;";
		
		PreparedStatement pst = connect().prepareStatement(query);
		
		pst.setString(1, loanStatus);
		pst.setInt(2, applno);
		
		pst.executeUpdate();
		
		this.disconnect();
	}

	public LoanDto calEmi(ApprovedLoan approvedloan) throws SQLException 
	{
		int interest_Rate = 7;
		
		this.connect();
		
		String query = "select amtrequest from loaninfo where applno=?;";
		
		PreparedStatement pst = connect().prepareStatement(query);
		pst.setInt(1, Integer.parseInt(approvedloan.getApplno()));
	
		ResultSet rs = pst.executeQuery();
		rs.next();
		
		int sanctioned_Loan_Amount = rs.getInt(1);
		int loan_Term = approvedloan.getLoanterm();
		int term_Payment_Amount = (sanctioned_Loan_Amount) * (1 + interest_Rate / 100) ^ (loan_Term);
		int emi = term_Payment_Amount / loan_Term;
		
		approvedloan.setEmi(emi);
		approvedloan.setAmotsanctioned(rs.getInt(1));
		
		LoanDto loanDto = new LoanDto(approvedloan.getApplno(), approvedloan.getAmotsanctioned(), emi);
		return loanDto;		
	}

	public List<ApprovedLoan> updateEMIDetails(ApprovedLoan apprloan) throws SQLException 
	{
		List<ApprovedLoan> approvedLoansList = new ArrayList<ApprovedLoan>();
		
		String sqlCommand = "insert into approvedloan values(?, ?, ?, ?, ?, ?)";
		
		PreparedStatement pst = connect().prepareStatement(sqlCommand);
		pst.setString(1, apprloan.getApplno());
		pst.setInt(2, apprloan.getAmotsanctioned());
		pst.setInt(3, apprloan.getLoanterm());
		pst.setString(4, apprloan.getPsd());
		pst.setString(5, apprloan.getLcd());
		pst.setInt(6, apprloan.getEmi());
		pst.executeUpdate();
		
		String sqlCommandForDisplay = "select distinct * from approvedloan WHERE applno='" + apprloan.getApplno()+ "';";
		
		Statement st = connect().createStatement();
		ResultSet rs = st.executeQuery(sqlCommandForDisplay);
		while (rs.next()) 
		{
			String applno = rs.getString(1);
			int amountsanctioned = rs.getInt(2);
			int loanterm = rs.getInt(3);
			String psd = rs.getString(4);
			String lcd = rs.getString(5);
			int emi = rs.getInt(6);
			ApprovedLoan approvedLoan = new ApprovedLoan(applno, amountsanctioned, loanterm, psd, lcd, emi);
			approvedLoansList.add(approvedLoan);
		}
		return approvedLoansList;
	}
}