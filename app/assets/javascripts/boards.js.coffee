# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$('a#toggle-new-post').click (event) ->
		if $(this).text() == 'Create new post'
			$(this).text('Cancel new post')
		else if $(this).text() == 'Cancel new post'
			$(this).text('Create new post')
		$('a#toggle-new-post').toggleClass('btn-primary btn-default')
		$('div#new-post').fadeToggle 'fast', 'linear'
		event.preventDefault()                        # Prevent default link action
