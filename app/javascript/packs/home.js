$( document ).on('turbolinks:load', function() {
  var html = '';
  $.ajax({
      type: 'GET',
      url: "/led_status",
      success: function(rep) {
        var i = 0;
        $.each(rep["data"], function(index, value){
          i++;
          html += `
          <div class="col-sm-6">${index}</div>
          <button class="col-sm-6 led cursor" data-status = "${index}" data-active="${value}">${value}</button>

          `
        })
        $(".firebase_led").append(html);
        $(".led").click(function(){
          var status = $(this).data("status");
          var active = $(this).data("active");
          api_led_status(status,active);
        })
      },
      error: function(rep) {
      }
  })
  function api_led_status(status,active){
    if(active == "ON"){
      setactive = "OFF";
    }else{
      setactive = "ON";
    }
    $.ajax({
      type: 'post',
      url: "/updatestatus",
      data: {status: status, active: setactive},
      success: function(rep) {
        // console.log(rep);
        location.reload();
      },
      error: function(rep) {
        // console.log(rep);
      }
    })
  }
})
