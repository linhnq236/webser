$(document).on("turbolinks:load", function(){
  $(".info_cus").click(function(){
    var html = '';
    var information_id = $(this).data("id");
    // var load = setTimeout(loading,0);
    var member = "Thành viên";
    $.confirm({
      columnClass: 'col-sm-12',
      content: function () {
        var self = this;
        return $.ajax({
            url: "/api/getinfo/" + information_id,
            // dataType: 'json',
            method: 'get'
        }).done(function (response) {
            html += `
              <div class="col-sm-12">
                <div class="row">
                  <div class="col-sm-3 form-control">Họ và tên</div>
                  <div class="col-sm-3 form-control">${response["data"]["name"]}</div>
                  <div class="col-sm-3 form-control">Giới tính</div>
                  <div class="col-sm-3 form-control">${convert_sex(response["data"]["sex"])}</div>
                </div>
                <div class="row">
                  <div class="col-sm-3 form-control">Ngày sinh</div>
                  <div class="col-sm-3 form-control">${response["data"]["birth"]}</div>
                  <div class="col-sm-3 form-control">Email</div>
                  <div class="col-sm-3 form-control overflow-hidden">${response["data"]["email"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-3 form-control">CMND</div>
                  <div class="col-sm-3 form-control">${response["data"]["indentifycard"]}</div>
                  <div class="col-sm-3 form-control">Ngày cấp</div>
                  <div class="col-sm-3 form-control">${response["data"]["daterange"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-3 form-control">Nơi cấp</div>
                  <div class="col-sm-3 form-control">${response["data"]["placerange"]}</div>
                  <div class="col-sm-3 form-control">Đ/c thường trú</div>
                  <div class="col-sm-3 form-control">${response["data"]["permanent"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-3 form-control">SĐT1 </div>
                  <div class="col-sm-3 form-control">${response["data"]["phone1"]}</div>
                  <div class="col-sm-3 form-control">SĐT2</div>
                  <div class="col-sm-3 form-control">${response["data"]["phone2"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-3 form-control">Đặt cọc </div>
                  <div class="col-sm-3 form-control">${response["data"]["deposit"]}</div>
                  <div class="col-sm-3 form-control">Bắt đầu</div>
                  <div class="col-sm-3 form-control">${response["data"]["start"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-3 form-control">Ghi chú</div>
                  <div class="col-sm-9 form-control">${response["data"]["note"]}</div>
                </div>
              </div>
            `;
            // self.setConten('<i class="fa fa-user"></i> Thông tin khách hàng ');
            self.setContentAppend(html);
            self.setTitle('<i class="fa fa-user"></i> Thông tin khách hàng ');
        }).fail(function(){
            self.setContent('Something went wrong.');
        });
      },
      closeIcon: true,
      buttons: {
        Thành_viên:{
          btnClass: 'btn-primary',
          action: function(){
            location.href = "/info_members/" + information_id;
          }
        },
        Hủy: {
          btnClass: 'btn-danger'
        }
      }
    });
  })
  // show information
  function show_info(html){
    $.confirm({
      icon: 'fa fa-user',
      title: 'Thông tin khách hàng',
      columnClass: 'col-md-12',
      closeIcon: true,
      closeIconClass: 'fa fa-close',
      content: html,
      buttons: {
        Đóng: {

        }
      }
    });
  }
  // loading data
  function loading(){
    var loading = '<i class="fa fa-spinner fa-spin text-center"> </i>';
    $.dialog({
      title: false,
      content: `<div class="text-center">${loading}</div>`,
      closeIcon: false,
    });
  }
  // stop loading data
  function stoploading(stoploading){
    clearTimeout(stoploading)
  }
  // convert sex
  function convert_sex(sex){
    if(sex == false){
      return "Nam";
    }
    return "Nữ";
  }
})
