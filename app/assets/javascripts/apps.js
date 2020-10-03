$(document).on("turbolinks:load", function(){
  $(".delete_slider").click(function(){
    var app_id = $(this).data('app_id');
    $.confirm({
      title: I18n.t('js.mes.confirm.delete'),
      content: I18n.t('js.mes.delete'),
      buttons:{
        Delete: {
          btnClass: 'btn-danger',
          action: function(){
            $.ajax({
              type: 'get',
              url: '/api/delete_slider',
              data: {
                app_id: app_id
              },
              success: function(res){
                if (res['status'] == 200) {
                  $.confirm({
                    title: false,
                    content: "Delete successfully",
                    buttons: {
                      Ok: {
                        btnClass: 'btn-primary',
                        action: function(){
                          location.reload();
                        }
                      }
                    }
                  })
                }
              },
              error: function(res){
                console.log(res);
              }
            })
          }
        },
        Cancel: {
          btnClass: 'btn-dark'
        }
      }
    })
  })
  $(".edit_slider").click(function(){
    var app_id = $(this).data('app_id');
    $.ajax({
      type: 'get',
      url: '/api/apps/'+app_id,
      data: {
        app_id: app_id
      },
      success: function(res){
        $(".app_input_id").html(`<input type="hidden" name="app_id" value="${app_id}"/>`);
        $(".app_title").attr('value', res['data']['title']);
        $(".app_text").html(res['data']['text']);
        $(".app_image").attr('value', res['data']['image']['url']);
        $(".app_backgroundColor").attr('value', res['data']['backgroundColor']);
      },
      error: function(res){
        console.log(res);
      }
    })
  })
})
