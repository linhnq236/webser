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
                  <div class="col-sm-6 form-control">${I18n.t('users.fullname')}: ${response["data"]["name"]}</div>
                  <div class="col-sm-6 form-control">${I18n.t('users.sex')}: ${convert_sex(response["data"]["sex"])}</div>
                </div>
                <div class="row">
                  <div class="col-sm-6 form-control">${I18n.t('users.birth')}: ${response["data"]["birth"]}</div>
                  <div class="col-sm-6 form-control overflow-hidden">Email: ${response["data"]["email"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-6 form-control">${I18n.t('users.indentifycard')}: ${response["data"]["indentifycard"]}</div>
                  <div class="col-sm-6 form-control">${I18n.t('users.daterange')}: ${response["data"]["daterange"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-6 form-control">${I18n.t('users.placerange')}: ${response["data"]["placerange"]}</div>
                  <div class="col-sm-6 form-control">${I18n.t('users.permanent')}: ${response["data"]["permanent"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-6 form-control">${I18n.t('users.phone1')}: ${response["data"]["phone1"]}</div>
                  <div class="col-sm-6 form-control">${I18n.t('users.phone2')}: ${response["data"]["phone2"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-6 form-control">${I18n.t('users.deposit')}: ${response["data"]["deposit"]}</div>
                  <div class="col-sm-6 form-control">${I18n.t('users.start')}: ${response["data"]["start"]}</div>
                </div>
                <div class="row">
                  <div class="col-sm-12 form-control">${I18n.t('users.note')}: ${response["data"]["note"]}</div>
                </div>
              </div>
            `;
            // self.setConten('<i class="fa fa-user"></i> Thông tin khách hàng ');
            self.setContentAppend(html);
            self.setTitle(`<i class="fa fa-user"></i> ${I18n.t('js.user.customer_information')} `);
        }).fail(function(){
            self.setContent('Something went wrong.');
        });
      },
      closeIcon: true,
      buttons: {
        Members:{
          btnClass: 'btn-primary',
          action: function(){
            location.href = "/show_detail_members/" + information_id;
          }
        },
        Cancel: {
          btnClass: 'btn-danger'
        }
      }
    });
  })
  // show information
  function show_info(html){
    $.confirm({
      icon: 'fa fa-user',
      title: I18n.t('js.user.customer_information'),
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
      return I18n.t('layout.male');
    }
    return I18n.t('layout.female');
  }
})
