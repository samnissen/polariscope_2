# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ->
  jQuery('#hideshow').on 'click', (event) ->
    jQuery('#outer-scroll').toggle 'show'
    return
  return