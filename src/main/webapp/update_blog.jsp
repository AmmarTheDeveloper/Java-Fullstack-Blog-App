<%@page import="com.learnonline.entities.Post"%>
<%@page import="com.learnonline.dao.PostDao"%>
<%@page import="com.learnonline.exceptions.CustomException"%>
<%@page import="com.learnonline.entities.Message"%>
<%@page import="com.learnonline.helper.ConnectionProvider"%>
<%@page import="com.learnonline.dao.CategoryDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.learnonline.entities.Category"%>
<%@page import="com.learnonline.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Blog</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- quilljs all required cdn links and configuration  -->
<%@include file="common/quilljs-configuration.jsp"%>

<link rel="stylesheet"
	href="<%=application.getContextPath()%>/public/css/style.css" />
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

	<%

	Post p = null;
	String pid = request.getParameter("pid");

	try{
		if (pid != null && !pid.isEmpty()) {
			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			p = dao.getPost(Integer.parseInt(pid));
		}
	}catch(Exception e){
		
	}

	if (p == null) {
	%>
	<script>
		Swal.fire({
			title : "Error",
			text : "Invalid blog id provided...",
			icon : "error",
		})
	</script>
	<%
	RequestDispatcher rd = request.getRequestDispatcher("/my_blogs");
	rd.include(request, response);
	} else {
	%>
	
	<% 
	Message msg = (Message) request.getAttribute("msg");
	if(msg != null){
		
	
	%>
	<script>
		Swal.fire({
			title : "<%= msg.getType() %>",
			text : "<%= msg.getContent() %>",
			icon : "<%= msg.getType() %>",
		})
	</script>
	
	
	<% } %>
	
	<%@ include file="common/admin-navbar.jsp"%>
	<div class="container py-5 px-2">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header text-white text-center primary-bg">

						<i class="fa-solid fa-book fa-3x"></i>
						<p>Update Blog</p>

						<br>
					</div>


					<div class="card-body">
						<form id="register-form"
							action="<%=application.getContextPath()%>/update_blog" method="POST"
							enctype="multipart/form-data">
							
							<input type="hidden" name="pid" value="<%= p.getPid() %>" />

							<div class="mb-3">
								<label for="title" class="form-label">Blog title</label> <input
									type="text" class="form-control" name="title"
									placeholder="Enter blog title" id="title"
									value="<%=p.getTitle()%>">
							</div>

							<div class="mb-3">
								<%
								CategoryDao dao = new CategoryDao(ConnectionProvider.getConnection());
								ArrayList<Category> categories = dao.getCategories();
								%>
								<label for="category" class="form-label">Category</label> <select
									class="form-select" name="cid">
									<option disabled value="">Select category</option>
									<%
									for (Category cat : categories) {
									%>
									<%
									if (p.getCid() == cat.getCid()) {
									%>
									<option selected value="<%=cat.getCid()%>"><%=cat.getName()%></option>
									<%
									} else {
									%>
									<option value="<%=cat.getCid()%>"><%=cat.getName()%></option>
									<%
									}
									%>
									<%
									}
									%>
								</select>
							</div>
							<div class="mb-3">
								<label for="description" class="form-label">Blog Description</label> 
								<textarea
									class="form-control" name="description"
									placeholder="Enter blog description" id="description"><%=p.getDescription()%></textarea>
							</div>
							<div class="mb-3">
								<label for="thumbnail" class="form-label">Thumbnail</label> <input
									type="file" name="thumbnail" class="form-control"
									id="thumbnail" placeholder="Upload thumbnail">
							</div>

							<!-- blog content will be stored in this hidden input  -->
							<input type="hidden" value="" name="content"
								id="blogContentInput" />

							<div class="mb-3 mt-4">
								<label for="blog-content" class="form-label">Blog
									content</label>

								<div id="blog-content" style="min-height: 150px;"><%=p.getContent()%></div>
							</div>

							<div class="container text-center">
								<button id="submit-btn" type="submit"
									class="btn primary-bg text-white">Submit</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	%>


	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script src="public/js/script.js"></script>
	<script src="public/js/admin-script.js"></script>
	<script>
		const quill = new Quill('#blog-content', {
			modules : {
				toolbar : toolbarOptions,
			},
			placeholder : 'Blog content...',
			theme : 'snow',
		});

		const blogContentInput = document.getElementById('blogContentInput');

		 function setBlogContent(){
				blogContentInput.value = quill.root.innerHTML; // Store the HTML content
		 }
		 setBlogContent();
		// Listen for changes in Quill editor and update the hidden input field
		quill.on('text-change',setBlogContent);
	</script>


</body>
</html>