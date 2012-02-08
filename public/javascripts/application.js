// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* respond to event likes - this needs to find a better home, doubt it's good to keep in top level like this */
$(document).ready(function() {
	
	/********** LIKE LINK - PROBABLY WON'T USE **************/
	
	$(".eventactionsbar .likelink").bind('ajax:success', function(data, status, xhr) {
		//alert(status);
		j = JSON.parse(status)
		$(this).text(j.message);
	});
	
	$(".eventactionsbar .unlike").bind('ajax:success', function(data, status, xhr) {
		$(this).text("hello");
	});
	
	/* GOING TO *********/
	
	$(".eventactionsbar .golink").bind('ajax:success', function(data, status, xhr) {
		//alert(status);
		j = JSON.parse(status)
		$(this).text(j.message);
	});
	
	/*
	$(".eventactionsbar .goinglink").bind('ajax:success', function(data, status, xhr) {
		$(this).text();
	});
	*/
	
	//http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js
	//setTimeout (initTimepicker,3000);
	$('#event_starttime').datetimepicker();
	$('#event_endtime').datetimepicker();
});



/************ EVENT COMMENTS ********************/



/************ CREATE NEW EVENTS DATE PICKER ***************/





