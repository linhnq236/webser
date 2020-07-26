$( document ).on('turbolinks:load', function() {
  $(".blockquoteroom").first().css({"box-shadow":"7px 4px 8px -1px rgba(87,143,240,1)"});
  $(".blockquoteroom").click(function(){
    var inf_click = $(this).data("inf");
    $(".blockquoteroom").each(function(){
      var inf = $(this).data("inf");
      var service = $(this).data("service");
      if (inf_click == inf) {
        $(`#${service}_${inf}`).removeClass("d-none");
        $(this).first().css({"box-shadow":"7px 4px 8px -1px rgba(87,143,240,1)"});
      } else {
        $(`#${service}_${inf}`).addClass("d-none");
        $(this).first().removeAttr("style");
      }
    })
  })
  // services must regist
  $(".must").click(function(){
    if (confirm("Dịch vụ này là bắt buộc")) {
      return false;
    }
  })
})
