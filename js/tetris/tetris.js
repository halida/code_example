const FPS = 3;
var canvas = null;
var ctx = null;

var width = 8;
var height = 20;
var hide_h = 4;
var SIZE = 20;

//game status
var STATUS_DESC = ['init', 'start', 'pause', 'game over'];
var INIT = 0;
var START = 1;
var PAUSE = 2;
var GAME_OVER = 3;

var BODYS = [
             [[0, 0], [0, 1], [1, 0], [1, 1]],
             [[0, 0], [0, 1], [0, 2], [0, 3]],
             ];

var status = INIT;
var data = [];
var count = 0;
var body = null;
var body_color = null;
var turn = 0;

window.onload = init;

function init()
{
    var c = $('#canvas');
    c.attr('width', width*SIZE);
    c.attr('height', height*SIZE);

    canvas = document.getElementById('canvas');
    ctx = canvas.getContext('2d');

    //prepare data
    for (var i=0; i<height; i++){
        var row = new Array();
        for (var j=0; j<width; j++){
            row.push(0);
        }
        data.push(row);
    }

    setInterval(update, 1000 / FPS);
}

function start_game(){
    status = START;
    body = new_body();

    //clean data
    for (var i=0; i<height; i++){
        for (var j=0; j<width; j++){
            data[i][j] = 0;
        }};
}

function new_body(){
    var i = Math.floor(Math.random() * BODYS.length);
    var b = BODYS[i];
    var new_body = [];
    for (var i=0; i<b.length; i++) {
        var pos = [b[i][0] + width/2, b[i][1]];
        new_body.push(pos);
    };
    body_color = random_color();
    return new_body;
};

function get_next_move(body, x, y){
    var m = [];
    for (var i=0; i<body.length; i++) {
        var pos = [body[i][0]+x, body[i][1]+y];
        m.push(pos);
    };
    return m;
};

function check_hit(body){
    for (var i=0; i<body.length; i++){
        var pos = body[i];
        var x = pos[0];
        var y = pos[1];
        if (0>x || x>=width || 0>y || y>=height) return true;
        if (data[y][x] != 0){
            return true;
        };
    };
    return false;
};

function leave_body(body){
    for (var i=0; i<body.length; i++) {
        var pos = body[i];
        var x = pos[0];
        var y = pos[1];
        data[y][x] = body_color;
    };

    // check clean level
    var cleans = [];
    for (var i=0; i<body.length; i++) {
	var y = body[i][1];
	var row = data[y];

	var full = true;
	for (var i=0; i<row.length; i++){
	    if (row[i] == 0) {
		full = false;
		break;
	    }
	}
	if (full){
	    cleans.push(y);
	};
    }
    // move cleans
    alert(cleans);
}

function random_color(){
    return Math.ceil(Math.random()* 256 * 256 * 256);
}

function update(){
    if (status != START) return;

    // turn
    if (turn == 0){
    } else if (turn == 2) {
	// down
	while (true) {
	    var next_move = get_next_move(body, 0, 1);	
	    if (check_hit(next_move)) break;
	    body = next_move;
	};
	turn = 0;
    } else {
	var next_move = get_next_move(body, turn, 0);
	turn = 0;
	if (!check_hit(next_move)){
	    body = next_move;
	};
    }

    var next_move = get_next_move(body, 0, 1);
    if (check_hit(next_move)) {
        leave_body(body);
        body = new_body();
        if (check_hit(body)){
            game_over();
        };
    } else {
        body = next_move;
    };

    draw();
}

function game_over(){
    status = GAME_OVER;
};

function draw()
{
    // status
    $('#status').text(STATUS_DESC[status]);
    // clear
    ctx.fillStyle = "#eeeeee";
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // draw scene
    for (var i=0; i<height; i++){
        for (var j=0; j<width; j++){
            var color = data[i][j];
            if (color == 0) continue;
            ctx.fillStyle = color2text(color);
            ctx.fillRect(j*SIZE, i*SIZE, SIZE, SIZE);
        }
    }

    // draw body
    ctx.fillStyle = color2text(body_color);
    for (var i=0; i<body.length; i++) {
        var pos = body[i];
        ctx.fillRect(pos[0]*SIZE, pos[1]*SIZE,
                     SIZE, SIZE);        
    };


}

function color2text(color){
    var r = Math.floor((color / 256) / 256);
    var g = Math.floor((color / 256) % 256);
    var b = Math.floor((color % 256));
    return "#" + r.toString(16) + g.toString(16) + b.toString(16);
};

function turnto(d){
    turn = d;
};