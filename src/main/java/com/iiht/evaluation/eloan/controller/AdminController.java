package com.iiht.evaluation.eloan.controller;

import com.iiht.evaluation.eloan.dao.ConnectionDao;
import com.iiht.evaluation.eloan.dto.LoanDto;
import com.iiht.evaluation.eloan.model.ApprovedLoan;
import com.iiht.evaluation.eloan.model.LoanInfo;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;


@WebServlet("/admin")
public class AdminController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private ConnectionDao connDao;
	
	public void setConnDao(ConnectionDao connDao) 
	{
		this.connDao = connDao;
	}
	
	public void init(ServletConfig config) 
	{
		String jdbcURL = config.getServletContext().getInitParameter("jdbcUrl");
		String jdbcUsername = config.getServletContext().getInitParameter("jdbcUsername");
		String jdbcPassword = config.getServletContext().getInitParameter("jdbcPassword");
		this.connDao = new ConnectionDao(jdbcURL, jdbcUsername, jdbcPassword);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException 
	{
		String action =  request.getParameter("action");
		
		String viewName = "";
		try 
		{
			switch (action) 
			{
				case "listall" : 
					viewName = listall(request, response);
					break;
				case "process":
					viewName=process(request,response);
					break;
				case "callemi":
					viewName=calemi(request,response);
					break;
				case "updatestatus":
					viewName=updatestatus(request,response);
					break;
				case "logout":
					viewName = adminLogout(request, response);
					break;	
				default : 
					viewName = "notfound.jsp"; 
					break;		
			}
		} 
		catch (Exception ex) 
		{
			throw new ServletException(ex.getMessage());
		}
		RequestDispatcher dispatch = request.getRequestDispatcher(viewName);
		dispatch.forward(request, response);		
	}

	private String updatestatus(HttpServletRequest request, HttpServletResponse response) throws SQLException 
	{
		// TODO Auto-generated method stub
		/* write the code for updatestatus of loan and return to admin home page */
		
		
		//connDao.changeStatus(Integer.parseInt(loanInfo.getApplno()),status);
		/*
		 * return null;
		 * 
		 * 
		 * LoanInfo loan = new LoanInfo();
		 * loan.setApplno(request.getParameter("applno")); String lstatus =
		 * request.getParameter("status"); loan.setStatus("Approved"); String status =
		 * loan.getStatus();
		 * connDao.updateLoanStatus(Integer.parseInt(loan.getApplno()),status);
		 * if(status.equals("Approved")) { System.out.println(loan.getApplno()+
		 * "Approved Succesfully"); } else if(status.equals("Declined")) {
		 * System.out.println(loan.getApplno()+ "Declined Succesfully"); }
		 */
		return "adminhome1.jsp";
		
	}
	
	private String calemi(HttpServletRequest request, HttpServletResponse response) throws SQLException 
	{
		// TODO Auto-generated method stub
		/* write the code to calculate emi for given applno and display the details */
		
		HttpSession session = request.getSession();
		
		LoanInfo loanInfo = new LoanInfo();
		loanInfo.setApplno(request.getParameter("applno"));
			
		loanInfo.setStatus("Approved");
		
		String status = loanInfo.getStatus();
		
		connDao.changeStatus(Integer.parseInt(request.getParameter("applno")), status);
		
		ApprovedLoan approvedloan = new ApprovedLoan();
		
		approvedloan.setApplno(request.getParameter("applno"));
		approvedloan.setLoanterm(30);
		approvedloan.setPsd(LocalDate.now().toString());
		approvedloan.setLcd(LocalDate.now().toString());
		
		LoanDto loandto = connDao.calEmi(approvedloan);
		request.setAttribute("ApprovedLoanDetails", connDao.updateEMIDetails(approvedloan));
		
		return "calemi.jsp";		
	}
	//testing purpose, delete this later
	private String process(HttpServletRequest request, HttpServletResponse response) throws SQLException 
	{
		// TODO Auto-generated method stub
		/* return to process page */
		
		return  "process.jsp";
	}
	
	private String adminLogout(HttpServletRequest request, HttpServletResponse response) 
	{
		// TODO Auto-generated method stub
		/* write code to return index page */
		return "index.jsp";
	}

	private String listall(HttpServletRequest request, HttpServletResponse response) throws SQLException 
	{
		/* write the code to display all the loans */		
		
		return "listall.jsp";
	}

	
}