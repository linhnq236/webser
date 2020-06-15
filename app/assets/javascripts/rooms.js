$( document ).on('turbolinks:load', function() {
  $(".blockquoteroom").first().css({"box-shadow":"7px 4px 8px -1px rgba(87,143,240,1)"});
  $(".blockquoteroom").click(function(){
    var inf_click = $(this).data("inf");
    $(".blockquoteroom").each(function(){
      var inf = $(this).data("inf");
      if (inf_click == inf) {
        $(this).first().css({"box-shadow":"7px 4px 8px -1px rgba(87,143,240,1)"});
      } else {
        $(this).first().removeAttr("style");
      }
    })
  })
})
