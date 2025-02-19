<%@page import="com.learnonline.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>

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


</head>
<body>


	<!-- navbar  -->
	<%@ include file="common/navbar.jsp"%>

	<main
		class="d-flex justify-content-center align-items-center primary-bg banner-bg px-md-5 px-2 py-5"
		style="min-height: 80vh;">

		<div class="container">

			<div class="row">


				<div class="col-md-4 offset-md-4">

					<div class="card">

						<div class="card-header text-white text-center primary-bg">

							<span class="fa fa-user-circle fa-3x"></span>
							<p>Login Here</p>
							<br>
						</div>

						<%
						Message msg = (Message) session.getAttribute("msg");
						if (msg != null) {
						%>

						<div class="alert <%=msg.getCssClass()%>" role="alert">
							<%=msg.getContent()%>
						</div>

						<%
						session.removeAttribute("msg");
						}
						%>

						<div class="card-body">

							<form action="<%=application.getContextPath()%>/login"
								method="POST">
								<div class="mb-3">
									<label for="email" class="form-label">Email address</label> <input
										type="email" name="email" class="form-control" id="email"
										placeholder="Enter email" required>
								</div>
								<div class="mb-3">
									<label for="password" class="form-label">Password</label> <input
										type="password" name="password" class="form-control"
										placeholder="Enter password" id="password">
								</div>
								<div class="container text-center">
									<button type="submit" class="btn primary-bg text-white">Submit</button>
								</div>
							</form>

						</div>


					</div>

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

</body>
</html>