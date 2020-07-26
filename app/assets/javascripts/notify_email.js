$( document ).on('turbolinks:load', function() {
  let default_notify_date = 24;
  var d = new Date();
  var date = d.getDate();
  if (date == default_notify_date) {
    $(".note_notify").html("7");
    $(".mess_notify").html("7");
  }
})
