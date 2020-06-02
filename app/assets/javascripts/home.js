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
      $(".led").click(function(){
        var status = $(this).data("status");
        var active = $(this).text();
        var area = $(this).data("area");
        api_led_status(status,active,area);
      })
    },
    error: function(rep) {
    }
  })
  function loadArea(arr, area){
    var html = '';
    $.each(arr, function(index, value){
      html += `
        <div class="row">
  	    	<div class="col-sm-6">${index}</div>
  	    	<div class="col-sm-6">
            <button class="col-sm-6 led led${area} cursor" data-areapin="${area+index}" data-area="${area}" data-status = "${index}">${value}</button>
          </div>
        </div>
      `
    })
  	return html;
  }

  function api_led_status(status,active, area){
    if(active == "ON"){
      setactive = "OFF";
    }else{
      setactive = "ON";
    }
    $.ajax({
      type: 'post',
      url: "/updatestatus",
      data: {status: status, active: setactive, area: area},
      success: function(rep) {
        // console.log(rep);
        // location.reload();
      },
      error: function(rep) {
        // console.log(rep);
      }
    })
  }
})
