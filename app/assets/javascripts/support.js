$( document ).on('turbolinks:load', function() {
  $(".content, .formCreateNotify").on('change keyup keydown paste cut', 'textarea', function () {
    $(this).height(0).height(this.scrollHeight);
  }).find('textarea').change();

  // multi chosen
  $(".chosen-select").chosen({no_results_text: "Không tìm thấy "});

   // Seach column
  $("#search").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#user tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
  $("#searchaccount").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#account tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
  $("#search_paytherent").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#paytherent tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
  $("#searchuseservice").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#useservice tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
  $("#searchNotify").on("keyup", function() {
    // var value = $(this).val().toLowerCase();
    // $(".notify-content").filter(function() {
    //   $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    // });
  });

  // var first = [0];
  // var second = [0];
  // var third = [];
  var com_name = [];
  var html_voice_control_led = '';
  $.each(gon.rooms, function(index, value){
    $.each([0,3,5,6,7,8], function(index1,value1){
      html_voice_control_led += `
        <div class='col-sm-2'>Phong${value['name']}: ${value['house_id']}${value['name']}${value1}</div>
        <hr>
      `;
    })

    $(".voice_control_led").html(
      `
        <div class='row'>
          ${html_voice_control_led}
        </div>
      `
    );
    var string = '';
    $.each([0,3,5,6,7,8], function(index1,value1){
      $.each([0,1], function(index2,value2){
        string = `${value["house_id"]+value['name']}`+value1+value2;
        com_name.push(string);
      })
    })
  });
  var array_name_code_reading = [];
  for (var i = 0; i < com_name.length; i += 2) {
    array_name_code_reading.push(com_name[i]);
  }
  $(".column_leds").each(function(index = 0){

    $(this).addClass(`column_${index++}`);
  $( `.column_${index}`).append(`${array_name_code_reading[index]}`);
  })
  // voice support
  $(".voice").click(function(){
    var set_mic = $(this).data('set_mic');
    if (set_mic == 0) {
      localStorage.setItem("setmic", "1");
      $('.voice').addClass('bg-primary');
      $('.voice').removeClass('bg-dark');
    } else {
      localStorage.removeItem('setmic');
    }
    autovoice();
  })
  // auto call function autovoice
  if (localStorage.getItem('setmic') == 1) {
    $('.voice').attr('data-set_mic', '1');
    console.log(localStorage.getItem('setmic'));
    autovoice();
  }else{
    $('.voice').removeClass('bg-primary');
    $('.voice').addClass('bg-dark');
  }
  // auto control voice
  function autovoice(){
    var ses = new webkitSpeechRecognition();
    ses.interimResults = false;
    ses.maxAlternatives = 1;
    ses.continuous = true;
    ses.interimResults = true;
    ses.onresult = function(e){
      if (event.results.length > 0) {
        sonuc = event.results[event.results.length -1];
        if (sonuc.isFinal) {
          var result = sonuc[0].transcript;
          $(".listening").attr('value', result);
          var listening = $(".listening").val();
          redirect_to(listening);
        }
      }
    }
    ses.start();
  }

  function  redirect_to (name){
    if (name == 'home' || name == "Home") {
      window.location.href = `/${name}`;
    } else if(name == 'information' || name == 'Information') {
      window.location.href = `/users`;
    } else if(name == 'account' || name == 'Account') {
        window.location.href = `/${name}`;
    } else if(name == 'services' || name == 'Services') {
        window.location.href = `/${name}`;
    } else if(name == 'reminders' || name == 'Reminders') {
        window.location.href = `/${name}`;
    } else if(name == 'houses' || name == 'Houses') {
        window.location.href = `/${name}`;
    } else if(find_name_into_com_name(name) != -1) {
        updateVoice(name);
    }  else if(name == 'cancel' || name == 'Cancel') {
        localStorage.removeItem('setmic');
        location.reload();
    } else{
      location.reload();
    }
  }
  // 1101: 1: house_name, 1: room_name, 0: LED_STATUS0, 1: on/off
  function find_name_into_com_name(name){
    var a = com_name.indexOf(name);
    return a;
  }

  function updateVoice(name){
    // status: room_name
    $.ajax({
      type: 'post',
      url: "/voice",
      data: {name: name},
      success: function(rep) {
        location.reload();
      },
      error: function(rep) {
        console.log(rep);
      }
    })
  }
  function deduplicate(arr) {
    return arr.filter((value, index, arr) => arr.indexOf(value) === index);
  }
})
