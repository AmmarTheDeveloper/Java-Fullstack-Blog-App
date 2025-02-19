<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Something went wrong</title>

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


	<div class="container text-center py-2">

		<img src="<%=application.getContextPath()%>/public/images/error.png"
			class="img-fluid" style="max-width: 300px" />
		<h3 class="display-3">Sorry! Something went wrong ...</h3>

		<%=exception%>

		<a href="<%=application.getContextPath()%>/index.jsp"
			class="btn primary-bg btn-lg text-white mt-3">Go Back To Home</a>

	</div>


</body>
</html>