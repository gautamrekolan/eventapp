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

	$('[data-validate]').keypress(function() {
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
					this.element(element); 
					//console.log('fuck you');
				}, 
		
		rules: {
				"user[firstname]" : {
						required: true,
						minlength: 5,
						maxlength: 15
						//loginRegex: true
				},
				
				last_name : {
						required: true,
						maxlength: 15,
						min: 5
						//loginRegex: true
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