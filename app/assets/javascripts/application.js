// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


function setActive(name) {
    $("#" + name).addClass("active");
}

$(document).ready(
    function(){
        $(".repost_button")
            .bind("ajax:beforeSend",function(){
                $("#repostBody").html("<p>loading...</p>");
            })
            .bind("ajax:complete", function(evt, data, status, xhr){
                $("#repostBody").html(data.responseText);
            }
        );
        $(".repost_button").click(function(event){
            event.preventDefault();
            $(this).addClass("disabled");
            $(this).text("Reposted");
            $(this).siblings().remove();
        });
    }
);
