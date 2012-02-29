var gl;
 
function displayPosition(position) {
  var geoLocateDiv = document.getElementById("geolocation_container");
  geoLocateDiv.innerHTML = "<table border='1'><tr><th>Timestamp</th><td>" + position.timestamp +
  "<tr><th>Latitude (WGS84)</th><td>" + position.coords.latitude + " deg</td></tr>" +
  "<tr><th>Longitude (WGS84)</th><td>" + position.coords.longitude + " deg</td></tr></table>";
}

function showMap() {
	$("#geolocation_container").html();
}
 
function displayError(positionError) {
  alert("error");
}

function initGeoLocate() {
	console.log("called initGeoLocate")
	try {
	  if (typeof navigator.geolocation === 'undefined'){
	    gl = google.gears.factory.create('beta.geolocation');
	  } else {
	    gl = navigator.geolocation;
	  }
	} catch(e) {}

	if (gl) {
	  gl.getCurrentPosition(showMap, displayError); //used to call displayPosition instead of showMap
	} else {
	  alert("Geolocation services are not supported by your web browser.");
	}	
}
