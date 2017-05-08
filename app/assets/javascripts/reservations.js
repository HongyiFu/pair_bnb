// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
	$('.unhide-button').click(function(){
		var newItem = $('.multi-date-field').clone().addClass('clone').removeClass('multi-date-field').fadeIn();
		newItem.appendTo($('#for-append'))
	});
});