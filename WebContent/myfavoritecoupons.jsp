<%@ page import="il.ac.hit.coupons.dao.imp.MySqlDao"%>
<%@ page import="il.ac.hit.coupons.dto.Coupon"%>
<%@ page import="il.ac.hit.coupons.controller.Controller"%>
<%@ page import="il.ac.hit.coupons.dto.ShoppingCart"%>
<%@ page import="il.ac.hit.coupons.exception.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0/angular.min.js"></script>
</head>
<body>

<h1>My Favorite List</h1>

<jsp:useBean id="coupon1" class="il.ac.hit.coupons.dto.Coupon"></jsp:useBean>
<jsp:setProperty property="*" name="coupon1"/>


<div id="someCoupon">
	<!-- <img src="images/Ruben_herzliya.jpg" style="width:304px;height:228px"> -->

	<!-- <h1>Burgers 40% off late night !</h1>  -->	
	<!-- <input class="btn btn-lg btn-success btn-block" type="submit" value="Buy now"> -->
</div>

<%!ArrayList<Coupon> couponsArrayList = null;
	Iterator<Coupon> i;
	Coupon coupon;
	ShoppingCart myFavoritesList = null;%>
	
<%
		if(request.getSession().getAttribute("myFavoritesList") == null)
	{
		out.println("Your favorite list is empty!");
	}
	else{
		myFavoritesList = (ShoppingCart) request.getSession().getAttribute("myFavoritesList");
	    try {
	    	couponsArrayList = (ArrayList<Coupon>) Controller.getNonExpiredCoupons();
		} 
		catch (CouponException cnfe) {
			cnfe.printStackTrace();
		}
	    
		i = couponsArrayList.iterator();

		while (i.hasNext()) {

			coupon = (Coupon) i.next();
			if(myFavoritesList.getFavorites().contains(coupon.getId()))
			{
		out.println("Coupon ID : " + coupon.getId());	
		out.println(coupon.toHtml() + "<br><br>");
			}
		}
	}
	%>

<!-- <script>
function deleteFunc(couponId) {
	var url = "http://localhost:8080/Coupons/CouponsWebsite";
	

    $.ajax({
           type: "POST",
           url: url,
           data: {"fromUrl":"deleteCoupon", "couponIdToDelete":couponId.toString()},   // serializes the form's elements. ??? send couponid
           success: function(data) {
               console.log(data);
               alert("You delete " + data + " coupon!!!")
               //console.log()
               //if(userAuthenticated == true)
            	//console.alert("you deleted coupon " + couponName);
			   window.location.href = "/Coupons/deletecoupon.jsp"
           },
    	   error: function() {
               console.log("delete didnt succeded ");
      	   }
         });
}
</script> -->

</body>
</html>