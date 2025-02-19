package com.learnonline.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

import com.learnonline.entities.User;

public class UserDao {

		private Connection con;
		
		public UserDao(Connection con) {
			this.con = con;
		}
		
		
		//method to get user by email and password
		
		public User getUserByEmailAndPassword(String email,String password) {
			
			User user = null;
			try {
				String query = "SELECT * FROM USER WHERE email = ? and password = ?";
				PreparedStatement pstmt = this.con.prepareStatement(query);
				pstmt.setString(1, email);
				pstmt.setString(2, password);
				
				ResultSet set = pstmt.executeQuery();
				
				//assuming that we get only one data otherwise we need to iterate it
				if(set.next()) {
					user = new User();
					user.setId(set.getInt("id"));
					user.setName(set.getString("name"));
					user.setEmail(set.getString("email"));
					user.setPassword(set.getString("password"));
					user.setGender(set.getString("gender"));
					user.setAbout(set.getString("about"));
					user.setDateTime(set.getTimestamp("rdate"));
					user.setProfile(set.getString("profile"));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return user;
		}
		
		//method to insert user to database	
		public HashMap<String, String> saveUser(User user) {

			HashMap<String, String> response = new HashMap<String, String>();
			
			try {
				String query = "insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
				PreparedStatement pstmt = this.con.prepareStatement(query);
				pstmt.setString(1, user.getName());
				pstmt.setString(2, user.getEmail());
				pstmt.setString(3, user.getPassword());
				pstmt.setString(4, user.getGender());
				pstmt.setString(5, user.getAbout());
				
				
				pstmt.executeUpdate();
				response.put("status", "success");
				response.put("message", "Registered successfully");
				
			} catch (Exception e) {
				response.put("status", "error");
				response.put("message", e.getMessage());
				e.printStackTrace();
			}
			return response;
		}
		
		
		public boolean updateUser(User user) {	
			boolean isExecuted = false;
			
			try {
				
				String query = "UPDATE user SET name = ?, email = ?, password = ?, gender=?,about = ?, profile = ? WHERE id = ?";
				PreparedStatement stmt = this.con.prepareStatement(query);
				stmt.setString(1, user.getName());
				stmt.setString(2, user.getEmail());
				stmt.setString(3, user.getPassword());
				stmt.setString(4, user.getGender());
				stmt.setString(5, user.getAbout());
				stmt.setString(6, user.getProfile());
				stmt.setInt(7, user.getId());
				
				stmt.executeUpdate();
				
				isExecuted = true;
			}catch(Exception e) {
				e.printStackTrace();
			}
			return isExecuted;
		}
	
}
