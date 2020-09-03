$( document ).on('turbolinks:load', function() {
  $(".day").click(function(){
    var date = $(this).attr("date");
    var reminder_count = $(this).find(".reminder_count").length;
    if (reminder_count == 0) {
      $.confirm({
        title: I18n.t('js.reminders.new_reminder'),
        closeIcon: true,
        content:`
        <form action="" class="formCreateNotify">
          <div class="form-group">
            <label>${I18n.t('js.reminders.subtitle')}</label>
            <input type="text" class="title form-control" required />
            <label>${I18n.t('js.reminders.content')}</label>
            <textarea class="content mb-2" cols="20" rows="20"></textarea>
          </div>
        </form>`,
        buttons: {
          formSubmit: {
            text: 'Ok',
            btnClass: 'btn-blue',
            action: function () {
              var title = this.$content.find('.title').val();
              var content = this.$content.find('.content').val();
              var start_time = date;
              var end_time = date;
              if(!title || !content){
                  $.alert('Không được để trống');
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
                  console.log(repsonse)
                }
              })
            }
          },
          Cancel: {
            btnClass: 'btn-danger',
              //close
          },
        },
      })
    } else {
      var title = '';
      var content = '';
      var html = '';
      $.confirm({
        content: function () {
          var self = this;
          return $.ajax({
              url: "/api/getReminder",
              method: 'get',
              data: {
                  start_time: date
                },
          }).done(function (response) {
            $.each(response['data'], function(index, value){
              html +=`
              <div class="form-group ">
              <label>Tiêu đề ${index}</label>
              <input type="text" placeholder="Tiêu đề" class="id form-control d-none" value = "${value['id']}" required />
              <input type="text" placeholder="Tiêu đề" class="title form-control" value = "${value['title']}" required />
              <label>Nội dung ${index}</label>
              <textarea class="content mb-2" cols="20" rows="20"> ${value['content']}</textarea>
              </div>
              `;
            })
              // self.setConten('<i class="fa fa-user"></i> Thông tin khách hàng ');
              self.setContentAppend(`
                <form action="" class="formCreateNotify">
                    ${html}
                  </form>
                `);
              self.setTitle('<i class="fa fa-calendar"></i> Nội dung nhắc nhở  ');
          }).fail(function(){
              self.setContent('Something went wrong.');
          });
        },
        closeIcon: true,
        buttons: {
          Lưu:{
            btnClass: 'btn-primary',
            action: function(){
              var title = this.$content.find('.title');
              var content = this.$content.find('.content');
              var id = this.$content.find('.id');
              var arraytitle = [];
              var arraycontent = [];
              var arrayid = [];
               this.$content.find('.title').each(function(index, value){
                 arraytitle.push(value.value);
               })
               this.$content.find('.content').each(function(index, value){
                 arraycontent.push(value.value);
               })
               this.$content.find('.id').each(function(index, value){
                 arrayid.push(value.value);
               })
               $.ajax({
                 type: 'POST',
                 url: '/api/reminders',
                 data: {
                   arraytitle: arraytitle,
                   arraycontent: arraycontent,
                   arrayid: arrayid,
                 },
                 success: function(response){
                   console.log(response);
                 },
                 error: function(response){
                   console.log(response);
                 }
               })
            }
          },
          Hủy: {
            btnClass: 'btn-danger'
          }
        }
      });
    }
  });
  // #default one .formCreateNotify show
})
