<%@page import="com.learnonline.dao.LikeDao"%>
<%@page import="com.learnonline.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.learnonline.helper.ConnectionProvider"%>
<%@page import="com.learnonline.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My blogs</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

<link rel="stylesheet"
	href="<%=application.getContextPath()%>/public/css/style.css" />
</head>
<style>
body {
	background-image:
		url("<%=application.getContextPath()%>/public/images/bg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
<body>


	<%@ include file="common/admin-navbar.jsp"%>

	<main>

		<div class="container">

			<div class="row justify-content-center mt-4">

				<%
				PostDao dao = new PostDao(ConnectionProvider.getConnection());
				ArrayList<Post> posts = dao.getPostsByOwner(user.getId());

				if (posts.size() == 0) {
				%>

				<div class='alert alert-danger'>No blogs uploaded by you...</div>
				<div class='text-center mt-2'>
					<a href="add_blog" class="btn btn-primary">Add Blog</a>
				</div>

				<%
				} else {
				for (Post post : posts) {
				%>
				<div class="col-10 col-sm-6 col-md-4 my-3">

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
						<div class="text-center my-2">
							<a href="update_blog?pid=<%=post.getPid()%>"
								class="btn btn-primary">Update</a> <a
								href="delete_blog?pid=<%=post.getPid()%>" class="btn btn-danger">Delete</a>
						</div>
						<div class="card-footer text-center primary-bg">

							<%
							LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
							int count = ldao.getLikes(post.getPid());

							boolean isLiked = ldao.isLiked(post.getPid(), user.getId());
							%>

							<%
							if (isLiked) {
							%>
							<span id="like-btn-container"> <a href="#!" id="like-btn"
								onclick="deleteLike(<%=post.getPid()%>,<%=user.getId()%>,this)"
								class="btn btn-light btn-sm"> <i
									class="fa-solid fa-thumbs-up"></i> <span id="like-count"><%=count%></span>
							</a>
							</span>
							<%
							} else {
							%>
							<span id="like-btn-container"> <a href="#!" id="like-btn"
								onclick="like(<%=post.getPid()%>,<%=user.getId()%>,this)"
								class="btn btn-outline-light btn-sm"> <i
									class="fa-solid fa-thumbs-up"></i> <span id="like-count"><%=count%></span>
							</a>
							</span>
							<%
							}
							%>
							<a href="show_blog?post_id=<%=post.getPid()%>"
								class="btn btn-outline-light btn-sm">Read more</a>
						</div>
					</div>

				</div>
				<%
				}
				}
				%>


			</div>

		</div>

	</main>



	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="public/js/script.js"></script>
	<script src="public/js/admin-script.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="public/js/like-system.js"></script>

	<%
	Message msg = (Message) request.getAttribute("msg");
	if (msg != null) {
	%>

	<script>
	Swal.fire({
		title:"<%=msg.getType()%>",
		text:"<%=msg.getContent()%>",
		icon:"<%=msg.getType()%>
		"
		})
	</script>


	<%
	request.removeAttribute("msg");
	}
	%>
</body>
</html>