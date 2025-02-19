<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String current_page = this.getClass().getSimpleName().replace("_jsp", "");
%>

<nav class="navbar navbar-expand-lg navbar-dark primary-bg">
	<div class="container-fluid">
		<a class="navbar-brand" href="<%=application.getContextPath()%>/">
			<i class="fa-solid fa-pen-nib"></i> LearnOnline
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
					class="nav-link <%=current_page.equals("index") ? "active" : ""%>"
					aria-current="page" href="<%=application.getContextPath()%>/">
						<i class="fa-solid fa-house"></i> Home
				</a></li>
				<li class="nav-item"><a href="login"
					class="nav-link <%=current_page.equals("login") ? "active" : ""%> ">
						<span class="fa fa-user-circle"></span> Login
				</a></li>
				<li class="nav-item"><a href="register"
					class="nav-link <%=current_page.equals("register") ? "active" : ""%> ">
						<span class="fa fa-user-plus"></span>Sgin up
				</a></li>
			</ul>
			<form class="d-flex" role="search">
				<input class="form-control me-2" type="search" placeholder="Search"
					aria-label="Search">
				<button class="btn btn-outline-light" type="submit">Search</button>
			</form>
		</div>
	</div>
</nav>