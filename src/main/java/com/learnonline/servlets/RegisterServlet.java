package com.learnonline.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import com.learnonline.dao.UserDao;
import com.learnonline.entities.User;
import com.learnonline.helper.ConnectionProvider;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
@MultipartConfig()
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher("/register.jsp");
		rd.forward(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String terms = req.getParameter("terms");

		PrintWriter writer = resp.getWriter();

		if (terms == null) {
			writer.println("Please agree the terms");
		} else {
			String name = req.getParameter("username");
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			String gender = req.getParameter("gender");
			String about = req.getParameter("about");
			
			System.out.println("Name: " + name);
			System.out.println("Email: " + email);
			System.out.println("Password: " + password);
			System.out.println("Gender: " + gender);
			System.out.println("About: " + about);
			
			User user = new User(name,email,password,gender,about);

			//create user dao object
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			
			HashMap<String, String> response = dao.saveUser(user);
			
			if(response.get("status") == "success") {
				writer.println("done");
			}else {
				writer.println(response.get("message"));
			}
			
		}
	}

}
