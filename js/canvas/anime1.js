var img = new Image();

//User Variables
img.src = 'park.jpg';
var CanvasXSize = 800;
var CanvasYSize = 200;
var speed = 30; //lower is faster
var scale = 1.05;
var y = -4.5; //vertical offset
//End User Variables

var dx = 0.75;
var imgW = img.width*scale;
var imgH = img.height*scale;
var x = 0;
if (imgW > CanvasXSize) { x = CanvasXSize-imgW; } // image larger than canvas
var clearX;
var clearY;
if (imgW > CanvasXSize) { clearX = imgW; } // image larger than canvas
else { clearX = CanvasXSize; }
if (imgH > CanvasYSize) { clearY = imgH; } // image larger than canvas
else { clearY = CanvasYSize; }
var ctx;

function init() {
    //Get Canvas Element
    ctx = document.getElementById('canvas').getContext('2d');
    //Set Refresh Rate
    return setInterval(draw, speed);
}

function draw() {
    //Clear Canvas
    ctx.fillStyle = "#FFFF00";
    ctx.fill();
    return;
    //ctx.clearRect(0,0,clearX,clearY);
    //If image is <= Canvas Size
    if (imgW <= CanvasXSize) {
        //reset, start from beginning
        if (x > (CanvasXSize)) { x = 0; }
        //draw aditional image
        if (x > (CanvasXSize-imgW)) { ctx.drawImage(img,x-CanvasXSize+1,y,imgW,imgH); }
    }
    //If image is > Canvas Size
    else {
        //reset, start from beginning
        if (x > (CanvasXSize)) { x = CanvasXSize-imgW; }
        //draw aditional image
        if (x > (CanvasXSize-imgW)) { ctx.drawImage(img,x-imgW+1,y,imgW,imgH); }
    }
    //draw image
    ctx.drawImage(img,x,y,imgW,imgH);
    //amount to move
    x += dx;
}