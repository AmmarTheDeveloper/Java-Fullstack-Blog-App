package com.learnonline.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.learnonline.entities.Category;

public class CategoryDao {
	
	private Connection con;
	
	public CategoryDao(Connection con){
		this.con = con;
	}
	
	
	public ArrayList<Category> getCategories() {
		
		ArrayList<Category> categories = new ArrayList<Category>();
		
		try {
			
			String query = "SELECT * FROM categories";
			PreparedStatement pstmt = this.con.prepareStatement(query);			
			ResultSet rs =  pstmt.executeQuery();
			
			while(rs.next()) {
				Category cat = new Category(rs.getInt("cid"),rs.getString("name"),rs.getString("description"));
				categories.add(cat);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return categories;
		
	}
	
}
