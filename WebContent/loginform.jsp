<%@ page language="java" contentType="text/html; charset=windows-1255"
	pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <script src="https://code.jquery.com/jquery.js"></script> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1255">
<title>Login</title>
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css">
<link rel="stylesheet"
	href="http://bootsnipp.com/css/bootsnipp.min.css?ver=70eabcd8097cd299e1ba8efe436992b7">
<style>
form {
	position: fixed;
	left: 1000px;
	top: 50px;
}
</style>

</head>
<body>

	<%!String isHidden;%>

	<%
		isHidden = request.getSession().getAttribute("isValidUser")
				.toString();
	%>

	<div <%=isHidden%> class="alert alert-danger" role="alert">
		<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="false"></span>
		<span class="sr-only">Error:</span> Invalid username and/or password
	</div>
	<center>
		<div class="container">
			<div class="row" style="margin-top: 100px;">
				<div class="col-lg-4 col-lg-offset-4">
					<form action="adminmenu" method="POST" accept-charset="UTF-8"
						role="form" id="loginform" class="form-signin">
						<input name="_token" type="hidden"
							value="IbktGMhrnupuXdIMeJ07XlyAcZBr66O7OFUuIoKi">
						<fieldset>
							<h3 class="sign-up-title" style="color: dimgray;">Admin Sign
								In</h3>
							<input class="form-control email-title" placeholder="User Name"
								name="userName" type=""> <input class="form-control"
								placeholder="Password" name="password" type="password" value="">
							<br> <br> <input
								class="btn btn-lg btn-success btn-block" type="submit"
								value="Login"> <br>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</center>

</body>
</html>