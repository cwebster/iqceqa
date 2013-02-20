# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#iqc_expirydate').datepicker
    dateFormat: 'yy-mm-dd'
   
jQuery ->
  $('#iqc_dateinuse').datepicker
	    dateFormat: 'yy-mm-dd'
	
jQuery ->
  $('#iqc_datereconstituted').datepicker
	    dateFormat: 'yy-mm-dd'