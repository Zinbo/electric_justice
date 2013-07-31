# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  remove_fields = (link) ->
    $(link).prev("input[type=hidden]").val "1"
    $(link).closest(".fields").hide()

$ ->
  add_fields = (link, content) ->
    new_id = new Date().getTime()
    regexp = new RegExp("new_" + Answer, "g")
    $(link).parent().before content.replace(regexp, new_id)