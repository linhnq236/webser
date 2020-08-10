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
  $("#searchNotify").on("keyup", function() {
    // var value = $(this).val().toLowerCase();
    // $(".notify-content").filter(function() {
    //   $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    // });
  });
})
