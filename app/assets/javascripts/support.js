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

  // voice support
  $(".voice").click(function(){
    autovoice();
  })
  // auto call function autovoice
  autovoice();
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
      }
    else{
      location.reload();
    }
  }
})
