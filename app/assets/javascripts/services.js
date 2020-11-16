$(document).on("turbolinks:load", function(){
  $(".service_edit").click(function(){
    var service_id = $(this).data("service_id");
    $.ajax({
      type: 'get',
      url: '/api/services/'+service_id,
      success: function(res){
        $(".service_name").attr('value',res['data']['name']);
        $(".service_cost").attr('value',res['data']['cost']);
      },
      error: function(res){
        console.log(res);
      }
    })
  })

  $(".button_new_service").click(function(){
    $(".form_new_service").slideToggle();
  })
})
