$( document ).on('turbolinks:load', function() {
  if(gon.user == 0){
    return false;
  }
  setInterval(tmp, 3000);
  function tmp(){
    $.ajax({
      type: 'get',
      url: "/gettemperature",
      success: function(rep) {
        var temp = rep["data"]["Khu"]["WEATHER"]["TEMPERATURE"];
        $(".led_turnTEMPERATURE").text(temp);
      },
      error: function(rep) {
        // console.log(rep);
      }
    })
  }
})
