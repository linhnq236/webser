$(document).on("turbolinks:load", function(){
  var html = '';
  $(".setup").click(function(){
    var room_id = $(this).data("room_id");
    $.confirm({
      columnClass: 'col-sm-12',
      content: function () {
        var self = this;
        return $.ajax({
          type: "get",
          url: "/api/setup/"+room_id,
        }).done(function (response) {
          $.each(response["data"], function(index, value){
            html += `
            <div class="col-sm-12">
            <div class="row">
            <div class="col-sm-1">${index+1}</div>
            <div class="col-sm-11 text-center form-control">${value}</div>
            </div>
            </div>
            `;
          })
          // self.setConten('<i class="fa fa-user"></i> Thông tin khách hàng ');
          self.setContentAppend(html);
          self.setTitle('<i class="fa fa-info"></i> Cách lắp đặt trong điều khiển đèn');
        }).fail(function(){
          self.setContent('Something went wrong.');
        });
      },
      closeIcon: true,
      buttons: {
        Hủy: {
          btnClass: 'btn-danger'
        }
      }
    });
  })
})
