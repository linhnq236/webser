$( document ).on('turbolinks:load', function() {
  $(".enableacc").click(function(){
    var user_id = $(this).data("user_id");
    $.ajax({
      type: "post",
      url: "/api/active_acc/"+user_id,
      data: {
         active: 0
      },
      success: function(res){
        console.log(res);
      },
      error: function(res){
        console.log(res);
      }
    })
  })
  $(".disableacc").click(function(){
    var user_id = $(this).data("user_id");
    $.ajax({
      type: "post",
      url: "/api/active_acc/"+user_id,
      data: {
         active: 1
      },
      success: function(res){
        console.log(res);
      },
      error: function(res){
        console.log(res);
      }
    })
  })
})
