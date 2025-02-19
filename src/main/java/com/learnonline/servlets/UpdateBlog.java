package com.learnonline.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.learnonline.dao.PostDao;
import com.learnonline.entities.Message;
import com.learnonline.entities.Post;
import com.learnonline.entities.User;
import com.learnonline.exceptions.CustomException;
import com.learnonline.helper.ConnectionProvider;
import com.learnonline.helper.Helper;

/**
 * Servlet implementation class UpdateBlog
 */
@WebServlet("/update_blog")
@MultipartConfig
public class UpdateBlog extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateBlog() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher rd = request.getRequestDispatcher("/update_blog.jsp");
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pid = request.getParameter("pid");
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String content = request.getParameter("content");
		Part thumbnail = request.getPart("thumbnail");
		String cid = request.getParameter("cid");

		Message msg;

		try {

			if (title.isEmpty() || description.isEmpty() || content.isEmpty() || cid.isEmpty()) {
				throw new CustomException("All fields are required...");
			}
			
			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			Post p = dao.getPost(Integer.parseInt(pid));
			
			String filename = "";

			if (!thumbnail.getSubmittedFileName().equals("")) {
				
				String thumbnailsPath = request.getServletContext().getRealPath("public") + File.separator + "thumbnails";
				filename = Helper.generateFileName(thumbnail);
				String newPath = thumbnailsPath + File.separator + filename;
					
				if (!Helper.saveFile(thumbnail.getInputStream(), newPath)) {
					throw new CustomException("Thumbnail not saved!!!");
				}
				
				String previousThumbnailPath = thumbnailsPath + File.separator + p.getThumbnail();
				
				if (!Helper.deleteFile(previousThumbnailPath)) {
					throw new CustomException("Something went wrong while deleting the previous thmbnail...");
				}

			}


			boolean isUpdated = dao.updatePost(Integer.parseInt(pid),title,description,content,filename,Integer.parseInt(cid));
			if (!isUpdated) {
				throw new CustomException("Something went wrong while updating the blog...");
			}
			
			msg = new Message("Updated successfully..." , "success","alert-success");

		} catch (CustomException e) {
			e.printStackTrace();
			msg = new Message(e.getMessage(), "error", "alert-danger");
		}
		
		request.setAttribute("msg", msg);
		
		RequestDispatcher rd = request.getRequestDispatcher("/update_blog.jsp");
		rd.forward(request, response);
		
	}

}
