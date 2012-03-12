$(document).ready(function() {
	
	//listen for an ajax event after going link is clicked and updated
	$(".eventactionsbar .golink").bind('ajax:success', function(evt, data, status, xhr) {
		//alert(status);
		j = JSON.parse(xhr.responseText)
		$(this).text(j.message);
	});	
	
	$(".goinglink").bind('ajax:success', function(evt, data, status, xhr) {
		//alert(xhr.responseText);
		//j = JSON.parse(status)
		//alert(j.message);
	});
	
	/*
	$(".goinglink").fancybox({
		'hideOnContentClick': true
	});
	*/
})
