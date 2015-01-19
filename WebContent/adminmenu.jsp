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
<button type="submit">Manage existing coupons</button><br>
<br>
</form>


<!-- <p><button onclick='buttonClicked("addnewcoupon")'>Add Coupon</button></p>

<p><button onclick='buttonClicked("deletecoupon")'>Delete Coupon</button></p>

<p><button onclick='buttonClicked("view")'>View List Of Coupons</button></p>

<p><button onclick='buttonClicked("updatecouponmenu")'>Update Existing Coupon</button></p> -->


<form action ="signout" method="post"><br>
<button type="submit">Sign Out</button><br>
</center>
<br>
</form>
<%} %>




<!-- <script>
function buttonClicked(action) {
 //  	alert("you chose " + param1);
	// send to controllerrrrrrrrrrrrrrrr.............ajax 
		
    	var url = "http://localhost:8080/Coupons/CouponsWebsite";
    	
        //console.log("Clicked add to favorites ");

        $.ajax({
               type: "POST",
               url: url,
               data: {"fromUrl":"AdminMenu", "ToAction":action},   // serializes the form's elements. ??? send couponid
               success: function(url) {
                   console.log("Success. you sent ");
                   //if(userAuthenticated == true)
				   window.location.href = url;
               },
        	   error: function() {
                   console.log("Fail. you sent ");
          	   }
             });
}
</script> -->


</body>
</html>