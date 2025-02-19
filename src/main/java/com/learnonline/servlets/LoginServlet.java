package com.learnonline.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.learnonline.dao.UserDao;
import com.learnonline.entities.Message;
import com.learnonline.entities.User;
import com.learnonline.helper.ConnectionProvider;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
    }

	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
    	rd.forward(req, resp);
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			System.out.println("Email: " + email);
			System.out.println("Password: " +password);
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			
			PrintWriter writer = response.getWriter();
			
			User user = dao.getUserByEmailAndPassword(email, password);
			if(user == null) {
				Message msg = new Message("Invalid Credentials! Enter valid credentials" , "error","alert-danger" );
				HttpSession s = request.getSession();
				s.setAttribute("msg", msg);
				response.sendRedirect("login");
			}else {
				//success

				HttpSession s = request.getSession();
				s.setAttribute("currentUser", user);
				response.sendRedirect("profile");
			}
		
	}

}
