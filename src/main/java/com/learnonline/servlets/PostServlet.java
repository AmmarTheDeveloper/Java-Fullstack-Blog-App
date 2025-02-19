package com.learnonline.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.learnonline.dao.PostDao;
import com.learnonline.entities.Message;
import com.learnonline.entities.User;
import com.learnonline.exceptions.CustomException;
import com.learnonline.helper.ConnectionProvider;
import com.learnonline.helper.Helper;

/**
 * Servlet implementation class PostServlet
 */
@WebServlet("/add_blog")
@MultipartConfig
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher("/add_blog.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String content = request.getParameter("content");
		Part thumbnail = request.getPart("thumbnail");
		String cid = request.getParameter("category");
		
		
		HttpSession s = request.getSession();

		Message msg;
		
		try {
			
			if(title.isEmpty() || description.isEmpty() || content.isEmpty() || cid.isEmpty()) {
				throw new CustomException("All fields are required...");
			}

			if (thumbnail.getSubmittedFileName().equals("")) {
				throw new CustomException("Thumbnail is required");
			}
			
			String thumbnailsPath = request.getServletContext().getRealPath("public") + File.separator + "thumbnails";
			String filename = Helper.generateFileName(thumbnail);
			thumbnailsPath = thumbnailsPath + File.separator + filename;

			if (!Helper.saveFile(thumbnail.getInputStream(), thumbnailsPath)) {
				msg = new Message("Thumbnail not saved!!!", "error", "alert-danger");
				s.setAttribute("msg", msg);
				response.sendRedirect("add_blog.jsp");
			}

			PostDao dao = new PostDao(ConnectionProvider.getConnection());

			User user =(User) s.getAttribute("currentUser");
			
			boolean isSaved = dao.savePost(title,description, content, filename, cid,user.getId());
			if (isSaved) {
				msg = new Message("Saved successfully", "success", "alert-success");
			} else {
				msg = new Message("Not saved successfully", "error", "alert-danger");
			}

		}catch(CustomException e) {
			msg = new Message(e.getMessage(), "error" , "alert-danger");
		}
		
		s.setAttribute("msg", msg);
		
		response.sendRedirect("add_blog.jsp");

	}

}
