<%@page import="org.apache.catalina.connector.Request"%>
<%@page import="il.ac.hit.coupons.dto.Coupon"%>
<%@page import="il.ac.hit.coupons.dao.imp.MySqlDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>

<%@ page language="java" contentType="text/html; charset=windows-1255"
	pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<body>

<% String errorMessage = request.getSession().getAttribute("errorMessage").toString(); %>

<%=errorMessage %>

<%-- <script>alert('<%=errorMessage %>')</script> --%>

<form name="errorpage" action="errorpage" method="get">

			<button type="submit">Back</button>

		</form>

<%-- 	 <% response.setHeader("Refresh", "1; URL=/Coupons/errorpage");%>  
 --%><%-- 				<% response.sendRedirect(request.getHeader("referer")); %>
 --%>	

</body>
</html>