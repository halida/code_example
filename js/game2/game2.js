window.onload = init;

function init()
{
    const FPS = 30;

    var canvas = document.getElementById('canvas');
    canvas.width = screen.width - 200;
    canvas.height = screen.height - 200;
    var ctx = canvas.getContext('2d');

    var SNOW_SIZE = 4;

    //snows
    var snows = [];
    for(i=0; i<100; i++){
	snows.push([Math.random() * canvas.width,
		    Math.random() * canvas.height,
		    ]);
    };

    function draw()
    {
	ctx.fillStyle = "black";
	ctx.fillRect(0, 0, canvas.width, canvas.height);

	ctx.fillStyle = "white";
	$.each(snows, function(index, pos){
		var x = pos[0];
		var y = pos[1];
		// draw
		ctx.fillRect(x, y, SNOW_SIZE, SNOW_SIZE);
		// move
		y = (y + 50.0/FPS) % canvas.height;
		pos[1] = y;
		
	    });
    }

    setInterval(draw, 1000 / FPS);
}