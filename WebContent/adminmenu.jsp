<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
<title>Admin menu</title>
</head>
<body>
<%
if(request.getSession().getAttribute("userAdmin") == null)
{
	out.println("Unauthorized access to page");
	response.setHeader("Refresh", "3; URL=/Coupons");
}
else{
	%>
<center>
<h1><ins>Welcome Admin!</ins></h1>

<p><ins>Please choose an action from the following menu:</ins></p>

<form action ="addnewcoupon" method="get">
<br>
<button type="submit">Add new coupon</button><br>
<br>
</form>

<form action ="listofcoupons" method="get">
<br>
<button type="submit" class="btn btn-primary">Manage existing coupons</button><br>
<br>
</form>



<form action ="signout" method="post"><br>
<button type="submit">Sign Out</button><br>
</center>
<br>
</form>
<%} %>



</body>
</html>