/* validations for user signup */

$(function() {
	
	//focus on first input in form
    
	// user name
	$('[data-validate]').blur(function() {
        $this = $(this);
        $.get($this.data('validate'), {
            user: $this.val()
        }).success(function() {
            $this.removeClass('field_with_errors');
        }).error(function() {
            $this.addClass('field_with_errors');
        });
    });

	$('[data-validate]').keyup(function() {
        $this = $(this);
        $.get($this.data('validate'), {
            user: $this.val()
        }).success(function() {
            $this.removeClass('field_with_errors');
        }).error(function() {
            $this.addClass('field_with_errors');
        });
    });

	$('#new_user').validate({
		
		debug: true,
		ignore: ".ignore",
		//onfocusout: ,
		onkeyup: function(element) { 
					//http://whilefalse.net/2011/01/17/jquery-validation-onkeyup/
					//http://groups.google.com/group/jquery-en/browse_thread/thread/eae7eb51e6c7c03f?pli=1
					//kind of a hack, not really sure how this works
					this.element(element); 
					//console.log('fuck you');
				}, 
		
		rules: {
				"user[firstname]" : {
						required: true,
						minlength: 1,
						maxlength: 15,
						regex: /^[a-z ,.'-]+$/i
						//loginRegex: true
				},
				
				"user[lastname]" : {
						required: true,
						maxlength: 15,
						minlength: 1,
						regex: /^[a-z ,.'-]+$/i
						//loginRegex: true
				},
				
				"user[username]" : {
					required: true,
					minlength: 1,
					maxlength: 15,
					regex: /[a-z0-9_]+/i
				},
				
				"user[email]" : {
					required: true,
					regex: /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i
				},
				
				"user[password]" : {
					required: true,
					minlength: 5,
					maxlength: 20
				},
				
				//zips
				"user[zip]" : {
					required: true,
					//us zips only
					//TODO possibly add canada and other regions later
					regex: /^\d{5}(-\d{4})?$/
				}
				
		},
		
		messages: {
			"user[firstname]" : {
				required: "first name is required",
				minlength: "firstname should be 2 or more characters",
				maxlength: "username should be less than 15 characters"
				//logingRegex: "must be letters and numbers only"
			},
			
			"user[lastname]" : {
				required: "last name is required",
				minlength: "last name should be 2 or more characters",
				maxlength: "last name should be less than 15 characters"
				//logingRegex: "must be letters and numbers only"
			},
			
			"user[username]" : {
				required: "username is required",
				minlength: 1,
				maxlength: 15,
			},
			
			"user[email]" : {
				required: "Email is required",
				regex: "Please enter a valid email"
			},
			
			"user[password]" : {
				required: "please enter a password",
				minlength: "too short, must be at least 5 characters",
				maxlength: "password is too long, don't go over 20 characters"
			},
			
			"user[zip]" : {
				required: "Please enter a zip code",
				regex: "Please enter a valid US zip"
			}
		},
		
		highlight: function (element, errorClass) {                
			//$(element).parent().find('label').css({ "background-color": "#FF0000" });
			$(element).parent().find(".message").addClass("error");
			$(element).parent().find(".message").removeClass("valid");
        },

		unhighlight: function (element, errorClass) {
			$(element).parent().find(".message").removeClass("error");//css({ "background-color": "#DFDFDF" });  
			$(element).parent().find(".message").addClass("valid");              
		},
		/*
		submitHandler: function() {
			console.log("submitHandler " + $('#new_event').valid());
		},
		*/
		
		errorPlacement: function(error, element) {
			console.log("error " + error + " element " + element.attr("name"));
			//hide any other potential messages
			//element.parent().find(".message .suggestion_message").addClass("hide");
			error.insertAfter(element.parent().find(".message .suggestion_message"));
			//.html(error);
			//.html("" + error.message);
		},
		
		
		
		/*
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
		*/
		
	});

});