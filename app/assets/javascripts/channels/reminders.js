$( document ).on('turbolinks:load', function() {
  App.room = App.cable.subscriptions.create('RemindersChannel', {
    received: function(data) {
      var count = 0;
      $(".notify-content").each(function(){
        var mark = $(this).data("mark");
        if (mark == 0) {
          count ++;
        }
      })
      $(".note_notify").html(count - data['reminders']);
      $(".notify-content").removeClass("style");
    }
  });
})
