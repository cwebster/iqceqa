# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#iqc_expirydate').datetimepicker
    dateFormat: 'yy-mm-dd'
   
jQuery ->
  $('#iqc_dateinuse').datetimepicker
	    dateFormat: 'yy-mm-dd'
	
jQuery ->
  $('#iqc_datereconstituted').datetimepicker
	    dateFormat: 'yy-mm-dd'