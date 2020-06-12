$( document ).on('turbolinks:load', function() {
  if(gon.user == 0){
    return false;
  }
  var rep = gon.tmp;
  setInterval(tmp, 3000);
  function tmp(){
    var temp = rep["Khu"]["WEATHER"]["TEMPERATURE"];
    $(".led_turnTEMPERATURE").text(temp);
  }
})
