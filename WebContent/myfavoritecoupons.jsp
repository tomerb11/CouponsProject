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

</body>
</html>