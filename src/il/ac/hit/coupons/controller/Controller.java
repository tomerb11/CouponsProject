package il.ac.hit.coupons.controller;

import il.ac.hit.coupons.dao.IDao;
import il.ac.hit.coupons.dao.imp.*;
import il.ac.hit.coupons.dto.*;
import il.ac.hit.coupons.exception.CouponException;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.LocalTime;

/**
 * Servlet implementation class Controller
 */
/**
 * Controller servlet class for coupons project
 * @author Tomer
 *
 */
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IDao myDao = MySqlDao.getInstance();
	
	public Controller() {
		super();
	}
	
	/**
	 * service method for post request from client and forward to the desired page with the parameters from client
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		String path = request.getPathInfo();
		PrintWriter out = response.getWriter();

		if (path.endsWith("adminmenu"))
		{
			authenticateAdminUser(request, response, out);
		}
		else if (path.endsWith("addtofavorites"))
		{
			int couponId = Integer.parseInt(request.getParameter("id"));
			addToMyFavorites(request, response, couponId);
		}
		else if (path.endsWith("addnewcoupon"))
		{
			addOrUpdateCoupon(request, response, true);
		}
		else if (path.endsWith("deletecoupon"))
		{
			int couponIdToDelete = Integer.parseInt(request.getParameter("couponIdToDelete"));
			try {
				Coupon couponToDelete = myDao.getCoupon(couponIdToDelete);
				myDao.deleteCoupon(couponToDelete);
				request.getRequestDispatcher("/adminmenu.jsp").include(request, response);;
			} catch (CouponException e) {
				e.printStackTrace();
			}
		}
		else if (path.endsWith("updatecoupon"))
		{
			int couponId = Integer.parseInt(request.getParameter("id"));
			request.setAttribute("couponIdToUpdate", couponId);
			request.getRequestDispatcher("/updatecouponbyid.jsp").include(request, response);
		}
		else if(path.endsWith("couponhasbeenupdated"))
		{
			addOrUpdateCoupon(request, response, false);
			request.getRequestDispatcher("/adminmenu.jsp").include(request, response);
		}
		else if (path.endsWith("signout"))
		{
			request.getSession().invalidate();
			response.sendRedirect("/Coupons");
		}
		else if (path.endsWith("userlocation"))
		{
			try {
				sortCouponsByDistance(request, response);
			} catch (CouponException | ParseException e) {
				e.printStackTrace();
			}
			response.sendRedirect(request.getHeader("referer"));	
		}
	}	
	
	/**
	 * service method for get request from client and forward to the desired page
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getPathInfo();
		if(path.endsWith("listofcoupons"))
		{
			request.getRequestDispatcher("/listofcoupons.jsp").include(request, response);
		}
		else if (path.endsWith("addnewcoupon"))
		{
			request.getRequestDispatcher("../addnewcoupon.jsp").include(request, response);
		}
		else if (path.endsWith("index"))
		{
			String couponTypeToSortBy = request.getParameter("typeofcoupons");
			if (couponTypeToSortBy != null)
			{
				request.getSession().setAttribute("couponTypeToSortBy", couponTypeToSortBy);
			}
			else
			{
				request.getSession().setAttribute("couponTypeToSortBy", "All");
			}
			response.sendRedirect(request.getHeader("referer"));
		}
		else if (path.endsWith("myfavoritecoupons"))
		{
			request.getRequestDispatcher("/myfavoritecoupons.jsp").include(request, response);
		}
		else if (path.endsWith("/loginform"))
		{
			request.getSession().setAttribute("isValidUser", "hidden");
			request.getRequestDispatcher("/loginform.jsp").include(request, response);
		}
		else if(path.endsWith("errorpage"))
		{
			String goToPage = request.getSession().getAttribute("gotopage").toString();
			request.getRequestDispatcher(".." + goToPage).include(request, response);
		}
	}

	/**
	 * method sort the coupons list by distance according user location
	 * @param request
	 * @param response
	 * @throws CouponException
	 * @throws ParseException
	 */
	private void sortCouponsByDistance(HttpServletRequest request,HttpServletResponse response) throws CouponException, ParseException {
		double latUser = Double.parseDouble(request.getParameter("lat"));
		double lonUser = Double.parseDouble(request.getParameter("lang"));
		double distanceFromCouponToUser;
		HashMap<Double, Coupon> couponsDistanceToUserLocationMap = new HashMap <Double, Coupon>();
		List<Coupon> couponList = getNonExpiredCoupons();
		List<Coupon> sortedCouponsList = new ArrayList<Coupon>();

		for (Coupon coupon : couponList)
		{
			distanceFromCouponToUser = calcDistance (latUser, lonUser, coupon.getLatitude(), coupon.getLongitude());
			couponsDistanceToUserLocationMap.put(distanceFromCouponToUser, coupon);
		}

		List<Double> distancesList = new ArrayList<Double>(couponsDistanceToUserLocationMap.keySet());
		Collections.sort(distancesList);

		for (Double distance : distancesList)
		{
			sortedCouponsList.add(couponsDistanceToUserLocationMap.get(distance));
		}

		request.getSession().setAttribute("sortedCouponsList", sortedCouponsList);
	}

	/**
	 * method calculate the distance between 2 coordinates
	 * @param latUser
	 * @param lonUser
	 * @param latCoupon
	 * @param lonCoupon
	 * @return the distance between the 2 coordinates
	 */
	private double calcDistance (double latUser, double lonUser, double latCoupon, double lonCoupon)
	{
		double theta = lonUser - lonCoupon;
		double dist = Math.sin(deg2rad(latUser)) * Math.sin(deg2rad(latCoupon)) + Math.cos(deg2rad(latUser)) * Math.cos(deg2rad(latCoupon)) * Math.cos(deg2rad(theta));
		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;
		dist = dist * 1.609344;
		return dist;
	}
	
	/**
	 * converting degrees to radians
	 * @param deg
	 * @return the degree in radians
	 */
	private double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	/**
	 * converting radians to degree
	 * @param rad
	 * @return the radian in degree
	 */
	private double rad2deg(double rad) {
		return (rad * 180 / Math.PI);
	}

	/**
	 * method add selected coupons to user favorite list
	 * @param request
	 * @param response
	 * @param couponId
	 */
	private void addToMyFavorites(HttpServletRequest request, HttpServletResponse response, int couponId) {
		boolean isForwaded = false;
		ShoppingCart myFavoriteList = (ShoppingCart) request.getSession().getAttribute("myFavoritesList");
		
		if (myFavoriteList == null)
		{
			myFavoriteList = new ShoppingCart();
			request.getSession().setAttribute("RegularUser", true);
		}

		myFavoriteList.addFavoriteCouponId(couponId);
		request.getSession().setAttribute("myFavoritesList", myFavoriteList);
		if(!isForwaded) {
			try {
				response.sendRedirect(request.getHeader("referer"));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * method add or update coupon according to paramters received from client and forward to the appropriate url
	 * @param request
	 * @param response
	 * @param isNewCoupon
	 */
	private void addOrUpdateCoupon(HttpServletRequest request, HttpServletResponse response, boolean isNewCoupon) {
		boolean isForwaded = false;
		String name = "";
		String description = "";
		String couponType = "";
		int availableAmount = 0;
		double discountPercentage = Double.parseDouble(request.getParameter("discountPercentage"));
		double originalPrice = Double.parseDouble(request.getParameter("originalPrice"));
		String location = "";
		double lat = 0;
		double lang = 0;
		String expireTime = "";
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date expireDate = new Date();
		Coupon coupon = null;
		
		try
		{
			availableAmount = Integer.parseInt(request.getParameter("availableAmount"));
		}
		catch (NumberFormatException e)
		{
			request.getSession().setAttribute("errorMessage", "Enter only numbers");
			request.getSession().setAttribute("gotopage", "/adminmenu.jsp");

			try {
				request.getRequestDispatcher("/errorpage.jsp").include(request, response);
				isForwaded = true;
			} catch (ServletException | IOException e1) {
				e1.printStackTrace();
			}
		}
		
		try {
			name = request.getParameter("name");
			description = request.getParameter("description");
			couponType = request.getParameter("couponType");
			expireDate = formatter.parse(request.getParameter("expireDate"));
			discountPercentage = Double.parseDouble(request.getParameter("discountPercentage"));
			originalPrice = Double.parseDouble(request.getParameter("originalPrice"));
			location = request.getParameter("location");
			lat = Double.parseDouble(request.getParameter("lat"));
			lang = Double.parseDouble(request.getParameter("lang"));
			expireTime = request.getParameter("expireTime");
		} catch (ParseException e) {
			request.getSession().setAttribute("errorMessage", e.getMessage());
		}
		catch (NumberFormatException e){
			request.getSession().setAttribute("errorMessage", "You need to choose location");
			request.getSession().setAttribute("gotopage", "/adminmenu.jsp");
		}
		
		if (isNewCoupon && !isForwaded)
		{
			try {
				coupon = new Coupon(name, description, couponType, availableAmount, expireDate, expireTime, discountPercentage, originalPrice, location, lat, lang);
				myDao.addCoupon(coupon);
				isForwaded = true;
			} 
			catch (CouponException e) {
				request.getSession().setAttribute("errorMessage", e.getMessage());
				request.getSession().setAttribute("gotopage", "/addnewcoupon.jsp");
			} 
			
			if (isForwaded){
				try {
					request.getRequestDispatcher("/adminmenu.jsp").include(request, response);
				} catch (ServletException | IOException e) {
					e.printStackTrace();
				}
			}
			else
			{
				try {
					request.getRequestDispatcher("/errorpage.jsp").forward(request, response);
				} catch (ServletException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		else if(!isForwaded)
		{
			int couponIdToUpdate = Integer.parseInt(request.getParameter("couponIdToUpdate"));
			try {
				coupon = myDao.getCoupon(couponIdToUpdate);
				coupon.setName(name);
				coupon.setDescription(description);
				coupon.setCouponType(couponType);
				coupon.setAvailableAmount(availableAmount);
				coupon.setDiscountPercentage(discountPercentage);
				coupon.setOriginalPrice(originalPrice);
				coupon.setExpireDate(expireDate);
				coupon.setExpireTime(expireTime);
				coupon.setLocation(location);
				coupon.setLatitude(lat);
				coupon.setLongitude(lang);
				coupon.calculatePriceAfterDiscount();
				myDao.updateCoupon(coupon);
			} catch (CouponException e) {
				request.setAttribute("errorMessage", e.getMessage());
				try {
					request.getRequestDispatcher("/errorpage.jsp").include(request, response);
				} catch (ServletException | IOException e1) {
					e1.printStackTrace();
				}
			}
		}	
	}

	/**
	 * method authenticate admin user from database using md5 algorithm to decrypt password
	 * @param request
	 * @param response
	 * @param out
	 */
	private void authenticateAdminUser(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
		boolean isValidUser = false;
		String userName = request.getParameter("userName");
		User adminUser = null;

		if (userName != null) {
			try {
				List<User> users =  myDao.getUsersArray();
				String md5Password = MD5String(request.getParameter("password"));

				for(User currentUser : users) {
					if(currentUser.getUserName().equals(userName) && currentUser.getPassword().equals(md5Password)) {
						isValidUser = true;
						adminUser = currentUser;
						break;
					}
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}

			// Checking if user already logged in or the user name and password are not correct.
			if(isValidUser)
			{	
				try {
					request.getSession().setAttribute("userAdmin", adminUser);
					request.getSession().setMaxInactiveInterval(6000);
					request.getRequestDispatcher("../adminmenu.jsp").include(request, response);
				} catch (ServletException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				request.getSession().setAttribute("isValidUser", "hidden");
			}
			else
			{
				request.getSession().setAttribute("isValidUser", "");
				try {
					request.getRequestDispatcher("../loginform.jsp").include(request, response);
				} catch (IOException | ServletException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * method responsible for filtering the coupons list according their expire date
	 * @return list of coupons that their expire date is greater than today
	 * @throws CouponException coupon exception custom
	 * @throws ParseException parse
	 */
	public static List<Coupon> getNonExpiredCoupons() throws CouponException, ParseException
	{
		ArrayList<Coupon> allCouponsArray = (ArrayList<Coupon>) MySqlDao.getInstance().getCoupons();
		List<Coupon> filteredCouponArray = new ArrayList<Coupon>(); 
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date todayDate = new Date();
		String todayDateStr = format.format(todayDate);
		LocalTime currentTime = LocalTime.now();
		LocalTime couponTime; 
		
		for (Coupon coupon : allCouponsArray)
		{
			if (coupon.getExpireDate().after(todayDate))
			{
				filteredCouponArray.add(coupon);
			}
			else if(coupon.getExpireDate().toString().equals(todayDateStr))
			{
				couponTime = new LocalTime(coupon.getExpireTime());
				if(couponTime.isAfter(currentTime))
				{
					filteredCouponArray.add(coupon);
				}
			}
		}

		return filteredCouponArray;
	}

	/**
	 * method received a string and convert it to md5
	 * @param message
	 * @return a encrypted string
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	private static String MD5String(String message) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		MessageDigest messageDigest = MessageDigest.getInstance("MD5");
		byte[] hashedBytes = messageDigest.digest(message.getBytes("UTF-8"));

		return convertByteArrayToHexString(hashedBytes);
	}

	/**
	 * method convert byte to hex
	 * @param arrayBytes
	 * @return string of hex
	 */
	private static String convertByteArrayToHexString(byte[] arrayBytes) 
	{
		StringBuilder stringToReturn = new StringBuilder();

		for (int i = 0; i < arrayBytes.length; i++) 
		{
			stringToReturn.append(Integer.toString((arrayBytes[i] & 0xff) + 0x100, 16).substring(1));
		}

		return stringToReturn.toString();
	}
}
