/*
 *= require jquery
 *= require jquery_ujs
 *= require jquery-ui
 *= require datepicker/jquery.datePicker
 *= require_self
 *= require_tree ../../../vendor/assets/javascripts/.
 *= require_tree .
 */

// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/* respond to event likes - this needs to find a better home, doubt it's good to keep in top level like this */

$(document).ready(function() {
	
	//console.log("doc ready");
	
	$(".notice").show("fadeIn");

	$('#new_event').bind('ajax:success', function(data, status, xhr) {
		alert("failure");
	});
	
	$('#new_event_button').click(function() {
		window.location.href = $(this).find('a').attr('href');
	});
	
	//call js geolocation/geolocation.js
	//initGeoLocate();
	
	//add some input validation
	//add regex function to validation
	$.validator.addMethod(
	        "regex",
	        function(value, element, regexp) {
	            var re = new RegExp(regexp);
	            return this.optional(element) || re.test(value);
	        }//,
	        //"Please enter valid characters..."
	);
	
	
	
	
	
	
	
	
	
	// TODO move functionality into page by page document ready functions if possible
	
	
	/* GOOGLE MAPS API */
	//initialize(); //inits google map
	
	/********** LIKE LINK - PROBABLY WON'T USE **************/
	
	/*
	$(".eventactionsbar .likelink").bind('ajax:success', function(data, status, xhr) {
		//alert(status);
		j = JSON.parse(status)
		$(this).text(j.message);
	});
	
	$(".eventactionsbar .unlike").bind('ajax:success', function(data, status, xhr) {
		$(this).text("hello");
	});
	*/
	/* GOING TO *********/
	
	/*
	$('#new_event').bind('ajax:success', function(data, status, xhr){
	  alert("Success!");
	});
	
	
	$(".eventactionsbar .goinglink").bind('ajax:success', function(data, status, xhr) {
		$(this).text();
	});
	*/
	
	/***** validating forms *********/
	//new event /events/new
	
	//show end date / time if they want
	
	$('.endtime_add a').click(function() {
		$(this).hide();
		$('.endtime_container').removeClass('hidden');
	});
	
	//add some custom methods to the validator
	//need only alphanumeric
	/*
	$.validator.addMethod("loginRegex", function(value, element) {
		return this.optional(element) || /^[a-z0-9]+$/i.test(value);
	}, "Username must contain only letters, numbers, or dashes.");
	
	//$('#new_event').validate();
	
	
	
	$('#new_event').validate({
		
		debug: true,
		ignore: ".ignore",
		
		rules: {
				'event_name' : {
						required: true,
						maxlength: 5,
						loginRegex: true
				}
		},
		
		messages: {
			'event_name' : {
				required: "event name is required",
				maxlength: "username must be at least 5 characters long",
				logingRegex: "must be letters and numbers only"
			}
		},
		/*
		highlight: function (element, errorClass) {                
			$(element).parent().find('label').css({ "background-color": "#FF0000" });
        },

		unhighlight: function (element, errorClass) {
			$(element).parent().find('label').css({ "background-color": "#DFDFDF" });                
		},
		submitHandler: function() {
			console.log("submitHandler " + $('#new_event').valid());
		},
	
		errorPlacement: function(error, element) {
			console.log("error " + error.message + " element " + element);
		},
		
		
		invalidHandler: function(form, validator) {
		  var errors = validator.numberOfInvalids();
		  console.log("errors " + errors);
	      if (errors) {
	        var message = errors == 1
	          ? 'You missed 1 field. It has been highlighted'
	          : 'You missed ' + errors + ' fields. They have been highlighted';
	        $("div.error span").html(message);
	        $("div.error").show();
	      } else {
	        $("div.error").hide();
			console.log("no errors");
	      }
	    }	
	});
	*/
	
});



/************ EVENT COMMENTS ********************/



/************ CREATE NEW EVENTS DATE PICKER ***************/





