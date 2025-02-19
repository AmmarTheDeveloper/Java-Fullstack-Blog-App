package com.learnonline.entities;

import java.sql.Timestamp;

public class Post {
	private int pid;
	private String title;
	private String content;
	private String thumbnail;
	private Timestamp date;
	private int cid;
	private int createdBy;
	private String description;
	private User user;
	
	public Post(int pid, String title,String description, String content, String thumbnail, Timestamp date, int cid,int createdBy) {
		this.pid = pid;
		this.title = title;
		this.description = description;
		this.content = content;
		this.thumbnail = thumbnail;
		this.date = date;
		this.cid = cid;
		this.createdBy = createdBy;
	}
	

	public Post( String title,String description, String content, String thumbnail, Timestamp date, int cid,int createdBy) {
		this.title = title;
		this.description = description;
		this.content = content;
		this.thumbnail = thumbnail;
		this.date = date;
		this.cid = cid;
		this.createdBy = createdBy;
	}


	// getters and setters
	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getDescription() {
		return description;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}
	
	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}
	
	public int getCreatedBy() {
		return createdBy;
	}
	
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}

}
