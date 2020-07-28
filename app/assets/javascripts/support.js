$( document ).on('turbolinks:load', function() {
  $(".content").on('change keyup keydown paste cut', 'textarea', function () {
    $(this).height(0).height(this.scrollHeight);
  }).find('textarea').change();
  // multi chosen
   $(".chosen-select").chosen({no_results_text: "Không tìm thấy "});
})
