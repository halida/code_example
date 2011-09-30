window.init_index = ()->
  return
  fit = ()->
    the_panel = $('#the-panel')
    the_panel.width(window.innerWidth * 0.8)
    the_panel.height(window.innerheight * 0.8)
  window.onresize = fit()

window.longPullSite = "http://blog.linjunhalida.com:8110"
window.longPullSite = "http://localhost:8110"

window.press_the_button = ()->
  data = 
    url : longPullSite + "/press"
    type: "POST"
    crossDomain: true
  $.ajax data

window.updater = 
  errorSleepTime: 500
  poll: ()->
    data =
      url: longPullSite + "/number"
      type: "POST"
      crossDomain: true
      success: updater.onSuccess
      error: updater.onError
    $.ajax data

  onSuccess: (response)->
    try
      $('#the-number').html(response)
    catch e
      updater.onError()
      return
    updater.errorSleepTime = 500
    window.setTimeout(updater.poll, 1000)

  onError: (response)->
    updater.errorSleepTime *= 2
    console.log("Poll error; sleeping for", updater.errorSleepTime, "ms")
    window.setTimeout(updater.poll, updater.errorSleepTime)


    