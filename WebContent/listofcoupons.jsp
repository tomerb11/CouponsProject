<%@ page import="il.ac.hit.coupons.dao.imp.MySqlDao"%>
<%@ page import="il.ac.hit.coupons.dto.Coupon"%>
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
	<title>List of coupons for admin</title>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0/angular.min.js"></script>
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

<h1>All coupons</h1>

<%
    ArrayList<Coupon> couponsArrayList = null;
	Iterator<Coupon> i;
	Coupon coupon;
    
    try {
    	couponsArrayList = (ArrayList<Coupon>) MySqlDao.getInstance().getCoupons();
	} 
	catch (CouponException cnfe) {
		cnfe.printStackTrace();
	}
    
	i = couponsArrayList.iterator();

	while (i.hasNext()) {

		coupon = (Coupon) i.next();
		out.println("<hr/>");
		out.println("<form action ='updatecoupon?id="+ coupon.getId() + "' method='post'>");
		out.println("<input type='submit' value='Update this coupon'></form><br>");
		out.println("<form action ='deletecoupon?couponIdToDelete=" + coupon.getId() + "' method='post'>");
		out.println("<input type='submit' value='Delete this coupon'></form><br>");
		out.println(coupon.toHtml());
	}
}
%>
</body>
</html>