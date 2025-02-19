<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Page</title>

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
		class="d-flex justify-content-center align-items-center primary-bg banner-bg px-md-5 px-2 pt-5"
		style="min-height: 80vh; padding-bottom: 90px">

		<div class="container">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card">
						<div class="card-header text-white text-center primary-bg">

							<span class="fa fa-user-plus fa-3x"></span>
							<p>Register Here</p>

							<br>
						</div>
						<div class="card-body">
							<form id="register-form"
								action="<%=application.getContextPath()%>/register"
								method="POST">

								<div class="mb-3">
									<label for="username" class="form-label">Username</label> <input
										type="text" class="form-control" name="username"
										placeholder="Enter Username" id="username">
								</div>

								<div class="mb-3">
									<label for="email" class="form-label">Email address</label> <input
										type="email" class="form-control" name="email" id="email"
										placeholder="Enter email">
								</div>
								<div class="mb-3">
									<label for="password" class="form-label">Password</label> <input
										type="password" name="password" class="form-control"
										id="password" placeholder="Enter password">
								</div>


								<div class="mb-3">
									<label class="form-label">Select Gender</label> <br> <label
										for="male"> <input type="radio" id="male"
										name="gender" value="male"> Male
									</label> <label for="female"> <input type="radio" id="female"
										name="gender" value="female"> Female
									</label>
								</div>

								<div class="mb-3">
									<textarea placeholder="Enter something about yourself"
										name="about" rows="10" class="form-control"></textarea>
								</div>

								<div class="mb-3 form-check">
									<input type="checkbox" name="terms" class="form-check-input"
										id="terms"> <label class="form-check-label"
										for="terms">Agree terms and conditions</label>
								</div>

								<div class="container text-center" id="loader"
									style="display: none">
									<span class="fa fa-refresh fa-3x fa-spin"></span>
									<h4>Please wait...</h4>
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
	</main>


	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script src="public/js/script.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<script>
	$(document).ready(function(){
		
		$('#register-form').on('submit',function(e){
			e.preventDefault();
			
			let form = new FormData(this);
			
			
			$('#submit-btn').hide();
			$("#loader").show();
			
			$.ajax({
				url:"<%=application.getContextPath()%>/register",
					type : "POST",
					data : form,
					success : function(data, textStatus, jqXHR) {
						console.log("Data: " + data)
						$('#submit-btn').show();
						$("#loader").hide();
						
						if(data.trim() == "done"){
							Swal.fire({
								  title: "Registered successfully!",
								  text:"Redirecting to login page...",
								  icon: "success",
							}).then(val =>{
								window.location = "<%=application.getContextPath()%>/login.jsp"
							})
						}else{
							Swal.fire({
								title:"Error occured",
								text:data,
								icon:"error"
							});
						}
						
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log("Error: " + jqXHR)
						
						$('#submit-btn').show();
						$("#loader").hide();
						
						Swal.fire({
							title:"Something went wrong",
							text:"Please try again...",
							icon:"error"
						})
					},
					processData : false,
					contentType : false
				})

			})
		})
	</script>

</body>
</html>