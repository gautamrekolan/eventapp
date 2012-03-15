$(function() {
	$(".user_location_map .incorrect_city").click(function() {
		$(".user_location_map .title").toggle("fast");
		$(".search_city").toggle("fast");
	});
	
	$(".search_city .cancel").click(function() {
		$(".user_location_map .title").toggle("fast");
		$(".search_city").toggle("fast");
	});
})