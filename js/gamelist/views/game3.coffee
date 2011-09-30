window.onload = ()->
  canvas = document.getElementById('canvas')
  ctx = canvas.getContext('2d')
  msg = $('#msg')
  
  status_list = ['start', 'running', 'finish']
  STATUS_START = 0
  STATUS_RUNNING = 1
  STATUS_FINISH = 2
  PC = 1
  CP = 2
  
  SIZE = 100
  USER_COLOR = 
    0: "#222222"
    1: "green"
    2: "red"
  
  status = 0
  turn = 0
  board = []
  
  draw = ()->
    ctx.fillStyle = USER_COLOR[0]
    ctx.fillRect(0, 0, canvas.width, canvas.height)
  
    for i in [0..8]
      x = i % 3
      y = Math.floor(i / 3)
      ctx.fillStyle = USER_COLOR[board[i]]
      ctx.fillRect(x*SIZE, y*SIZE, SIZE, SIZE)
  
  onClick = (e)->
    return if status != STATUS_RUNNING
  
    x = Math.floor(e.offsetX / SIZE)
    y = Math.floor(e.offsetY / SIZE)
    pos = x + y * 3
    return if pos > 8 or pos < 0
    return if board[pos] != 0
    board[pos] = PC
  
    result = check_result()
    process_result(result)
    ai_step()
    draw()

  process_result = (result)->
    if result == PC
      msg.html("pc win!")
      status = STATUS_FINISH
    else if result == CP
      msg.html("computer win!")
      status = STATUS_FINISH

  
  check_result = ()->
    for i in [0..2]
      if board[i*3] == board[i*3 + 1] == board[i*3 + 2]
        return board[i*3] if board[i*3] != 0

    for i in [0..2]
      if board[i] == board[i + 3] == board[i + 6]
        return board[i] if board[i] != 0
   
    if board[0] == board[4] == board[8]
      return board[4] if board[4] != 0
    if board[2] == board[4] == board[6]
      return board[4] if board[4] != 0

  ai_step = ()->
    return if status != STATUS_RUNNING
    # random step
    for i in [0..100]
      s = Math.floor (Math.random() * 9)
      break if board[s] == 0
    board[s] = CP
    process_result check_result()
  
  window.restart = ()->
    msg.html("please click the board")
    status = 1
    board = [
      0,0,0
      0,0,0
      0,0,0
    ]

    #$('#pc-first').attr("checked", "yes");
    ai_step() unless $('#pc-first').attr("checked")
    draw()

  restart()
  canvas.addEventListener("click", onClick, false)
