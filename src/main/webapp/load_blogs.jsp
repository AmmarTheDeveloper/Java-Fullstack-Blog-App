<%@page import="com.learnonline.entities.User"%>
<%@page import="com.learnonline.dao.LikeDao"%>
<%@page import="com.learnonline.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.learnonline.helper.ConnectionProvider"%>
<%@page import="com.learnonline.dao.PostDao"%>


<%

User user = (User) session.getAttribute("currentUser");

%>
<div class="row">
	<%
	int cid = Integer.parseInt(request.getParameter("cid"));

	PostDao dao = new PostDao(ConnectionProvider.getConnection());
	ArrayList<Post> posts;

	if (cid == 0) {
		posts = dao.getPosts();

	} else {
		posts = dao.getPostByCategoryId(cid);
	}

	if (posts.size() == 0) {
		out.println("<div class='alert alert-danger'>  No posts in this category... </div>");
		return;
	}

	for (Post post : posts) {
	%>

	<div class="col-sm-6 col-md-6 my-3">

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
					class="btn btn-light btn-sm"> <i class="fa-solid fa-thumbs-up"></i>
						<span id="like-count"><%=count%></span>
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
	%>

</div>
