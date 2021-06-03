package com.iiht.evaluation.eloan.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.iiht.evaluation.eloan.dao.ConnectionDao;
import com.iiht.evaluation.eloan.model.LoanInfo;
import com.iiht.evaluation.eloan.model.User;

@WebServlet("/user")
public class UserController extends HttpServlet 
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
		//System.out.println(jdbcURL + jdbcUsername + jdbcPassword);
		this.connDao = new ConnectionDao(jdbcURL, jdbcUsername, jdbcPassword);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException 
	{
		String action = request.getParameter("action");
		
		String viewName = "";
		try 
		{
			switch (action) 
			{
				case "registerNewUser":
					viewName=registerNewUser(request,response);
					break;
				case "validate":
					viewName=validate(request,response);
					break;
				case "placeloan":
					viewName=placeloan(request,response);
					break;
				case "application1":
					viewName=application1(request,response);
					break;
				case "editLoanProcess"  :
					viewName=editLoanProcess(request,response);
					break;
				case "registeruser":
					viewName=registerUser(request,response);
					break;
				case "register":
					viewName = register(request, response);
					break;
				case "application":
					viewName = application(request, response);
					break;
				case "trackloan":
					viewName = trackloan(request, response);
					break;
				case "editloan":
					viewName = editloan(request, response);
					break;	
				case  "displaystatus" :
					viewName=displaystatus(request,response);
					break;
				default : viewName = "notfound.jsp"; break;	
			}
		} 
		catch (Exception ex) 
		{
			throw new ServletException(ex.getMessage());
		}
		RequestDispatcher dispatch = request.getRequestDispatcher(viewName);
		dispatch.forward(request, response);
	}
	
	private String validate(HttpServletRequest request, HttpServletResponse response) throws SQLException 
	{
		/* write the code to validate the user */
		HttpSession session=request.getSession();

		String loginid = request.getParameter("loginid");

		User user = new User();
		user.setUsername(request.getParameter("loginid"));
		user.setPassword(request.getParameter("password"));

		session.setAttribute("userName", loginid); 

		String viewPage = connDao.validateUser(user);
		return viewPage;
	}
	
	private String placeloan(HttpServletRequest request, HttpServletResponse response) throws SQLException 
	{
		// TODO Auto-generated method stub
		/* write the code to place the loan information */
		
		HttpSession session=request.getSession();

		LoanInfo loanInfo = new LoanInfo();
						
		loanInfo.setApplno(request.getParameter("applno"));
		loanInfo.setPurpose(request.getParameter("loanTypes"));
		loanInfo.setAmtrequest(Integer.parseInt(request.getParameter("loanAmountRequested")));
		loanInfo.setDoa(request.getParameter("loanApplicationDate"));
		loanInfo.setBstructure(request.getParameter("businessStructure"));
		loanInfo.setBindicator(request.getParameter("billingIndicator"));
		loanInfo.setTindicator(request.getParameter("taxIndicator"));
		loanInfo.setAddress(request.getParameter("address"));
		loanInfo.setEmail(request.getParameter("emailid"));
		loanInfo.setMobile(request.getParameter("mobile"));
		loanInfo.setStatus("new");
		loanInfo.setUsername(session.getAttribute("userName").toString());
		
		connDao.newLoanApplication(loanInfo);
		
		return "userhome1.jsp";
	}
	private String application1(HttpServletRequest request, HttpServletResponse response) 
	{
		// TODO Auto-generated method stub
		/* write the code to display the loan application page */
		
		
		return null;
	}
	private String editLoanProcess(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		// TODO Auto-generated method stub
		/* write the code to edit the loan info */
		
		//HttpSession session = request.getSession();
		LoanInfo loanInfo = new LoanInfo();
		
		loanInfo.setApplno(request.getParameter("applno"));
		loanInfo.setPurpose(request.getParameter("loanType"));
		loanInfo.setAmtrequest(Integer.parseInt(request.getParameter("loanAmountRequested")));
		loanInfo.setDoa(request.getParameter("loanApplicationDate"));
		loanInfo.setBstructure(request.getParameter("businessStructure"));
		loanInfo.setBindicator(request.getParameter("billingIndicator"));
		loanInfo.setTindicator(request.getParameter("taxIndicator"));
		loanInfo.setAddress(request.getParameter("address"));
		loanInfo.setEmail(request.getParameter("emailid"));
		loanInfo.setMobile(request.getParameter("mobile"));
				
		connDao.editLoanDetails(loanInfo);		
		
		return "userhome1.jsp";
	}
	private String registerUser(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		// TODO Auto-generated method stub
		/* write the code to redirect page to read the user details */
		return "newuserui.jsp";
	}
	
	private String registerNewUser(HttpServletRequest request, HttpServletResponse response) throws SQLException 
	{
		// TODO Auto-generated method stub
		/* write the code to create the new user account read from user 
		   and return to index page */
	
		User user = new User();
		user.setUsername(request.getParameter("loginid"));
		user.setPassword(request.getParameter("password"));

		connDao.registerNewUser(user);

		return "index.jsp";
	}
	
	private String register(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		/* write the code to redirect to register page */
		
		return null;
	}

	private String displaystatus(HttpServletRequest request, HttpServletResponse response) throws SQLException 
	{
		// TODO Auto-generated method stub
		/* write the code the display the loan status based on the given application
		   number 
		*/
		HttpSession session=request.getSession();

		String applno = request.getParameter("applno");		
		String username = session.getAttribute("userName").toString();
		
		List<LoanInfo> loans = connDao.getLoanDetails( applno, username);
		
		request.getSession().setAttribute("loans", loans);
		
		return "loanDetails.jsp";
	}

	private String editloan(HttpServletRequest request, HttpServletResponse response) throws SQLException 
	{
		// TODO Auto-generated method stub
		/* write a code to return to editloan page */
		
		HttpSession session=request.getSession();

		String applno = request.getParameter("applno");		
		String username = session.getAttribute("userName").toString();
		
		List<LoanInfo> loans = connDao.getLoanDetails(applno, username);
		request.getSession().setAttribute("loans", loans);
		
		return "editloanui.jsp";
	}

	private String trackloan(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		/* write a code to return to trackloan page */
		
		
		
		return "trackloan.jsp";
	}

	private String application(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
	/* write a code to return to trackloan page */
		return "trackloan.jsp";
	}
}