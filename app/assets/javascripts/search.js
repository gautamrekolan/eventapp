$(function() {
	$(".search_container form input").keyup(function() {
		
		//check for down key
		//if down key is hit then the user is trying to select items below
		
		q = $(this).val();
		url = $(this).closest("form").attr("action");
		
		//hack
		url = url + ".json?query=" + q;
		
		$.get(url, function() { 
			//alert('get called')
			console.log("get search results ajax called");
		})
		.success(function(data, status, xhr) {
	        //console.log(data);
	
			//clear the previous results if any
			$("#search_bar_results").empty();
	
			populateEvents(data);
			populateUsers(data);
			populateVenues(data);
	    })
		.error(function() {
	        //TODO show some kind of error message
			//"this application doesn't MAKE errors"
	    });
	});
});

function populateUsers(data) {
	console.log(data);
	
	users = data.users;
	
	if(users && users.length > 0) {
		console.log("has users");
		console.log(users)
		links = "";
		for(var i = 0; i < users.length; i++) {
			u = users[i].user;
			links = "<a href=''>" + u.username + "</a>";
		}	
		appendGroup(links);
	} else {
		link = "<a href=''>no users</a>";
		$("#search_bar_results").append(link);
	}
	
}

function populateEvents(data) {
	events = data.events;
	
	if(events && events.length > 0) {
		links = "";
		for(var i = 0; i < events.length; i++) {
			if(events[i].event != null) {
				e = events[i].event;
				links += "<a href=''>" + e.name + "</a>";
			}
		}
		appendGroup(links);
	} else {
		link = "<a href=''>no events</a>";
		$("#search_bar_results").append(link);
	}
}

function populateVenues(data) {
	venues = data.places.response.venues;
	
	//if there are actually venues
	if (venues) {
		console.log(venues);
		console.log("venues count " + venues.length)
		links = "";
		for(var i = 0; i < venues.length; i++) {
			links += "<a href=''>" + venues[i].name + "</a>";
			appendGroup(links)
		}
	} else {
		link = "<a href=''>no places</a>";
		$("#search_bar_results").append(link);
	}
}

function appendGroup(linkStr, id) {
	// default value
	id = typeof id !== 'undefined' ? id : "";
	if (id == "") {
		html = "<div class='group'>";
	} else {
		html = "<div class='group' id='" + id + ">";
	}
	html += linkStr;
	html += "</div>";
	
	$("#search_bar_results").append(html);
	search = $(".search_container form input").position();
	console.log("top " + search.top + " left " + search.left);
	$("#search_bar_results").css({"top": "" + (search.top + 50) + "px", "left": "" + search.left + "px"});
}



