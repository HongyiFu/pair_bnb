// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', function(){
	$('form#new_listing').on('submit',function(event){
		event.preventDefault();
		// debugger;
		$.ajax({
			url: '/listings',
			type: 'POST',
			data: {ajax_data:$(this).serializeArray()},
			dataType: 'json',
			success: function(result) {
				alert(result)
				console.log(result);
				console.log("im in success");
				// debugger
				$('form#new_listing').before("<p>"+result+"</p>")
			},
			complete: function() {
				$('form#new_listing input:disabled').removeAttr('disabled')
			}
		});
	});
});
