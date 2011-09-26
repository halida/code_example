var ws = [];
var name = [];

function append(msg){
    $('#msgs').prepend(msg);
    $('#msgs').prepend('<br/>');    
}

function init(){
    name = $('#name').val();
    name = $.trim(name);
    if (! name) return;

    ws = new WebSocket("ws://localhost:9999/chatroom");  

    ws.onopen = function() {  
	ws.send("name: "+name);  
    };  
    ws.onmessage = function (e) {
	append(e.data); 
    };  
    ws.onclose = function() { append('closed')};  

    $('#name').attr('readonly', true);
    $('#set-name-btn').hide();

    $('#send-msg').show(200);
    $('#msg').focus();
}

function send(){
    var msg = $('#msg').val();
    ws.send(msg);
    $('#msg').val('');
}

$(function(){
	$('#name').focus();
    });


