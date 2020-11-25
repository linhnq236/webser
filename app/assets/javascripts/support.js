$( document ).on('turbolinks:load', function() {
  $(".content, .formCreateNotify").on('change keyup keydown paste cut', 'textarea', function () {
    $(this).height(0).height(this.scrollHeight);
  }).find('textarea').change();

  $('textarea').each(function () {
    this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
  }).on('input', function () {
    this.style.height = 'auto';
    this.style.height = (this.scrollHeight) + 'px';
  });
  // multi chosen
  $(".chosen-select").chosen({no_results_text: "Not found "});

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
  $("#searchled").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#tableledshow tr ").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
  $("#search_room").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#list_search_room div").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
  // background navbar selected
  var array_class = ['dashboard', 'dashboard', 'rooms', 'services', 'informations', 'accounts', 'reminders', 'statisticals', 'rentals', 'setting', 'apps','apps', 'contact'];
  var array_url = ['/', '/home', '/houses', '/services', '/users', '/account', '/reminders', '/statisticals', '/paytherents', '/users/edit', '/apps', '/regulations', '/send_email'];
  var url = $(location).attr("pathname");
  if (array_url.indexOf(url) != -1) {
    var position = array_url.indexOf(url);
    var class_menu = array_class[position];
    $(`.${class_menu}`).css({'background': 'repeating-linear-gradient(11deg, black, transparent 123px)'})
  }
  $('input[name=backgroundColor]').minicolors();
  $('input[name=textcolor]').minicolors();

  // colspase
  $(".apps").click(function(){
    $id_app = $(this).data('apps');
    $($id_app).slideToggle();
  })
  $(".settings").click(function(){
    $id_setting = $(this).data('setting');
    $($id_setting).slideToggle();
  })
  $(".room_max").on('change keyup keydown paste cut', function(){
    var result = $(this).val();
    if (result < 0) {
      $(".notice_result").html("<small class='text-danger'>The value should not be less than 0 *</small>");
      $(".save").addClass('disabled');
    }else{
      $(".notice_result").html("");
      $(".save").removeClass('disabled');
    }
  })
  $("#LanguageDropdown").click(function(){
    $(".dropdown-flags").slideToggle();
  })
})
