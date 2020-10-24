$( document ).on('turbolinks:load', function() {
  var html = '';
  if (gon.user == 0) {
    localStorage.removeItem('setmic');
    return false;
  }
  setInterval(autoget(), 1000);
  function autoget(){
    $.each(gon.leds, function(index, value){
      var i = 0;
      i++;
      html += `
      <div class="col-sm-6 first ${index}"  data-first="${index}"><i class='fa fa-university text-success'></i> ${index}</div>
      ${loadArea(value, index)}
      `
    })
    $(".firebase_led").append(html);
    // removeClass .led
    $(".ledKhu").each(function(){
      var status = $(this).data("area");
      if (status == "Khu") {
        $(this).removeClass("led");
      }
    })
    $(".led").click(function(){
      var status = $(this).data("status");
      var active = $(this).text();
      var area = $(this).data("area");
      var column = $(this).data("column");
      var subcolumn = $(this).data("subcolumn");
      if (subcolumn == "turnon" || subcolumn == "turnoff") {
        setTime(status,area, column, subcolumn);
      }else {
        api_led_status(status,active,area, column, subcolumn);
      }
    })
  }

  function loadArea(arr, area){
    var html = '';
    var mark = 0;
    $.each(arr, function(index, value){
      $.each(value, function(ind, val){
        $.each(val, function(ind1, val1){
          mark ++;
          html += `
          <div class="row column_leds position-relative ${area}">
            <div class="col-sm-3 second_${mark}" data-second="${index}">${index}</div>
            <div class="col-sm-3 third_${mark}" data-third="${ind}">${I18n.t(`js.home.${ind}`)}</div>
            <div class="col-sm-3">${ind1}</div>
            <div class="col-sm-3 chip_${index+ind}">
            <button class="col-sm-12 led led${area} ${area+index+ind+ind1} led_turn${ind} cursor ${val1 == 'on' ? 'bg-danger': 'bg-primary'}" data-areapin="${area+index+ind+ind1}" data-area="${area}" data-status = "${index}" data-column="${ind}" data-subcolumn="${ind1}">${val1}</button>
            </div>
          </div>
          `
        })
        html += `<hr class="${area}">`;
      })
    })
  	return html;
  }

  function api_led_status(status,active, area, column, subcolumn){
    if(active == "on"){
      setactive = "off";
    }else{
      setactive = "on";
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
                  // location.reload();
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

  // click show notify
  var height = $(window).height();
  $(".show_reminder").css({"height": `auto`, "max-height":`${height}px`})
  $(".notify").click(function(){
    $(".show_report").hide();
    $(".show_reminder").slideToggle({direction: 'right'})
  })
  $(".show_report").css({"height": `auto`, "max-height":`${height}px`})
  $(".feedback").click(function(){
    $(".show_reminder").hide();
    $(".show_report").slideToggle({direction: 'right'})
  })
  // click guid_voice
  $(".check_guild").click(function(){
    $(".guid_voice").slideToggle();
  })
  // $(".column_leds").find("div").css({'display': 'none'});
  for (var i = 1; i < $(".column_leds").length; i += 3) {
    $(`.second_${i}`).text("");
    $(`.third_${i}`).text("");
  }
  for (var j = 3; j < $(".column_leds").length; j += 3) {
    $(`.second_${j}`).text("");
    $(`.third_${j}`).text("");
  }
  var html_button_house_with_room = '';
  $.each(gon.houses, function(index, value){
    html_button_house_with_room += `
      <button class="house_name" data-house_name="${value['name']}">${value['name']}</button>
    `;
  })
  $(".button_house_with_room").html(html_button_house_with_room);
  $(".house_name").click(function(){
    var house_name = $(this).data("house_name");
    var house_name_uppercase = house_name.toUpperCase();
    var house_name_remove_space = house_name_uppercase.replace(/\s+/g, '');
    // $(`.${house_name_remove_space}`).css({"display":'none'});
    $(`.${house_name_remove_space}`).slideToggle();

  })
    $(".first").each(function(){
      var id = $(this).data("first");
      if (gon.house_name != id) {
        $(`.${id}`).css({"display": "none"});
      }
    })
})
