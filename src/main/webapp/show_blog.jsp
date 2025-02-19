<%@page import="com.learnonline.dao.LikeDao"%>
<%@page import="com.learnonline.entities.Post"%>
<%@page import="com.learnonline.helper.ConnectionProvider"%>
<%@page import="com.learnonline.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Post p = null;
String pid = request.getParameter("post_id");

try {
	if (pid != null && !pid.isEmpty()) {
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		p = dao.getPostWithOwner(Integer.parseInt(pid));
	}
} catch (Exception e) {

}
String title = p == null ? "Blog Page" : p.getTitle();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=title%> || Learn Online</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

<link rel="stylesheet"
	href="<%=application.getContextPath()%>/public/css/style.css" />


<style>
body {
	background-image:
		url("<%=application.getContextPath()%>/public/images/bg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}

.blog-content img {
	max-width: 100%;
}
</style>
</head>

<body>
	<div id="fb-root"></div>
	<script async defer crossorigin="anonymous"
		src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v22.0&appId=2201440840251239"></script>
	<%
	if (p == null) {
	%>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
		Swal.fire({
			title : "Error",
			text : "Invalid blog id provided...",
			icon : "error",
		})
	</script>
	<%
	String route;
	if (session.getAttribute("currentUser") == null) {
		route = "/index.jsp";
	} else {
		route = "/my_blogs";
	}
	RequestDispatcher rd = request.getRequestDispatcher(route);
	rd.include(request, response);
	} else {
	%>

	<%@ include file="common/admin-navbar.jsp"%>

	<div class="container">


		<div class="row justify-content-center py-2">


			<div class="col-sm-10 col-md-8">
				<div class="card">
					<div class="card-header primary-bg text-white">
						<h3 class="display-6"><%=p.getTitle()%></h3>
					</div>
					<div class="card-body">
						<div class="ratio ratio-16x9">
							<img
								src="<%=application.getContextPath()%>/public/thumbnails/<%=p.getThumbnail()%>"
								class="img-fluid object-fit-cover" />
						</div>
						<div>
							<p class="text-secondary mt-2">
								<%=p.getDescription()%>
							</p>

							<div
								class="d-flex align-items-center p-2 gap-3 border-top border-bottom bg-light bg-opacity-5 border-secondary my-2"
								style="--bs-border-opacity: .5;">
								<img
									src="<%=application.getContextPath()%>/public/profile-images/<%=p.getUser().getProfile()%>"
									class="img-fluid rounded-circle object-fit-cover"
									style="height: 50px; width: 50px;" />
								<div>
									<p class="text-secondary m-0"><%=p.getUser().getName()%></p>
									<p class="text-secondary m-0"><%=p.getDate().toLocaleString()%></p>
								</div>
							</div>


							<div class="blog-content my-2 overflow-hidden">


								<%=p.getContent()%>

							</div>


						</div>
					</div>
					<div class="card-footer text-center primary-bg">

						<%
						LikeDao dao = new LikeDao(ConnectionProvider.getConnection());
						int count = dao.getLikes(p.getPid());

						boolean isLiked = dao.isLiked(p.getPid(), user.getId());
						%>

						<%
						if (isLiked) {
						%>
						<span id="like-btn-container"> <a href="#!" id="like-btn"
							onclick="deleteLike(<%=p.getPid()%>,<%=user.getId()%>,this)"
							class="btn btn-light btn-sm"> <i
								class="fa-solid fa-thumbs-up"></i> <span id="like-count"><%=count%></span>
						</a>
						</span>
						<%
						} else {
						%>
						<span id="like-btn-container"> <a href="#!" id="like-btn"
							onclick="like(<%=p.getPid()%>,<%=user.getId()%>,this)"
							class="btn btn-outline-light btn-sm"> <i
								class="fa-solid fa-thumbs-up"></i> <span id="like-count"><%=count%></span>
						</a>
						</span>
						<%
						}
						%>



					</div>
					<div class="card-footer">

						<div class="fb-comments"
							data-href="http://127.0.0.1:8080/LearnOnline/show_blog?post_id=<%=p.getPid()%>"
							data-width="100%" data-numposts=""></div>
					</div>


				</div>
			</div>

		</div>


	</div>

	<%
	}
	%>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="public/js/script.js"></script>
	<script src="public/js/admin-script.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="public/js/like-system.js"></script>

</body>
</html>