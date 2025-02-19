package com.learnonline.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.learnonline.dao.PostDao;
import com.learnonline.entities.Message;
import com.learnonline.exceptions.CustomException;
import com.learnonline.helper.ConnectionProvider;

/**
 * Servlet implementation class DeleteBlog
 */
@WebServlet("/delete_blog")
public class DeleteBlog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteBlog() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid = request.getParameter("pid");
		Message m;
		
		try {
			if(pid.isEmpty()) {
				throw new CustomException("Blog id is not provided");
			}
			
			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			boolean isDeleted = dao.deletePost(Integer.parseInt(pid));
			if(!isDeleted) {
				throw new CustomException("Blog doesn't exist OR Something went wrong");
			}
			
			m = new Message("Blog deleted successfully", "success" , "alert-success");
			
		}catch(CustomException e) {
			e.printStackTrace();
			m = new Message(e.getMessage(),"error","alert-danger");
		}catch(Exception e) {
			e.printStackTrace();
			m = new Message(e.getMessage(),"error","alert-danger");
		}
		
		request.setAttribute("msg", m);
		RequestDispatcher rd = request.getRequestDispatcher("/my_blogs");
		rd.forward(request, response);
	}

}
