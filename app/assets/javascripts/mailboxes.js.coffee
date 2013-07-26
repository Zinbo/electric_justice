$ ->
  $('tr[data-link] td:not(:has(:checkbox))').click ->
    $tr = $(@).closest('tr')
    window.location = $tr.data("link")
$ ->
  $(".check_all").on "click", ->
    $div = $(@).closest('div[class=\"tab-pane active\"]')
    $("div[id="+ $div.attr("id") + "] input[type=\"checkbox\"]").prop('checked', true)
    
$ ->
  $(".uncheck_all").on "click", ->
    $div = $(@).closest('div[class=\"tab-pane active\"]')
    $("div[id="+ $div.attr("id") + "] input[type=\"checkbox\"]").prop('checked', false)
