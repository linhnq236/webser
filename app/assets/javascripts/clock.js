$( document ).on('turbolinks:load', function() {
  var start = new Date;
  getdate();
  function getdate(){
     var today = new Date();
     var h = today.getHours();
     var m = today.getMinutes();
     var s = today.getSeconds();
     var d = today.getDay();
     var mt = today.getMonth();
     var y = today.getFullYear();
      if(s<10){
        s = "0"+s;
      }
      if (m < 10) {
        m = "0" + m;
      }
      if(d<10){
        d = "0"+d;
      }
      if (mt < 10) {
        mt = "0" + mt;
      }

     $(".led_turnDATETIME").text(y + "-" + mt + "-" + d + " " + h + " : " + m +" : " + s);
      setTimeout(function(){getdate()}, 500);
   }
})
