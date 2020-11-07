$( document ).on('turbolinks:load', function() {
  var d = new Date();
  var month = d.getMonth()+1;
  var day = d.getDate();
  var currentDate = d.getFullYear() + '-' +
      (month<10 ? '0' : '') + month + '-' +
      (day<10 ? '0' : '') + day;
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
  $(".show_reminder").html(
    `
    ${html}
    <div class='text-center'>
      <a href="/reminders" class="text-white hovernotbackground text-decoration-none">${I18n.t('js.reports.all')}</a>
    </div>
    `
  );
  $(".note_notify").html(count);
  $(".create_notify").click(function(){
    $.confirm({
      title: I18n.t('js.reminders.title'),
      closeIcon: true,
      content: `
      <form action="" class="formCreateNotify">
        <div class="form-group">
          <label>${I18n.t('js.reminders.subtitle')}</label>
          <input type="text" class="title form-control" required />
          <label>${I18n.t('js.reminders.content')}</label>
          <textarea class="content mb-2" cols="20" rows="20"></textarea>
          <label>${I18n.t('js.reminders.start')}</label>
          <input type="date" class="start_time form-control" required />
          <label>${I18n.t('js.reminders.end')}</label>
          <input type="date" class="end_time form-control" required />
        </div>
      </form>`,
      buttons: {
          formSubmit: {
              text: 'OK',
              btnClass: 'btn-blue',
              action: function () {
                  var title = this.$content.find('.title').val();
                  var content = this.$content.find('.content').val();
                  var start_time = this.$content.find('.start_time').val();
                  var end_time = this.$content.find('.end_time').val();
                  if(!title || !content || !start_time || !end_time){
                      $.alert('Do not be empty');
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
                      console.log("fails.")
                    }
                  })
              }
          },
          Cancel: {
            btnClass: 'btn-danger',
          },
      },
    })
  })
  $(".notify-content").click(function(){
    var mark = $(this).data("mark");
    var date = $(this).data("date");
    var id = $(this).data("id");
    location.href = `/reminders?start_date=${date}`;
    if (mark == 0) {
      $.ajax({
        url: "/api/check_mark/"+id,
        type: "PUT",
        data: { send: 'OK'},
        success: function(response){
          console.log("OK");
        },
        error: function(repsonse){

        }
      })
    }else{
      location.href = `/reminders?start_date=${date}`;
    }
  })
  // delete reminder
  $(".delete").click(function(){
    var remind_id = $(this).data('remind_id');
    $.confirm({
      icon: 'fa fa-trash text-danger',
      title: I18n.t("js.mes.confirm.delete"),
      content: I18n.t("js.mes.delete"),
      buttons: {
        Delete: {
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
        Cancel: {
          btnClass: 'btn-dark'
        }
      }
    })
  })
})
