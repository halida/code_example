var canvas = $("#canvas")[0];
var debug = $("div#debug");
var ctx = canvas.getContext("2d");
var DIRS = [[-1, 0], [0, -1], [1, 0], [0, 1],
	    [-1, -1], [-1, +1], [+1, -1], [+1, +1]];

function v2h(n){
    return (n[0]<<10) + n[1];
}
function h2v(n){
    return [n>>10, n & (1024-1)];
}

function show(wall, w, h, a, b) {
    // 计算
    result = astar(wall, w, h, a, b);
    opens = result[0];
    closes = result[1];
    var P = result[2];
    var F = result[3];
    var G = result[4];
    var H = result[5];

    vtext = "";
    $.each(G, function(k,v){
	    vtext += "key:" + k + " value:" + v;
	});
    debug.text("?: "+vtext);

    SIZE = 50;
    canvas.setAttribute('width', SIZE * w);
    canvas.setAttribute('height', SIZE * h);

    // 根据结果绘图
    function draw(p) {
	p = h2v(p);
	x = p[0] * SIZE;
	y = p[1] * SIZE;
	ctx.fillRect(x, y, SIZE, SIZE);
    }
    // 背景
    ctx.fillStyle = "#000000";
    ctx.fillRect(0, 0, SIZE*w, SIZE*h);
    //ctx.fillRect(0, 0, 1000, 1000);//ctx.width, ctx.height);
    // 绘制点
    ctx.fillStyle = "#00FF00";
    $.each(opens, function(){draw(this);});
    ctx.fillStyle = "#0000FF";
    $.each(closes, function(){draw(this);});
    ctx.fillStyle = '#808080';
    $.each(wall, function(){draw(this);});
    // path
    p = v2h(b);
    ctx.fillStyle = "#FF0000";
    while (p != null) {
	draw(p);
	p = P[p];
    }
    // a and b
    ctx.fillStyle = "#FFFF00";
    draw(a);
    ctx.fillStyle = "#00FFFF";
    draw(b);

    // values
        // font = pygame.font.SysFont('sans', 8)
        // for n, v in F.iteritems():
        //     sur = font.render(str(v), True, (0,0,0))
        //     screen.blit(
        //         sur, (n[0]*SIZE+3, n[1]*SIZE+3))
        // for n, v in G.iteritems():
        //     sur = font.render(str(v), True, (0,0,0))
        //     screen.blit(
        //         sur, (n[0]*SIZE+3, n[1]*SIZE+40))
        // for n, v in H.iteritems():
        //     sur = font.render(str(v), True, (0,0,0))
        //     screen.blit(
        //         sur, (n[0]*SIZE+35, n[1]*SIZE+40))
        
        
    // parents
    ctx.fillStyle = "#000000";
    $.each(P, function(k,v){
	    k = h2v(k);
	    v = h2v(v);
            if (!v) return;
            d = k[0] - v[0], k[1] - v[1];
	    ctx.moveTo(k[0]*SIZE + SIZE/2,
		       k[1]*SIZE + SIZE/2);
	    ctx.lineTo(k[0]*SIZE + SIZE/2 - d[0]*SIZE/2,
		       k[1]*SIZE + SIZE/2 - d[1]*SIZE/2);
	    ctx.fillRect(k[0]*SIZE + SIZE/4,
			 k[1]*SIZE + SIZE/4,
			 SIZE/2, SIZE/2);
	})
}

function astar(wall, w, h, a, b){
    function checkin(n, list){
	$.each(list, function(){
		if (this[0] == n[0] &&
		    this[1] == n[1])
		    return true;
	    });
	return false;
    }

    var opens = [];
    var closes = [];
    var F = {};
    var G = {};
    var H = {};
    // point to parent
    var P = {};

    // init
    var hb = v2h(b);
    var current = v2h(a);
    var vc = a;
    opens.push(current);
    G[current] = 0;
    H[current] = 0;
    F[current] = 0;
    P[current] = null;

    // loop
    while (current != hb) {
        // close current
	vc = h2v(current);
	var index = opens.indexOf(current);
	alert(opens.length);
	opens.slice(index, 1);
	alert(opens.length);
	closes.push(current);

        // check nears
	nears = [];
	$.each(DIRS, function(){
		c = h2v(current);
		n = [c[0] + this[0],
		     c[1] + this[1]];
		// remove out of the map
		if (n[0] < 0 || n[0] >= w ||
		    n[1] < 0 || n[1] >= h)
		    return;
		nears.push(v2h(n));
	    });
        costs = [10, 10, 10, 10, 14, 14, 14, 14];

	for (i=0; i<nears.length; i++) {
	    n = nears[i];
            cost = costs[i];
            // remove wall
	    if (wall.indexOf(n)>=0) continue;
            // remove closed
	    if (closes.indexOf(n)>=0) continue;
            // check near then current
            if (opens.indexOf(n)>=0) {
                // check new value
                if (G[n] > G[current] + cost) {
                    G[n] = G[current] + cost;
                    F[n] = G[n] + H[n];
                    P[n] = current;
		}
                continue;
	    }
            // init to opens
            opens.push(n);
            G[n] = G[current] + cost;
            // 核心的关系函数, 改动后影响搜索方式
	    vn = h2v(n);
            H[n] = (Math.abs(b[0] - vn[0]) + 
		    Math.abs(b[1] - vn[1])) *10;
            F[n] = G[n] + H[n];
            P[n] = current;
	}
        // next
	if (opens.length <= 0) break;
	min = -1;
	$.each(opens, function(){
		if (min == -1 ||
		    F[this] < F[min]) {
		    min = n;
		};
	    });
        current = min;
    }
    return [opens, closes, P, F, G, H];
}

$(function(){
    $.ajaxSetup({cache: false});
    w = 30;
    h = 15;
    wall = [];
    for (i=6; i<30; i+=5) {
	for (j=0; j<10; j++) {
	    v = (i % 2)? h - j - 1 : j;
	    wall.push([i, v]);
	}
    }
    show(wall, w, h, [5, 5], [25, 10]);
})
