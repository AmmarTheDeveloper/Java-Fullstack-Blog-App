package com.learnonline.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.learnonline.entities.Post;
import com.learnonline.entities.User;

public class PostDao {

	Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}
	
	public boolean updatePost(int pid,String title,String description,String content,String thumbnail,int cid) {
		
		boolean isUpdated = false;
		
		try {
		
			String query;
			
			if(thumbnail.equals("")) {
				query =  "update posts set title = ?, description = ?, content = ?,cid = ? where pid = ?";
			}else {
				query =  "update posts set title = ?, description = ?, content = ?,cid = ?,thumbnail = ? where pid = ?";
			}
			
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, description);
			pstmt.setString(3, content);
			pstmt.setInt(4, cid);
			
			if(thumbnail.equals("")) {
				pstmt.setInt(5, pid);				
			}else {
				pstmt.setString(5, thumbnail);
				pstmt.setInt(6, pid);
			}
			
			//return no of rows modified when any modification is performed
			int rs = pstmt.executeUpdate();
			
			isUpdated = rs == 1;
			
		}catch(Exception e) {
			
			e.printStackTrace();
			
		}
		
		
		return isUpdated;
		
	}

	public ArrayList<Post> getPostByCategoryId(int cid) {

		ArrayList<Post> posts = new ArrayList<Post>();

		try {

			String query = "select * from posts where cid = ?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, cid);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {

				int pid = rs.getInt("pid");
				String title = rs.getString("title");
				String description = rs.getString("description");
				String content = rs.getString("content");
				String thumbnail = rs.getString("thumbnail");
				Timestamp date = rs.getTimestamp("date");
				int createdBy = rs.getInt("createdBy");

				

				Post post = new Post(pid, title, description, content, thumbnail, date, cid, createdBy);
				posts.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return posts;

	}

	public boolean deletePost(int pid) {
		boolean isDeleted = false;
		try {
			String query = "delete from posts where pid = ?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, pid);
			int rs = pstmt.executeUpdate();

			if (rs == 1) {
				isDeleted = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isDeleted;
	}

	public Post getPostWithOwner(int pid) {

		Post p = null;

		try {

			String query = "select * from posts inner join user on posts.createdBy = user.id where posts.pid = ?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setInt(1, pid);

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {

				String title = rs.getString("title");
				String description = rs.getString("description");
				String content = rs.getString("content");
				String thumbnail = rs.getString("thumbnail");
				Timestamp date = rs.getTimestamp("date");
				int cid = rs.getInt("cid");
				int createdBy = rs.getInt("createdBy");
				
				// getting user details
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String password = rs.getString("password");
				String gender = rs.getString("gender");
				String about = rs.getString("about");
				Timestamp rdate = rs.getTimestamp("rdate");
				String profile = rs.getString("profile");

				p = new Post(pid, title, description, content, thumbnail, date, cid, createdBy);
				User user = new User(id,name,email,password,gender,about,rdate);
				user.setProfile(profile);
				p.setUser(user);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return p;
	}

	public Post getPost(int pid) {

		Post p = null;

		try {

			String query = "select * from posts where pid = ?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setInt(1, pid);

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {

				String title = rs.getString("title");
				String description = rs.getString("description");
				String content = rs.getString("content");
				String thumbnail = rs.getString("thumbnail");
				Timestamp date = rs.getTimestamp("date");
				int cid = rs.getInt("cid");
				int createdBy = rs.getInt("createdBy");

				p = new Post(pid, title, description, content, thumbnail, date, cid, createdBy);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return p;
	}

	public ArrayList<Post> getPostsByOwner(int createdBy) {

		ArrayList<Post> posts = new ArrayList<Post>();

		try {

			String query = "select * from posts where createdBy = ?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setInt(1, createdBy);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {

				int pid = rs.getInt("pid");
				String description = rs.getString("description");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String thumbnail = rs.getString("thumbnail");
				Timestamp date = rs.getTimestamp("date");
				int cid = rs.getInt("cid");

				Post post = new Post(pid, title, description, content, thumbnail, date, cid, createdBy);
				posts.add(post);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return posts;
	}

	public ArrayList<Post> getPosts() {

		ArrayList<Post> posts = new ArrayList<Post>();

		try {

			String query = "select * from posts order by pid  desc";
			Statement stmt = this.con.createStatement();
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {

				int pid = rs.getInt("pid");
				String description = rs.getString("description");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String thumbnail = rs.getString("thumbnail");
				Timestamp date = rs.getTimestamp("date");
				int cid = rs.getInt("cid");
				int createdBy = rs.getInt("createdBy");

				Post p = new Post(pid, title, description, content, thumbnail, date, cid, createdBy);
				posts.add(p);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return posts;
	}

	public boolean savePost(String title, String description, String content, String thumbnail, String cid,
			int createdBy) {

		boolean isSaved = false;

		try {

			String query = "insert into posts(title,description,content,thumbnail,cid,createdBy) values(?,?,?,?,?,?)";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, description);
			pstmt.setString(3, content);
			pstmt.setString(4, thumbnail);
			pstmt.setInt(5, Integer.parseInt(cid));
			pstmt.setInt(6, createdBy);

			pstmt.executeUpdate();
			isSaved = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return isSaved;
	}

}
