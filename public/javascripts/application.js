// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* respond to event likes - this needs to find a better home, doubt it's good to keep in top level like this */
$(document).ready(function() {
	$(".eventactionsbar .likelink").bind('ajax:success', function() {
		$(this).text("you like it!");
	});

	$(".eventactionsbar .unlike").bind('ajax:success', function() {
		$(this).text("like");
	});
	
});


