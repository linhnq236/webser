$( document ).on('turbolinks:load', function() {
  $(".checkpaytherent").click(function(){
    var paytherent_id = $(this).data("paytherent_id");
    var senddate = $(this).data("senddate");
    $.ajax({
      type: "PUT",
      url: "/api/updatePaytherent/" + paytherent_id,
      data: {
        senddate: senddate
      },
      success: function(response){
        console.log(response);
      },
      error: function(response){
        console.log(response);
      }
    })

  })
})
