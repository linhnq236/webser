$( document ).on('turbolinks:load', function() {
  var html = '';
  $.ajax({
      type: 'GET',
      url: "/led_status",
      success: function(rep) {
	  $.each(rep["data"], function(index, value){
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
        if (column == "TURNON" || column == "TURNOFF") {
          setTime(status,area, column);
        }else {
          api_led_status(status,active,area, column);
        }
      })

    },
    error: function(rep) {
    }
  })
  function loadArea(arr, area){
    var html = '';
    $.each(arr, function(index, value){
      $.each(value, function(ind, val){
        html += `
        <div class="row">
        <div class="col-sm-4">${index}</div>
        <div class="col-sm-4">${ind}</div>
        <div class="col-sm-4">
        <button class="col-sm-12 led led${area} led_turn${ind} cursor" data-areapin="${area+index+ind}" data-area="${area}" data-status = "${index}" data-column="${ind}">${val}</button>
        </div>
        </div>
        `
      })
    })
  	return html;
  }

  function api_led_status(status,active, area, column){
    if(active == "ON"){
      setactive = "OFF";
    }else{
      setactive = "ON";
    }
    $.ajax({
      type: 'post',
      url: "/updatestatus",
      data: {status: status, active: setactive, area: area, column: column},
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
  function setTime(status, area, column){
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
                  column: column
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
