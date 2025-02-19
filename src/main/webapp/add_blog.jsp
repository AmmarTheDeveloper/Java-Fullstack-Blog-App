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
<title>Add Blog</title>

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
</head>
<body>
	<%@ include file="common/admin-navbar.jsp"%>


	<div class="container py-5 px-2">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header text-white text-center primary-bg">

						<i class="fa-solid fa-square-plus fa-3x"></i>
						<p>Add Blog</p>

						<br>
					</div>

					<%
					Message msg = (Message) session.getAttribute("msg");
					if (msg != null) {
					%>

					<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

					<script>
					Swal.fire({
						title:"<%=msg.getType()%>",
						text:"<%=msg.getContent()%>",
						icon:"<%=msg.getType()%>"
					})
					</script>

					<%
					session.removeAttribute("msg");
					}
					%>
					<div class="card-body">
						<form id="register-form"
							action="<%=application.getContextPath()%>/add_blog" method="POST"
							enctype="multipart/form-data">

							<div class="mb-3">
								<label for="title" class="form-label">Blog title</label> <input
									type="text" class="form-control" name="title"
									placeholder="Enter blog title" id="title">
							</div>
							<div class="mb-3">
								<label for="description" class="form-label">Blog
									Description</label>
								<textarea class="form-control" name="description"
									placeholder="Enter blog description" id="description"></textarea>
							</div>



							<div class="mb-3">
								<%
								CategoryDao dao = new CategoryDao(ConnectionProvider.getConnection());
								ArrayList<Category> categories = dao.getCategories();
								%>
								<label for="category" class="form-label">Category</label> <select
									class="form-select" name="category">
									<option selected disabled value="">Select category</option>
									<%
									for (Category cat : categories) {
									%>
									<option value="<%=cat.getCid()%>"><%=cat.getName()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="mb-3">
								<label for="thumbnail" class="form-label">Thumbnail</label> <input
									type="file" name="thumbnail" class="form-control"
									id="thumbnail" placeholder="Upload thumbnail">
							</div>

							<!-- blog content will be stored in this hidden input  -->
							<input type="hidden" name="content" id="blogContentInput" />

							<div class="mb-3 mt-4">
								<label for="blog-content" class="form-label">Blog
									content</label>

								<div id="blog-content" style="min-height: 150px;"></div>
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

		// Listen for changes in Quill editor and update the hidden input field
		quill.on('text-change', function() {
			blogContentInput.value = quill.root.innerHTML; // Store the HTML content
		});
	</script>


</body>
</html>