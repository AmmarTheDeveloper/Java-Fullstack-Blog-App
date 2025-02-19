package com.learnonline.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {

	private static Connection con;
	
	public static Connection getConnection() {
		
		try {
			if(con == null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/learnonline" , "root" , "root");
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("Err: "  + e.getMessage());
		}
		
		return con;
	}
}
