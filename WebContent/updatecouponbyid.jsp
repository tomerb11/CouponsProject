<%@page import="sun.net.www.content.audio.x_aiff"%>
<%@ page import="il.ac.hit.coupons.dao.imp.MySqlDao"%>
<%@ page import="il.ac.hit.coupons.dto.Coupon"%>
<%@ page import="il.ac.hit.coupons.controller.Controller"%>
<%@ page import="il.ac.hit.coupons.exception.CouponException"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
 <link type="text/css" href="../styles/jquery-ui/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

  <!-- google maps -->
  <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&language=en"></script>

  <!-- jquery -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

  <!-- jquery UI -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>
  
  <script type="text/javascript" src="../js/calcdist.js"></script>
 <script src="//code.jquery.com/jquery-1.10.2.js"></script>
 <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <link rel="stylesheet" type="text/css" href="../css/jquery.timeentry.css"> 
<script type="text/javascript" src="../js/jquery.plugin.js"></script> 
<script type="text/javascript" src="../js/jquery.timeentry.js"></script>
 <%
if(request.getSession().getAttribute("userAdmin") == null)
{
	out.println("Unauthorized access to page");
	response.setHeader("Refresh", "3; URL=/Coupons");
}
else{
	%>
 
<script>
  $(function() {
    $( "#datepicker" ).datepicker();
  });
  </script>
<title>Update coupon</title>
</head>
<body>
<script>
var lang;
var lat;
</script>


<%!
int id;
String name;
String description;
String couponType;
int availableAmount;
java.util.Date expireDate;
String expireTime;
Double discountPercentage;
Double originalPrice;
String location;%>
<%
    // This is a scriptlet.  Notice that the "date"
    // variable we declare here is available in the
    // embedded expression later on.
    ArrayList<Coupon> couponsArrayList = null;
	Iterator<Coupon> i;
	Coupon tempCoupon;
    
    try {
    	couponsArrayList = (ArrayList<Coupon>) MySqlDao.getInstance().getCoupons();
	} 
	catch (CouponException cnfe) {
		cnfe.printStackTrace();
	}
	    
	    tempCoupon = null;
		Iterator<Coupon> r = couponsArrayList.iterator();

		while(r.hasNext()) {

			tempCoupon = r.next();
			if(tempCoupon.getId() == Integer.parseInt(request.getAttribute("couponIdToUpdate").toString())) {
				break;
			}
		}
	
		id = tempCoupon.getId();
		name = tempCoupon.getName();
		description = tempCoupon.getDescription();
		couponType = tempCoupon.getCouponType();
		expireDate = tempCoupon.getExpireDate();
		expireTime = tempCoupon.getExpireTime();
		availableAmount = tempCoupon.getAvailableAmount();
		discountPercentage = tempCoupon.getDiscountPercentage();
		originalPrice = tempCoupon.getOriginalPrice();
		location = tempCoupon.getLocation();

%>

<form id="updateCouponById" class="form-horizontal" method="post" action="couponhasbeenupdated">
 <div class="control-group">
    <label class="control-label" for="id"></label>
    <div class="controls">
      <input type="hidden" name="couponIdToUpdate" id="couponIdToUpdate" value="<%=id%>" >
    </div>
  </div> 
  <br>
  <div class="control-group">
    <label class="control-label" for="Coupon Name">Coupon Name</label>
    <div class="controls">
      <input type="text" name="name" value="<%=name%>" id="name">
    </div>
  </div>
  <br>
  <div class="control-group">
    <label class="control-label" for="couponType">Coupon Type</label>
    <div class="controls">
     <select name="couponType" size="3">
  <option selected value="Restaurants">Restaurants</option>
  <option value="Clothing">Clothing</option>
  <option value="Electricity">Electricity</option> 
  <option value="Vacation">Vacation</option> 
</select>
    </div>
  </div>
  <br>
   <div class="control-group">
    <label class="control-label" for="expireDate">Expire date</label>
    <div class="controls">
      <input type="date" value="<%=expireDate %>" id="datepicker" name="expireDate" min="2015-01-19" max="2016-12-31">
    </div>
    
    
           <div class="control-group">
    <label class="control-label" for="expireDate">Expire time</label>
    <div class="controls">
   <!--  <script>$(defaultEntry).timeEntry({show24Hours: true, showSeconds: true});</script> -->
      <input type="text" id="defaultEntry" name="expireTime" value="<%=expireTime%>">
    </div>
    </div>
        <script>$(defaultEntry).timeEntry({show24Hours: true, showSeconds: true}).change(function() { 
    var log = $('#log'); 
    log.val(log.val() + ($('#defaultEntry').val() || 'blank') + '\n'); 
});
</script>
    
    <br>
     <div class="control-group">
    <label class="control-label" for="Description"> Description</label>
    <div class="controls">
      <textarea style="overflow:auto; resize:none" name="description" rows="5" cols="19"><%=description%></textarea>
    </div>
    <br>
       <div class="control-group">
    <label class="control-label">City</label><br>
      <input type="text" name="location" id="gmaps-input-address" value="<%=location%>">
      <div id='gmaps-error'></div>
    <div id='gmaps-canvas'></div>
    </div>

  <br>
   <div class="control-group">
    <label class="control-label" for="availableAmount">Amount Of available coupons</label>
    <div class="controls">
      <input type="number" min="1" id="availableAmount" value="<%=availableAmount%>"  name="availableAmount" placeholder="Amount Of Avilable Coupons"">
    </div>
    <br>
  </div>
  
    <div class="control-group">
    <label class="control-label" for="originialPrice">Originial Price</label>
    <div class="controls">
      <input type="number" min="1" step="any" class="form-control" name="originalPrice" id="originalPrice" value="<%=originalPrice%>" placeholder="Originial Price">
    </div>
    <br>
     <div class="control-group">
    <label class="control-label" for="discountPrecentage">Discount Percentage</label>
    <div class="controls">
      <input type="number" min="1" step="any" name="discountPercentage" id="discountPercentage" value="<%=discountPercentage%>" placeholder="After Discuont Price">
    </div>
    <br>
  </div>
  </div>
    </div>
      <button type="submit" class="btn">Update coupon</button>
    </div>
    <input id="getLat" type='hidden' name='lat'/>
  <input id="getLang" type='hidden' name='lang'/>
</form>

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
<%} %>
</body>
</html>