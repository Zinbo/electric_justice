# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $("#container").length != 0
    $("#container").highcharts
      chart:
        type: "column"
  
      title:
        text: gon.poll.question
  
      xAxis:
        title: "Answers"
        categories: gon.answers
  
      yAxis:
        allowDecimals: false
        title:
          text: "Responses"
  
      series: [
        name: "Responses"
        data: gon.no_of_responses
      ]

$ ->
  if $(".older_charts").length != 0
    $(".older_charts").each (index) ->
      $(this).highcharts
        chart:
          type: "column"
    
        title:
          text: gon.polls[index].question
    
        xAxis:
          title: "Answers"
          categories: gon.list_of_answers[index]
    
        yAxis:
          allowDecimals: false
          title:
            text: "Responses"
    
        series: [
          name: "Responses"
          data: gon.list_of_no_of_responses[index]
        ]
      

$ ->
  remove_fields = (link) ->
    $(link).prev("input[type=hidden]").val "1"
    $(link).closest(".fields").hide()

$ ->
  add_fields = (link, content) ->
    new_id = new Date().getTime()
    regexp = new RegExp("new_" + Answer, "g")
    $(link).parent().before content.replace(regexp, new_id)
    
