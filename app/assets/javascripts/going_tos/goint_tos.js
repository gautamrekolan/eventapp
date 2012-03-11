$(document).ready(function() {
	
	//listen for an ajax event after going link is clicked and updated
	$(".eventactionsbar .golink").bind('ajax:success', function(data, status, xhr) {
		//alert(status);
		j = JSON.parse(status)
		$(this).text(j.message);
	});	
	
	$(".goinglink").bind('ajax:success', function(data, status, xhr) {
		alert(status);
		j = JSON.parse(status)
		alert(j.message);
	});
	
	/*
	$(".goinglink").fancybox({
		'hideOnContentClick': true
	});
	*/
})
