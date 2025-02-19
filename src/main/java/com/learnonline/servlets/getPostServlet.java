package com.learnonline.servlets;

import java.io.IOException;
import java.util.ArrayList;

import com.learnonline.dao.PostDao;
import com.learnonline.entities.Post;
import com.learnonline.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/get_blogs")
public class getPostServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		ArrayList<Post> posts = dao.getPosts();
		System.out.println(posts.get(0).getCreatedBy());
		
	}
	
}
