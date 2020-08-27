$( document ).on('turbolinks:load', function() {
  var html_district = '';
  var html_ward = '';
  var house_active = 0;
  $('select.city').change(function() {
    $.ajax({
      type: "get",
      url: "/api/getdistrict/" + this.value,
      success: function(rep){
        $.each(rep["data"], function(index, value){
          html_district += `<option value="${value["id"]}">${value["name"]}</option>`
        })
        $(".district").html(html_district);
        html_district = '';
      },
      error: function(rep){
        console.log(rep);
      }
    })
  })
  $('select.district').change(function() {
    // var idDistrict = this.value;
    $.ajax({
      type: "get",
      url: "/api/getward/" + this.value,
      success: function(rep){
        $.each(rep["data"], function(index, value){
          html_ward += `<option value="${value["id"]}">${value["name"]}</option>`
        })
        $(".ward").html(html_ward);
        html_ward = '';
      },
      error: function(rep){
        console.log(rep);
      }
    })
  })
  // click name_house -> rooms houses
  $(".blockquotehouse").first().css({"box-shadow":"7px 4px 8px -1px rgba(87,143,240,1)"});
  var idhouse = $(".thishouse").first().data("idhouse");
      house_active = idhouse;
  $(`.${idhouse}_house`).removeClass("d-none");
  // $(".blockquotehouse").first().addClass("edithouse");
  $(".thishouse").click(function(){
    var idhouse = $(this).data("idhouse");
        house_active = idhouse;
    $(".room").each(function(){
      var idroom = $(this).data("idroom");
      if (idroom == idhouse) {
        $(`.${idhouse}_house`).removeClass("d-none");
        $(`.block_house_${idhouse}`).css({"box-shadow":"7px 4px 8px -1px rgba(87,143,240,1)"});
      }else{
        $(`.${idroom}_house`).addClass("d-none");
        $(".blockquotehouse").each(function(){
          var notactive = $(this).data("idhouse");
          if (idhouse != notactive) {
            $(`.block_house_${notactive}`).removeAttr('style');
          }
        })
      }
    })
  })
  // location
  // Sua phong
  $(".edithouse").click(function(){
    location.href = `/houses/${house_active}/edit`;
  })
  // tra phong
  $(".payroom").click(function(){
    var room_id = $(this).data("idroom");
    var information_id = $(this).data("information_id");
    $.confirm({
        title: I18n.t('js.notice'),
        content: I18n.t('js.room.pay_room'),
        buttons: {
            Ok: {
              btnClass: 'btn-primary',
              action: function(){
                location.href = `/payroom/${room_id}/${information_id}`;
              }
            },
            Cancel: {
              btnClass: 'btn-danger',
            },
        }
    });
  })
  // xoa phong
  $(".deletehouse").click(function(){
    $.confirm({
        title: I18n.t('js.notice'),
        content: I18n.t('js.house.delete_room'),
        buttons: {
            Ok: {
              btnClass: 'btn-primary',
              action: function(){
                location.href = `/deletehouse/${house_active}`;
              }
            },
            Hủy: {
              btnClass: 'btn-danger',
            },
        }
    });
  })
  // them khach hang vao phong
  $(".addcustomer").click(function(){
    var idroom = $(this).data("idroom");
    location.href = `/addcustomer/${house_active}/${idroom}`;
  })
  // xem va chinh sua thong tin khach hang
  $(".view_service_customer").click(function(){
    var idroom = $(this).data("idroom");
    var idinformation = $(this).data("information_id");
    location.href = `/listcustomer/${house_active}/${idroom}/${idinformation}`;
  })
  // khi co nguoi dang muon phng thi khong cho pep xoa phong nay.
  $(".not-active").click(function(){
    $.alert({
      title: I18n.t('js.notice'),
      content: I18n.t('js.room.delete_room_error'),
    });
    return false;
  })
  // get api old customer
  $(".getOldCustomer").click(function(){
    var house_id = $(this).data("house_id");
    var room_id = $(this).data("room_id");
    getOldCustomer(house_id, room_id);
  })

  function getOldCustomer(house_id, room_id){
    html = '';
    $.confirm({
      columnClass: 'col-sm-12',
      content: function () {
        var self = this;
        return $.ajax({
            url: "/api/getOldCustomer",
            method: 'get'
        }).done(function (response) {
          var i = 0;
          console.log(response);
          $.each(response['data'], function(index, value){
            i ++;
            html += `
              <tr class="chosenOldCustomer currsor" data-information_id="${value["id"]}">
                <td class="text-center test"><input type="radio"  value="${value["id"]}"></td>
                <td class="text-center">${value["name"]}</td>
                <td class="text-center">${value["email"]}</td>
                <td class="text-center">${value["phone1"]}</td>
              </tr>
            `;
          })
            // self.setConten('<i class="fa fa-user"></i> Thông tin khách hàng ');
            self.setContentAppend(
              `
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th class="text-center">Chọn</th>
                    <th class="text-center">Họ và tên</th>
                    <th class="text-center">Email</th>
                    <th class="text-center">Số điện thoại</th>
                  </tr>
                </thead>
                <tbody>
                  ${html}
                </tbody>
              </table>
              `
            );
            self.setTitle('<i class="fa fa-user"></i> Thông tin khách hàng cũ ');
            // chosenOldCustomer
        }).fail(function(){
            self.setContent('Something went wrong.');
            return false;
        });
      },
      closeIcon: true,
      buttons: {
        Ok: {
          btnClass: 'btn-primary',
          action: function(){
            var information_id = this.$content.find("input[type='radio']:checked").val();
            location.href = `/addcustomer/${house_id}/${room_id}?information_id=${information_id}`;
          }
        },
        Hủy: {
          btnClass: 'btn-danger',

        }
      }
    })
  }
  // changed email
  $(".changed_email").click(function(){
    var current_email = $(this).find('input').val();
    var information_id = $(this).data('information_id');
    $.confirm({
      title: "CHANGE EMAIL",
      // columnClass: 'col-md-5 col-md-offset-4',
      closeIcon: true,
      content: `
      <form action='' class='formName'>
        <div class="form-group">
          <lebal>Email</lebal>
          <input type="email" class="current_email form-control" disabled value="${current_email}" required />
          <lebal>New Email</lebal>
          <input type="email" class="new_email form-control" required />
        </div>
      </form>
      `,
      buttons: {
          formSubmit: {
            text: 'Submit',
            btnClass: 'btn-blue',
            action: function () {
            var current_email = this.$content.find('.current_email').val();
            var new_email = this.$content.find('.new_email').val();
            if (!new_email) {
              alert("Email is blank");
              return false;
            }
            $.ajax({
                type: 'post',
                url: "/api/changed_email/"+information_id,
                data: {
                  current_email: current_email,
                  new_email: new_email,
                },
                success: function(repsonse) {
                  if (repsonse['data'] == 200) {
                    alert("Update successfully");
                    location.reload();
                  } else {
                    location.reload();
                  }
                },
                error: function(repsonse) {
                  console.log(repsonse);
                }
              })
            }
          },
          cancel: function () {
              //close
          }
      }
    })
  })
})
