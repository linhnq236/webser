$( document ).on('turbolinks:load', function() {
  setInterval(tmp, 100);
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
