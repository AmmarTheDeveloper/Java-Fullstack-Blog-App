package com.learnonline.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;

import com.learnonline.dao.UserDao;
import com.learnonline.entities.Message;
import com.learnonline.entities.User;
import com.learnonline.exceptions.CustomException;
import com.learnonline.helper.ConnectionProvider;
import com.learnonline.helper.Helper;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/edit-profile")
@MultipartConfig
public class EditProfileServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String gender = req.getParameter("gender");
		String about = req.getParameter("about");

		Part profile = req.getPart("profile");

		HttpSession s = req.getSession();

		Message m;

		try {
			
			if(name.isEmpty() || email.isEmpty() || password.isEmpty() || gender.isEmpty()) {
				throw new CustomException("Enter required fields...");
			}
			
			User user = (User) s.getAttribute("currentUser");
			String previousProfileImage = user.getProfile();

			
			user.setName(name);
			user.setEmail(email);
			user.setPassword(password);
			user.setGender(gender);
			user.setAbout(about);
			
			if (!profile.getSubmittedFileName().equals("")) {

				/*
				 * String[] imgFullname = profile.getSubmittedFileName().split("\\.");
				 * 
				 * String extension = imgFullname[imgFullname.length - 1];
				 * 
				 * imgFullname[imgFullname.length - 1] = "";
				 * 
				 * String imgName = String.join("", imgFullname); String imgFinalName = imgName
				 * + "-" + new Date().getTime() + "." + extension;
				 */
				
				String imgFinalName = Helper.generateFileName(profile);
				user.setProfile(imgFinalName);
			} 

			UserDao dao = new UserDao(ConnectionProvider.getConnection());

			PrintWriter writer = resp.getWriter();
			
			
			if (dao.updateUser(user)) {
				System.out.println("Data Updated to db");

				String profileImagePath = getServletContext().getRealPath("public") + File.separator + "profile-images";
				String path = profileImagePath + File.separator + user.getProfile();

				if (!profile.getSubmittedFileName().equals("")) {

					String previousImagePath = profileImagePath + File.separator + previousProfileImage;

					if (!previousProfileImage.equals("default.png")) {
						if (Helper.deleteFile(previousImagePath)) {
							System.out.println("Previous profile image deleted successfully");
						} else {
							System.out.println("Previous profile image not deleted");
							throw new CustomException("Something went wrong while deleting the previous image...");
						}
					} else {
						System.out.println("Previous image was default.png");
					}

					if (Helper.saveFile(profile.getInputStream(), path)) {
						System.out.println("Image saved successfully....");
					} else {
						System.out.println("File not saved successfully");
						throw new CustomException("Something went wrong while saving the image...");
					}

				} else {
					System.out.println("No image provided");
				}

			} else {
				System.out.println("Not updated");
				throw new CustomException("Something went wront while updating to db");
			}
			
			m = new Message("User updated successfully...","success","alert-success");
		}catch(CustomException e) {
			
			m = new Message(e.getMessage(),"error","alert-danger");
			
		}
		
		req.setAttribute("msg", m);
		RequestDispatcher rd = req.getRequestDispatcher("/profile");
		rd.forward(req, resp);
	}

}
