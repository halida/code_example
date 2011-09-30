window.onload = ()->
  FPS = 30

  canvas = document.getElementById('canvas')
  canvas.width = screen.width - 200
  canvas.height = screen.height - 200
  ctx = canvas.getContext('2d')

  SNOW_SIZE = 4

  snows = []
  for i in [0, 100]
    snows.push([Math.random() * canvas.width, Math.random() * canvas.height])

  draw = ()->
    ctx.fillStyle = "black"
    ctx.fillRect(0, 0, canvas.width, canvas.height)

    ctx.fillStyle = "white"
    $.each snows, (index, pos)->
      x = pos[0]
      y = pos[1]
      ctx.fillRect(x, y, SNOW_SIZE, SNOW_SIZE)
      y = (y + 50.0/FPS) % canvas.height
      pos[1] = y

  setInterval(draw, 1000 / FPS)
