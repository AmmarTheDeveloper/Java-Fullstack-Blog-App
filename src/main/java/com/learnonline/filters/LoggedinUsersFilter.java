package com.learnonline.filters;

import java.io.IOException;


import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoggedinUsersFilter extends HttpFilter {

	@Override
	protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpSession session = req.getSession();
		System.out.println("Filter called");
		if(session.getAttribute("currentUser") == null){
			System.out.println("User not found");
			res.sendRedirect("login");
		}else {
			chain.doFilter(req, res);
		}
	}
	
}
