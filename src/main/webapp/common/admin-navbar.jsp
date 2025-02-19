<%@page import="com.learnonline.entities.Message"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.learnonline.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
User user = (User) session.getAttribute("currentUser");
/* if (user == null) {
	response.sendRedirect("login.jsp");
} */
%>

<%
/*  String current_page = this.getClass().getSimpleName().replace("_jsp", "");*/
String currentURL = request.getRequestURL().toString();
String[] splittedURL = currentURL.split("/");
String location = splittedURL[splittedURL.length - 1];
String[] splittedLocation = location.split(".jsp");
String current_page = splittedLocation[0];
%>

<nav class="navbar navbar-expand-lg navbar-dark primary-bg">
	<div class="container-fluid">
		<a class="navbar-brand"
			href="<%=application.getContextPath()%>/profile"> <i
			class="fa-solid fa-pen-nib"></i> LearnOnline
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				
				<li class="nav-item"><a
					class="nav-link <%=current_page.equals("add_blog") ? "active" : ""%>"
					aria-current="page" href="add_blog"> <i
						class="fa-solid fa-square-plus"></i> Add Blog
				</a></li>
				<li class="nav-item"><a
					class="nav-link <%=current_page.equals("my_blogs") ? "active" : ""%>"
					aria-current="page" href="my_blogs"> <i
						class="fa-solid fa-book"></i> My Blogs
				</a></li>
				<li class="nav-item"><a
					class="nav-link <%=current_page.equals("contact") ? "active" : ""%>"
					aria-current="page" href="contact"> <i
						class="fa-solid fa-address-book"></i> Contact
				</a></li>
			</ul>

			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a href="#!" data-bs-toggle="modal"
					data-bs-target="#profile-modal" class="nav-link"> <img
						src="<%=application.getContextPath()%>/public/profile-images/<%=user.getProfile()%>"
						class="img-fluid"
						style="height: 30px; width: 30px; border-radius: 50%" /> <%=user.getName()%>
				</a></li>
				<li class="nav-item"><a
					href="<%=application.getContextPath()%>/logout" class="nav-link">
						<span class="fa-solid fa-right-from-bracket"></span> Logout
				</a></li>
			</ul>
		</div>
	</div>
</nav>


<!-- navbar design ends here  -->

<!-- modal design starts here  -->

<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header primary-bg text-white text-center">

				<h1 class="modal-title fs-5">LearnOnline</h1>
				<button type="button" class="btn-close bg-white" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container text-center">
					<img
						src="<%=application.getContextPath()%>/public/profile-images/<%=user.getProfile()%>"
						class="img-fluid"
						style="height: 80px; width: 80px; border-radius: 50%" />
					<h5 class="modal-title fs-5 mt-3">
						<%=user.getName()%>
					</h5>


					<!--  details -->


					<div id="profile-detail">

						<table class="table">
							<tbody>
								<tr>
									<th scope="row">ID:</th>
									<td><%=user.getId()%></td>
								</tr>
								<tr>
									<th scope="row">Email:</th>
									<td><%=user.getEmail()%></td>
								</tr>
								<tr>
									<th scope="row">Gender:</th>
									<td><%=user.getGender()%></td>
								</tr>
								<tr>
									<th scope="row">About:</th>
									<td><%=user.getAbout()%></td>
								</tr>
								<tr>
									<th scope="row">Registered on:</th>
									<td><%=user.getDateTime().toLocalDateTime()%></td>
								</tr>
							</tbody>
						</table>

					</div>


					<div style="display: none" id="profile-edit">
						<h3 class="mt-3">Please Edit Carefully</h3>
						<form action="<%=application.getContextPath()%>/edit-profile"
							method="POST" enctype="multipart/form-data">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">ID:</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Name:</th>
										<td><input type="text" name="name" class="form-control"
											value="<%=user.getName()%>" /></td>
									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><input type="email" name="email" class="form-control"
											value="<%=user.getEmail()%>" /></td>
									</tr>
									<tr>
										<th scope="row">Password:</th>
										<td><input type="password" name="password"
											class="form-control" value="<%=user.getPassword()%>" /></td>
									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><label for="male"> <input type="radio"
												name="gender" id="male" value="male"
												<%if (user.getGender().equals("male")) {%> checked <%}%> />
												Male
										</label> <label for="female"> <input type="radio"
												name="gender" id="female" value="female"
												<%if (user.getGender().equals("female")) {%> checked <%}%> />
												Female
										</label></td>
									</tr>
									<tr>
										<th scope="row">About:</th>
										<td><textarea class="form-control" name="about" rows="5"><%=user.getAbout()%></textarea></td>
									</tr>
									<tr>
										<th scope="row">Profile Pic:</th>
										<td><input type="file" name="profile"
											class="form-control" /></td>
									</tr>
								</tbody>
							</table>

							<div class="container">
								<button type="submit" class="btn btn-outline-primary">Save</button>
							</div>
						</form>

					</div>


				</div>


			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="edit-profile-btn">Edit</button>
			</div>
		</div>
	</div>
</div>

<%
Message updateStatus = (Message) request.getAttribute("msg");
%>


<%
if (updateStatus != null) {
%>

<%
request.removeAttribute("msg");
%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
	
		Swal.fire({
			title:"<%= updateStatus.getType() %>",
			text:"<%= updateStatus.getContent() %>",
			icon:"<%= updateStatus.getType() %>"
		})
	
	</script>

<%
}
%>


