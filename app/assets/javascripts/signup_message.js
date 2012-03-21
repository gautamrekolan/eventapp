$(function() {
	$("#signup_message").click(function() {
		window.location.href = $(this).find('a').attr('href');
	});
	
	$("#signup_message").mouseover(function() {
		//$(this).css("background-color" "#FFFFFF");
		$(this).addClass("over");
	});
	
	$("#signup_message").mouseout(function() {
		$(this).removeClass("over");
	});
})