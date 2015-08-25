// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery.turbolinks

$(document).ready(function(){

    
         $( ".project" ).each(function() {
            var x = 0;
            var y = 0;
            var stagewidth = 0;
            var progresswhitewidth = 0;
            var status = 0;

            $(this).find(".progressbar_space").each(function(){
                x++;
            });
            
            stagewidth = (90/x);
            $(this).find(".progressbar_space").css("width", stagewidth+"vw");
        
            $(this).find(".unfilled").each(function(){
               y++; 
            });
            
            
            status = 100-$(this).find(".status_num").text();
            progresswhitewidth = (stagewidth*y) + ((status/100)*stagewidth);
            $(this).find(".progress_white").css("width", progresswhitewidth+"vw");
         });
    });