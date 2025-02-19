<%@page import="com.learnonline.dao.PostDao"%>
<%@page import="com.learnonline.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.learnonline.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Learn code online</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="<%=application.getContextPath()%>/public/css/style.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>

	<%@ include file="common/navbar.jsp"%>

	<div class="container-fluid p-0 m-0">

		<div class="jumbotron primary-bg text-white banner-bg py-5">
			<div class="container">
				<h3 class="display-3">Welcome To Learn Online</h3>

				<p>Welcome to learn online, world of the education</p>

				<button class="btn btn-outline-light">
					<span class="fa fa-user-plus"></span> Start! its Free
				</button>
				<a href="login" class="btn btn-outline-light"> <span
					class="fa fa-user-circle fa-spin"></span> Login
				</a>

			</div>
		</div>

	</div>

	<div class="container">


		<div class="row justify-content-center">
			<%
			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			ArrayList<Post> posts = dao.getPosts();

			if (posts.size() == 0) {
				out.println("<div class='alert alert-danger'>  No posts availble... </div>");
				return;
			}
			
			int  index = 0;
			for (Post post : posts) {
				if(index >= 10){
					break;
				}
				index++;
			%>

			<div class="col-sm-6 col-md-4 my-3">

				<div class="card h-100">
					<div class="ratio ratio-16x9">
						<img
							src="<%=application.getContextPath()%>/public/thumbnails/<%=post.getThumbnail()%>"
							class="img-fluid w-100 object-fit-cover" />
					</div>
					<div class="card-body">
						<h5 class="card-title"><%=post.getTitle()%></h5>
						<p class="card-text"><%=post.getDescription()%></p>
					</div>
					<div class="card-footer text-center primary-bg">
						<a href="#!" class="btn btn-outline-light btn-sm"><i
							class="fa-solid fa-thumbs-up"></i> <span>10</span></a> <a
							href="show_blog?post_id=<%=post.getPid()%>"
							class="btn btn-outline-light btn-sm">Read more</a> <a href="#!"
							class="btn btn-outline-light btn-sm"><i
							class="fa-solid fa-comment-dots"></i> <span>20</span></a>

					</div>
				</div>

			</div>
			<%
			}
			%>

		</div>


	</div>




	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script src="public/js/script.js"></script>
</body>
</html>