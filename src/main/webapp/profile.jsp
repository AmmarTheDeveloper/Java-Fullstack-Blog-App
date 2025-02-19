<%@page import="com.learnonline.entities.Category"%>
<%@page import="com.learnonline.dao.CategoryDao"%>
<%@page import="com.learnonline.helper.ConnectionProvider"%>
<%@page import="com.learnonline.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.learnonline.dao.PostDao"%>
<%@page import="com.learnonline.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Page</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<link rel="stylesheet"
	href="<%=application.getContextPath()%>/public/css/style.css" />
<style>
body {
	background-image:
		url("<%=application.getContextPath()%>/public/images/bg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
</head>
<body>
	<%@ include file="common/admin-navbar.jsp"%>


	<%
	PostDao dao = new PostDao(ConnectionProvider.getConnection());
	ArrayList<Post> posts = dao.getPosts();
	%>

	<main>

		<div class="container">

			<div class="row justify-content-center mt-4">
				<div class="col-8 col-md-4">

					<div class="list-group">
						<a href="#" id="all-posts" onclick="getPosts(0,this)"
							class="c-link list-group-item list-group-item-light active">
							All Posts </a>
						<%
						CategoryDao cdao = new CategoryDao(ConnectionProvider.getConnection());
						ArrayList<Category> categories = cdao.getCategories();

						for (Category cat : categories) {
						%>
						<a href="#" onclick="getPosts(<%=cat.getCid()%>,this)"
							class="c-link list-group-item list-group-item-light "><%=cat.getName()%></a>
						<%
						}
						%>
					</div>

				</div>
				<div class="col-12 col-md-8">

					<div class="container text-center" id="loader">

						<i class="fa fa-refresh fa-spin fa-4x"></i>
						<h3 class="mt-2">Loading...</h3>

					</div>
					<div class="container-fluid" id="post-container"></div>

				</div>
			</div>

		</div>

	</main>


	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script src="public/js/script.js"></script>
	<script src="public/js/admin-script.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="public/js/like-system.js"></script>

	<script>
	
	
		function getPosts(catId,link){
			$("#loader").show();
			$("#post-container").hide();
			
			$(".c-link").removeClass("active");
			
			$.ajax({
				url:"load_blogs",
				data:{cid:catId},
				success:function(data,  textStatus,jqXHR){
					
					$("#loader").hide();
					$("#post-container").show();
					$("#post-container").html(data);
					if(link){						
					$(link).addClass("active");
					}else{
						$("#all-posts").addClass("active");
					}
					
				}
			})
		}
	
		$(document).ready(function(){
			
			getPosts(0);
			
		})
		
	
	</script>
</body>
</html>