<%@page import="org.apache.catalina.connector.Request"%>
<%@page import="il.ac.hit.coupons.dto.Coupon"%>
<%@page import="il.ac.hit.coupons.dao.imp.MySqlDao"%>
<%@page import="il.ac.hit.coupons.controller.Controller"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.io.IOException"%>


<%@ page language="java" contentType="text/html; charset=windows-1255"
	pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="js/jquery-1.11.2.min.js"></script>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1255">
<script src="https://code.jquery.com/jquery.js"></script>

<link type="text/css"
	href="styles/jquery-ui/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

<!-- google maps -->
<script type="text/javascript"
	src="http://maps.google.com/maps/api/js?sensor=false&language=en"></script>

<!-- jquery -->
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<!-- jquery UI -->
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>

<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1255">
<title>Coupons website</title>
</head>
<body>
	<script>
var lang;
var lat;
</script>






	<div class="container">

		<!-- Static navbar -->
		<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Project name</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="Coupons/loginform">Admin Login</a></li>
					<li><a href="Coupons/myfavoritecoupons">My Favourites</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">Dropdown
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">Action</a></li>
							<li><a href="#">Another action</a></li>
							<li><a href="#">Something else here</a></li>
							<li class="divider"></li>
							<li class="dropdown-header">Nav header</li>
							<li><a href="#">Separated link</a></li>
							<li><a href="#">One more separated link</a></li>

						</ul></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">

					<form name=userLocation action="Coupons/userlocation" method="post">
						<label class="form-group"></label> <input
							id='gmaps-input-address' class="form-group"
							placeholder='Enter your location' type='text' name='location' />
						<button type="submit" class="btn btn-default">Sort
							coupons by distance</button>
						<br /> <br>
						<div id='gmaps-error'></div>
						<div id='gmaps-canvas'></div>
						<input id="getLat" type='hidden' name='lat' /> <input id="getLang"
							type='hidden' name='lang' />
					</form>
					<form name=category action="Coupons/index" method="get">
						<select name=typeofcoupons 	class="col-xs-6">
							<option selected value="All">All</option>
							<option value="Restaurants">Restaurants</option>
							<option value="Vacations">Vacations</option>
							<option value="Shopping">Shopping</option>
							<option value="Fashion">Fashion</option>
							<option value="Electricity">Electricity</option>
						</select>
						<button type="submit" class="btn btn-default">Sort by category</button>
						<br>
					</form>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
		<!--/.container-fluid --> </nav>
	</div>


	<%!
	
		private void printCoupon(Coupon coupon, javax.servlet.jsp.JspWriter out2)
		{
		try {
			out2.println("<hr/>");
			out2.println(coupon.toHtml());
			out2.println("<center><form action ='Coupons/addtofavorites?id=" + coupon.getId() + "' method='post'></center>");
			out2.println("<center><input type='submit' value='Add this coupon to your favorite coupons'></form></center><br>");
		}
		catch(IOException ioe) {
			ioe.printStackTrace();
		}
		}

		String couponTypeToSortBy = "All";
		boolean isButtonSortByLocationBeenPressed;
		boolean isButtonCouponTypeHasBeenPressed;
		List<Coupon> couponListToDisplay;
		Coupon coupon;	
		
	%>

	<% 
		if (request.getSession().getAttribute("sortedCouponsList") != null)
		{
			couponListToDisplay = (List<Coupon>) request.getSession().getAttribute("sortedCouponsList");
			isButtonSortByLocationBeenPressed = true;
		}
		else 
		{
			couponListToDisplay =  (List<Coupon>) Controller.getNonExpiredCoupons(); 
			isButtonSortByLocationBeenPressed = false;
		}
	
		if(request.getSession().getAttribute("couponTypeToSortBy") != null)
		{
			couponTypeToSortBy = request.getSession().getAttribute("couponTypeToSortBy").toString();
			isButtonCouponTypeHasBeenPressed = true;
		}
		else {
			couponTypeToSortBy = "All";
			isButtonCouponTypeHasBeenPressed = false;
		}
		
		Iterator<Coupon> i = couponListToDisplay.iterator();
		
		while (i.hasNext())
		{
			coupon = i.next();
			if (isButtonSortByLocationBeenPressed)
			{
				printCoupon(coupon, out);
				
			}
			else if (isButtonCouponTypeHasBeenPressed)
				{
					if (coupon.getCouponType().equals(couponTypeToSortBy))
					{
						printCoupon(coupon, out);

					}
					else if (couponTypeToSortBy.equals("All"))
					{
						printCoupon(coupon, out);

					}
				}
			 else
				{
					printCoupon(coupon, out);

				}
		}
		couponTypeToSortBy = "All";
		request.getSession().setAttribute("sortedCouponsList", null);
		request.getSession().setAttribute("couponTypeToSortBy", null);

%>

	<script>
function setLangCoordinate(langtitude){
	lang = langtitude;
	document.getElementById("getLang").value=getLangCoordinate();
	}
	function setLatCoordinate(latitude){
	lat = latitude;
	document.getElementById("getLat").value=getLatCoordinate();
	}

	function getLangCoordinate(){
		return lang;
		}
		function getLatCoordinate(){
		return lat;
		}

var geocoder;
var map;
var marker;

// initialise the google maps objects, and add listeners
function gmaps_init(){

  // center of the universe
  var latlng = new google.maps.LatLng(51.751724,-1.255284);

  var options = {
    zoom: 2,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  // create our map object
  map = new google.maps.Map(document.getElementById("gmaps-canvas"), options);

  // the geocoder object allows us to do latlng lookup based on address
  geocoder = new google.maps.Geocoder();

  // the marker shows us the position of the latest address
  marker = new google.maps.Marker({
    map: map,
    draggable: true
  });

  // event triggered when marker is dragged and dropped
  google.maps.event.addListener(marker, 'dragend', function() {
    geocode_lookup( 'latLng', marker.getPosition() );
  });

  // event triggered when map is clicked
  google.maps.event.addListener(map, 'click', function(event) {
    marker.setPosition(event.latLng)
    geocode_lookup( 'latLng', event.latLng  );
  });

  $('#gmaps-error').hide();
}

// move the marker to a new position, and center the map on it
function update_map( geometry ) {
  map.fitBounds( geometry.viewport )
  marker.setPosition( geometry.location )
}


// fill in the UI elements with new position data
function update_ui( address, latLng ) {
  $('#gmaps-input-address').autocomplete("close");
  $('#gmaps-input-address').val(address);
  $('#gmaps-output-latitude').html(latLng.lat());
  $('#gmaps-output-longitude').html(latLng.lng());
//  getDistanceFromLatLonInKm(latLng.lat(), latLng.lng(), 64, 58);
 setLatCoordinate(latLng.lat());
 setLangCoordinate(latLng.lng());
}

// Query the Google geocode object
//
// type: 'address' for search by address
//       'latLng'  for search by latLng (reverse lookup)
//
// value: search query
//
// update: should we update the map (center map and position marker)?
function geocode_lookup( type, value, update ) {
  // default value: update = false
  update = typeof update !== 'undefined' ? update : false;

  request = {};
  request[type] = value;

  geocoder.geocode(request, function(results, status) {
    $('#gmaps-error').html('');
    $('#gmaps-error').hide();
    if (status == google.maps.GeocoderStatus.OK) {
      // Google geocoding has succeeded!
      if (results[0]) {
        // Always update the UI elements with new location data
        update_ui( results[0].formatted_address,
                   results[0].geometry.location )

        // Only update the map (position marker and center map) if requested
        if( update ) { update_map( results[0].geometry ) }
      } else {
        // Geocoder status ok but no results!?
        $('#gmaps-error').html("Sorry, something went wrong. Try again!");
        $('#gmaps-error').show();
      }
    } else {
      // Google Geocoding has failed. Two common reasons:
      //   * Address not recognised (e.g. search for 'zxxzcxczxcx')
      //   * Location doesn't map to address (e.g. click in middle of Atlantic)

      if( type == 'address' ) {
        // User has typed in an address which we can't geocode to a location
        $('#gmaps-error').html("Sorry! We couldn't find " + value + ". Try a different search term, or click the map." );
        $('#gmaps-error').show();
      } else {
        // User has clicked or dragged marker to somewhere that Google can't do a reverse lookup for
        // In this case we display a warning, clear the address box, but fill in LatLng
        $('#gmaps-error').html("Woah... that's pretty remote! You're going to have to manually enter a place name." );
        $('#gmaps-error').show();
        update_ui('', value)
      }
    };
  });
};

// initialise the jqueryUI autocomplete element
function autocomplete_init() {
  $("#gmaps-input-address").autocomplete({

    // source is the list of input options shown in the autocomplete dropdown.
    // see documentation: http://jqueryui.com/demos/autocomplete/
    source: function(request,response) {

      // the geocode method takes an address or LatLng to search for
      // and a callback function which should process the results into
      // a format accepted by jqueryUI autocomplete
      geocoder.geocode( {'address': request.term }, function(results, status) {
        response($.map(results, function(item) {
          return {
            label: item.formatted_address, // appears in dropdown box
            value: item.formatted_address, // inserted into input element when selected
            geocode: item                  // all geocode data: used in select callback event
          }
        }));
      })
    },

    // event triggered when drop-down option selected
    select: function(event,ui){
      update_ui(  ui.item.value, ui.item.geocode.geometry.location )
      update_map( ui.item.geocode.geometry )
    }
  });

  // triggered when user presses a key in the address box
  $("#gmaps-input-address").bind('keydown', function(event) {
    if(event.keyCode == 13) {
      geocode_lookup( 'address', $('#gmaps-input-address').val(), true );

      // ensures dropdown disappears when enter is pressed
      $('#gmaps-input-address').autocomplete("disable")
    } else {
      // re-enable if previously disabled above
      $('#gmaps-input-address').autocomplete("enable")
    }
  });
}; // autocomplete_init

$(document).ready(function() { 
  if( $('#gmaps-canvas').length  ) {
    gmaps_init();
    autocomplete_init();
  }; 
});


</script>
</body>
</html>