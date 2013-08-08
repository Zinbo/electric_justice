
ready = ->
  $(".uncheck_all").on "click", ->
    $div = $(@).closest('div[class=\"tab-pane active\"]')
    $("div[id="+ $div.attr("id") + "] input[type=\"checkbox\"]").prop('checked', false)
    
  $(".check_all").on "click", ->
    $div = $(@).closest('div[class=\"tab-pane active\"]')
    $("div[id="+ $div.attr("id") + "] input[type=\"checkbox\"]").prop('checked', true)
    
  $('tr[data-link] td:not(:has(:checkbox))').click ->
    $tr = $(@).closest('tr')
    window.location = $tr.data("link")


$(document).ready ready
$(document).on "page:load", ready