$( document ).on('turbolinks:load', function() {
  var html = '';
  if (gon.user == 0) {
    return false;
  }
  setInterval(autoget(), 1000);
  function autoget(){
    $.each(gon.leds, function(index, value){
      var i = 0;
      i++;
      html += `
      <div class="col-sm-6">${index}</div>
      ${loadArea(value, index)}
      `
    })
    $(".firebase_led").append(html);
    // removeClass .led
    $(".ledKhu").each(function(){
      var status = $(this).data("area");
      if (status == "Khu") {
        console.log();
        $(this).removeClass("led");
      }
    })
    $(".led").click(function(){
      var status = $(this).data("status");
      var active = $(this).text();
      var area = $(this).data("area");
      var column = $(this).data("column");
      var subcolumn = $(this).data("subcolumn");
      if (subcolumn == "TURNON" || subcolumn == "TURNOFF") {
        setTime(status,area, column, subcolumn);
      }else {
        api_led_status(status,active,area, column, subcolumn);
      }
    })
  }

  function loadArea(arr, area){
    var html = '';
    $.each(arr, function(index, value){
      $.each(value, function(ind, val){
        $.each(val, function(ind1, val1){
          html += `
          <div class="row">
            <div class="col-sm-3">${index}</div>
            <div class="col-sm-3">${ind}</div>
            <div class="col-sm-3">${ind1}</div>
            <div class="col-sm-3">
            <button class="col-sm-12 led led${area} led_turn${ind} cursor" data-areapin="${area+index+ind+ind1}" data-area="${area}" data-status = "${index}" data-column="${ind}" data-subcolumn="${ind1}">${val1}</button>
            </div>
            <hr>
          </div>
          `
        })
      })
    })
  	return html;
  }

  function api_led_status(status,active, area, column, subcolumn){
    if(active == "ON"){
      setactive = "OFF";
    }else{
      setactive = "ON";
    }
    $.ajax({
      type: 'post',
      url: "/updatestatus",
      data: {status: status, active: setactive, area: area, column: column, subcolumn: subcolumn},
      success: function(rep) {
        // console.log(rep);
        // location.reload();
      },
      error: function(rep) {
        // console.log(rep);
      }
    })
  }
  // SETTIME
  function setTime(status, area, column, subcolumn){
    $.confirm({
      title: "SETTIME",
      // columnClass: 'col-md-5 col-md-offset-4',
      closeIcon: true,
      content: '' +
      "<form action='' class='formName'>" +
      '<div class="form-group">' +
      '<input type="datetime-local" class="settime form-control" required />' +
      '</div>' +
      '</form>',
      buttons: {
          formSubmit: {
            text: 'Submit',
            btnClass: 'btn-blue',
            action: function () {
            var settime = this.$content.find('.settime').val();
            resettime = settime.replace("T", " ");
            $.ajax({
                type: 'post',
                url: "/settime",
                data: {
                  settime: resettime,
                  status: status,
                  area: area,
                  column: column,
                  subcolumn: subcolumn,
                },
                success: function(repsonse) {
                  console.log("Set timer is successfully.")
                },
                error: function(repsonse) {
                  console.log("Set timer on is fails.")
                }
              })
            }
          },
          cancel: function () {
              //close
          }
      }
    })
  }
})
