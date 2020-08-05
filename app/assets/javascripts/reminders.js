$( document ).on('turbolinks:load', function() {
  var d = new Date();
  var twoDigitMonth = ((d.getMonth().length+1) === 1)? (d.getMonth()+1) : '0' + (d.getMonth()+1);
  var twoDigitDay = ((d.getDate()) === 1)? (d.getDate()) : '0' + (d.getDate());
  var currentDate = d.getFullYear() + '-' + twoDigitMonth + "-" + twoDigitDay;
  var html =  '';
  var count = 0;
  $.each(gon.reminders, function(index, value){
    if (Date.parse(value['start_time']) <= Date.parse(currentDate)){
      if (value['mark'] == 0) {
        count += 1;
      }
      html +=
      `<div class="overflow-hidden notify-content m-1" data-id='${value['id']}'  style="color: blue;background: ${value['mark'] == 0 ? '#b0b3b8' : '' }" data-mark='${value['mark']}' data-date='${value['start_time']}'>
        <i class="fa fa-calendar"></i>
        ${value['title']}
        <div class="ml-4"><small>${value['start_time']}</small></div>
      </div>`
    }
  })
  // if (date == default_notify_date) {
  //   $(".mess_notify").html("7");
  // }
  $(".show_reminder").html(html);
  $(".note_notify").html(count);
  $(".create_notify").click(function(){
    $.confirm({
      title: 'Tạo nhắc nhở',
      closeIcon: true,
      content: '' +
      '<form action="" class="formCreateNotify">' +
      '<div class="form-group">' +
      '<label>Tiêu đề</label>' +
      '<input type="text" placeholder="Tiêu đề" class="title form-control" required />' +
      '<label>Nội dung</label>' +
      '<textarea class="content mb-2" cols="20" rows="20"></textarea>' +
      '<label>Bắt đầu</label>' +
      '<input type="date" placeholder="Ngày bắt đầu" class="start_time form-control" required />' +
      '<label>Kết thúc</label>' +
      '<input type="date" placeholder="Ngày kết thúc" class="end_time form-control" required />' +
      '</div>' +
      '</form>',
      buttons: {
          formSubmit: {
              text: 'Submit',
              btnClass: 'btn-blue',
              action: function () {
                  var title = this.$content.find('.title').val();
                  var content = this.$content.find('.content').val();
                  var start_time = this.$content.find('.start_time').val();
                  var end_time = this.$content.find('.end_time').val();
                  if(!title || !content || !start_time || !end_time){
                      $.alert('Không được dể trống');
                      return false;
                  }
                  $.ajax({
                    type: 'post',
                    url: "/reminders",
                    data: {
                      title: title,
                      content: content,
                      start_time: start_time,
                      end_time: end_time,
                    },
                    success: function(repsonse) {
                      console.log(repsonse)
                    },
                    error: function(repsonse) {
                      console.log("Set timer on is fails.")
                    }
                  })
              }
          },
          cancel: function () {
              //close
          },
      },
    })
  })
  $(".notify-content").click(function(){
    var mark = $(this).data("mark");
    var date = $(this).data("date");
    var id = $(this).data("id");
    if (mark == 0) {
      $.ajax({
        url: "/api/check_mark/"+id,
        type: "PUT",
        data: { send: 'OK'},
        success: function(response){
          location.href = `/reminders?start_time=${date}`;
        },
        error: function(repsonse){

        }
      })
    }else{
      location.href = `/reminders?start_time=${date}`;
    }
  })
  // delete reminder
  $(".delete").click(function(){
    var remind_id = $(this).data('remind_id');
    $.confirm({
      icon: 'fa fa-warning text-warning',
      title: "Thao tác",
      content: "Bạn có chắc muốn xóa ?",
      buttons: {
        Xóa: {
          btnClass: 'btn-danger',
          action: function(){
            $.ajax({
              type: "DELETE",
              url: `/reminders/${remind_id}`,
              success: function(respose){

              },
              error: function(respose){

              }
            })
          }
        },
        Hủy: {
          btnClass: 'btn-dark'
        }
      }
    })
  })
})
