$(document).ready(function() {
	$(".loggedin_user_menu").mouseover(function() {
		//show the options
		//console.log("logged in mouse over")
		$(".loggedin_user_menu ul").show();
	});
	
	$(".loggedin_user_menu").mouseout(function() {
		//show the options
		//console.log("logged in mouse over")
		$(".loggedin_user_menu ul").hide();
	});
})
