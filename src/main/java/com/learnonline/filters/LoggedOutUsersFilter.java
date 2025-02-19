package com.learnonline.filters;

import java.io.IOException;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoggedOutUsersFilter extends HttpFilter {

	@Override
	protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		
		HttpSession s = req.getSession();
		if(s.getAttribute("currentUser") != null) {
			res.sendRedirect("profile");
		}else {
			chain.doFilter(req, res);
		}
		
	}
	
	
}
