package com.learnonline.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.learnonline.dao.LikeDao;
import com.learnonline.exceptions.CustomException;
import com.learnonline.helper.ConnectionProvider;

/**
 * Servlet implementation class LikeServlet
 */
@WebServlet("/like")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String operation = request.getParameter("operation");
		String uid = request.getParameter("uid");
		String pid = request.getParameter("pid");
		
		LikeDao dao = new LikeDao(ConnectionProvider.getConnection());
		boolean success = false;
		
		String msg = "";
		try {
			if(operation.equals("like")) {
				
				boolean inserted =  dao.insertLike(Integer.parseInt(pid), Integer.parseInt(uid));
				if(!inserted) {
					throw new CustomException("Not liked, Something went wrong...");
				}
				
				msg = "Post Liked successfully";
				
			}else {
				
				boolean deleted = dao.deleteLike(Integer.parseInt(pid), Integer.parseInt(uid));
				if(!deleted) {
					throw new CustomException("Not deleted like, Something went wrong...");
				}
				
				msg = "Deleted like from post";
			}
			
			success = true;
		}catch(CustomException e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		catch(Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		
		PrintWriter writer = response.getWriter();
		if(success) {
			writer.println("done");
			writer.println(msg);
		}else {
			writer.println(msg);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
