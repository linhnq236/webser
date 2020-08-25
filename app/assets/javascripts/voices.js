$( document ).on('turbolinks:load', function() {
  document.addEventListener("keypress", function(e) {
    if (e.keyCode === 122) {
      toggleFullScreen();
    }
  }, false);
  function toggleFullScreen() {
    if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen();
    } else {
      if (document.exitFullscreen) {
        document.exitFullscreen();
      }
    }
  }
  // redirect_to using voice
  var redirect_name = [
    I18n.t('js.redirects.home'),I18n.t('js.redirects.dashboard'),I18n.t('js.redirects.rooms'),
    I18n.t('js.redirects.services'),I18n.t('js.redirects.informations'),I18n.t('js.redirects.accounts'),
    I18n.t('js.redirects.reminders'),I18n.t('js.redirects.statisticals'),I18n.t('js.redirects.rentals'),
    I18n.t('js.redirects.logout'),I18n.t('js.redirects.email'),I18n.t('js.redirects.all')
  ];
  var redirect_to_with_redirect_name = [
                                        'home', 'home', 'houses', 'services', 'users', 'account',
                                        'reminders', 'statisticals', 'paytherents', 'users/sign_out',
                                         'send_email', 'reports'
                                       ];
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
    $(this).addClass(`column_${index+=1}`);
  })
  // voice support
  $(".voice").click(function(){
    var set_mic = $(this).data('set_mic');
    if (set_mic == 0) {
      localStorage.setItem("setmic", "1");
      $('.voice').addClass('bg-primary');
      $('.voice').removeClass('bg-dark');
      $(".listening").removeClass("d-none");
      $(".listening").attr("disabled", "disabled");
      $(".listening").css("background", "#f3f3f3 !important");
      $(".listening").addClass("text-danger font-weight-bold");
      autovoice();
    } else {
      localStorage.removeItem('setmic');
      $(".listening").addClass("d-none");
      $('.voice').addClass('bg-dark');
      $(".listening").addClass("d-none");
      $(".result_voice").css("display","none");
      location.reload();
    }
  })
  // auto call function autovoice
  if (localStorage.getItem('setmic') == 1) {
    $('.voice').attr('data-set_mic', '1');
    $(".listening").removeClass("d-none");
    $(".listening").attr("disabled", "disabled");
    $(".listening").css("background", "#f3f3f3 !important");
    $(".listening").addClass("text-danger font-weight-bold");
    autovoice();
  }else{
    $('.voice').removeClass('bg-primary');
    $('.voice').addClass('bg-dark');
    $(".listening").addClass("d-none");
    $(".result_voice").css("display","block");
  }

  // click event using voice
  var select_voice = ['notify', 'feedback'];

  // auto control voice
  function autovoice(){
    var ses = new webkitSpeechRecognition();
    ses.interimResults = true;
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
    if (find_redirect_name(name) != -1){
      var position_redirect_name = find_redirect_name(name);
      window.location.href = `/${redirect_to_with_redirect_name[position_redirect_name]}`;
    } else if(find_name_into_com_name(name) != -1) {
        updateVoice(name);
    } else if(find_name_into_select_voice(name) != -1){
      var class_voice = select_voice[find_name_into_select_voice(name)];
      $(`.${class_voice}`).trigger('click');
      autovoice();
    } else if(name == 'cancel' || name == 'Cancel') {
        localStorage.removeItem('setmic');
        location.reload();
    } else{
      $(".result_voice").css("display","block");
      $(".result_voice").html(`Not found ${name}`);
      autovoice();
    }
  }

  // 1101: 1: house_name, 1: room_name, 0: LED_STATUS0, 1: on/off
  function find_redirect_name(name){
    var position_redirect_name = redirect_name.indexOf(name);
    return position_redirect_name;
  }
  function find_name_into_com_name(name){
    var position_name = com_name.indexOf(name);
    return position_name;
  }

  function find_name_into_select_voice(name){
    var position_name = select_voice.indexOf(name);
    return position_name;
  }

  function updateVoice(name){
    // status: room_name
    $.ajax({
      type: 'post',
      url: "/voice",
      data: {name: name},
      success: function(rep) {
        // location.reload();
        autovoice();
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
