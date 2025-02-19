package com.learnonline.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LikeDao {

	private Connection con;
	
	public LikeDao(Connection con) {
		this.con = con;
	}
	
	public boolean insertLike(int pid,int uid) {
		
		boolean inserted = false;
		String query = "INSERT INTO LIKES (pid,uid) VALUES(?,?)";
		try {
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			
			pstmt.executeUpdate();
			inserted = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return inserted;
	}
	
	public int  getLikes(int pid) {
		
		int count = 0;
		String query = "SELECT COUNT(*) as count FROM LIKES WHERE pid = ?";
		try {
			
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, pid);
			
			ResultSet rs  = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;		
	}

	public boolean isLiked(int pid,int uid) {
		
		boolean isLiked = false;
		
		String query = "SELECT * FROM LIKES WHERE pid = ? and uid = ?";
		
		try {
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				isLiked = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return isLiked;
		
	}
	
	public boolean deleteLike(int pid,int uid) {
		
		boolean isDeleted = false;
		String query = "DELETE FROM LIKES WHERE pid = ? and uid = ?";
		
		try {
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			
			int rs = pstmt.executeUpdate();
			isDeleted = rs == 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return isDeleted;
		
	}
	
}
