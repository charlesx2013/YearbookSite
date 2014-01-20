# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('a').click ->
    $('html, body').animate({
        scrollTop: $( $.attr(this, 'href') ).offset().top
    }, 1000)
    return false

  #responive sections

  $(window).resize ->
    test = $(".sampleClass").css("float")
    circles = ['#circle-1', '#circle-2', '#circle-3','#circle-4']
    switch test
      when "right"
        #about section
        $('#about-content').removeClass().addClass("row")
        $("#about-content-container").removeClass().addClass('small-8 columns')
        $("#about-text").removeClass()
        $('#about-picture-align').removeClass().addClass("small-3 offset-small-1 columns")
        $("#about-circle").removeClass()

        # buy section
        $('#countdown').addClass("row") unless $('#countdown').hasClass("row")
        circles.forEach (circle, index) ->
          $("#{circle}-cont").removeClass().addClass('small-3 column')
          $(circle).removeClass()

      when "left" 
        #about section
        $('#about-content').removeClass("row")
        $('#about-content-container').removeClass().addClass('row')
        $('#about-text').removeClass().addClass('small-12 small-centered columns')
        $('#about-picture-align').removeClass().addClass("row")
        $("#about-circle").removeClass().addClass("small-12 small-centered columns")

        #buy section
        $('#countdown').removeClass("row") 
        circles.forEach (circle,index) ->
          $("#{circle}-cont").removeClass().addClass('row')
          $(circle).removeClass().addClass("small-12 small-centered columns circle-padding")
      else
        return true

  #countdown timer

  CUML_DAYS_IN_A_MONTH = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365]
  deadline = { year: 2014, month: 3, day: 28, hour: 0, minute: 0, second: 0 }
  getDate = ->
    date= new Date()
    return { 
            year: date.getFullYear() 
            month: date.getMonth() + 1
            day: date.getDate()
            hour: date.getHours()
            minute: date.getMinutes()
            second: date.getSeconds()
          }
  
  convertToSeconds = (date) ->
    yearSec = date.year * 31557600
    monthSec= CUML_DAYS_IN_A_MONTH[date.month-1] * 86400
    daySec= date.day *86400
    hourSec= date.hour * 3600
    minuteSec= date.minute * 60
    return yearSec + monthSec + daySec + hourSec + minuteSec + date.second 
    
  getAmt = (sec1, sec2) ->
    num = Math.floor sec1/sec2
    left = sec1 % sec2
    return [num, left]
  
  count = (now, deadline) ->
    if deadline is now or now > deadline
      return true
    else
      secsLeft = deadline - now
      [days, secsLeft] = getAmt secsLeft, 86400
      [hours, secsLeft] = getAmt secsLeft, 3600
      [minutes, secsLeft] = getAmt secsLeft, 60
      seconds = secsLeft
      $("#days").text(days)
      $('#hr').text(hours)
      $('#min').text(minutes)
      return $("#sec").text(seconds)

  setInterval (->
    count convertToSeconds(getDate()), convertToSeconds(deadline)
  ), 1000



  


ORBIT_OPTIONS = {animation: "fade", bullets: false, timer: true, variable_height: true, slide_number: false } 
$(document).foundation 'orbit', ORBIT_OPTIONS 
