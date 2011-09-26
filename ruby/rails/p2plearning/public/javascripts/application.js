// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function hideNotice(){
    $(".notice").html("");
    $(".alert").html("");
}

function init(){
    //ignore notice
    alert($("p.notice").html());
    var v = $("p.notice").html();
    if (v) {
	setTimeout('hideNotice();', 3000);
    }
}
