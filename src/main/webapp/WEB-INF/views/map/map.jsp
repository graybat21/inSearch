<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>   
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="http://code.google.com/apis/maps/documentation/javascript/examples/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDAZo3REaAB8Ev8AhAsaaB3XgKVTrrA8Es&&libraries=places&sensor=false"></script>   
<script type="text/javascript">
var geocoder;  
var map;  
var marker;
var markers = [];
var myCity;
var infowindow;
  
function initialize() {
    geocoder = new google.maps.Geocoder(); 
    
    var latlng = new google.maps.LatLng(37.5662952, 126.97794509999994);  
    var myOptions = {  
        zoom: 15,  
        center: latlng,  
        mapTypeId: google.maps.MapTypeId.ROADMAP  
    }  
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
}

google.maps.event.addDomListener(window, 'load', initialize);
  
function codeAddress(){  
    var address = document.getElementById("address").value;  
    var category = document.getElementById("category").value;  
    var radius = document.getElementById("radius").value;  
    var r = document.getElementById("r");  
	
    if ( category == '' ) {
		alert("카테고리를 선택하세요.");
		return;
	}
    else if ( radius == '' ) {
    	alert("거리 반경을 선택하세요.");
		return;
    }
	
    r.innerHTML = '';  
      
    geocoder.geocode({  
        'address': address  
    }, function(results, status){
        if (status == google.maps.GeocoderStatus.OK) { 
            // map.setCenter(results[0].geometry.location);  
            // addMark(results[0].geometry.location.lat(), results[0].geometry.location.lng());  
                          
            for(var i in results){  
                //r.innerHTML += results[i].formatted_address+',';  
                var li = document.createElement('li');  
                var a = document.createElement('a');  
                // addMark(results[i].geometry.location.lat(), results[i].geometry.location.lng());  

                a.href = "javascript:moveMark(" + results[i].geometry.location.lat() 
                		+ ", " + results[i].geometry.location.lng() + ", '" + category + "', " + radius + ");";  
                a.innerHTML = results[i].formatted_address;  
   
                li.appendChild(a);  
                r.appendChild(li);  
            }             
        } else {  
            r.innerHTML = "검색 결과가 없습니다."+status;              
        }  
    });  
}  
  
function addMark(lat, lng){
    if ( typeof marker != 'undefined' ) {  
        marker.setMap(null);  
    }  
    
    marker = new google.maps.Marker({  
        map: map,  
        position: new google.maps.LatLng(lat, lng)  
    });
}

function moveMark(lat, lng, cat, rad) {
    if ( typeof myCity != 'undefined' ) {  
        myCity.setMap(null);
    }
    
    map.setCenter(new google.maps.LatLng(lat, lng));
    addMark(lat, lng);
    var place = {lat: lat, lng: lng};

    myCity = new google.maps.Circle({
        center: place,
        radius: rad,
        strokeColor:"#0000FF",
        strokeOpacity:0.8,
        strokeWeight:2,
        fillColor:"#0000FF",
        fillOpacity:0.4
    });
        
    myCity.setMap(map);
    infowindow = new google.maps.InfoWindow();

    var service = new google.maps.places.PlacesService(map);
    service.nearbySearch({
        location: place,
        radius: rad,
        type: [cat]
    }, callback);
}
    
function callback(results, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
    	var placeEach = document.getElementById("place_each");  
    	placeEach.innerHTML = '';  
        
    	if ( markers.length > 0 ) {
            removeMarkers();
        }

        markers = [];
        
        for ( var i in results ) {
            createMarker(results[i]);
            
            var li = document.createElement('li');
        	var a = document.createElement('a'); 
        	
            a.href = "/map/placeDetail.do?placeId=" + results[i].place_id;  
		    a.innerHTML = results[i].name;
		    li.appendChild(a);  
		    placeEach.appendChild(li);  
        }
    }
}

function createMarkerListener(marker) {
    google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent('<a href="placeDetail.do?placeId=' + marker.placeId + '" target="_blank">' + marker.placeName + '</a>');
        infowindow.open(map, this);    
    });
}

function createMarker(place) { 
    var placeLoc = place.geometry.location;
    var latitude = placeLoc.lat();          // 위도
    var longitude = placeLoc.lng();         // 경도
    console.log(place.place_id);

    var marker = new google.maps.Marker({
        map: map,
        position: placeLoc,
        placeName: place.name,
        placeId: place.place_id
    });
    createMarkerListener(marker);
    markers.push(marker);
}

function removeMarkers(){
    for ( i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }
}

</script>   
<div id="map" style="height: 1000px">   
<div>   
	<form method="get">
		<select name="category" id="category">
			<option selected value="">분류 선택</option>
			<option value="cafe">카페</option>
			<option value="store">상점</option>
			<option value="library">도서관</option>
			<option value="shopping_mall">쇼핑몰</option>
			<option value="restaurant">식당</option>
		</select>
	    <select name="radius" id="radius">
			<option selected value="">반경 선택</option>
			<option value="100">100</option>
			<option value="200">200</option>
			<option value="500">500</option>
		</select>
	    <input name="address" id="address" type="text" value="Seoul City Hall">   
	    <input type="button" value="검색" onclick="codeAddress()">
	</form> 
</div>   
<div id="r"></div>    
<div id="map_canvas" style="height:50%;margin-top:30px"></div>
<div id="place_each" style="margin-top: 30px"></div>   
</div>   

