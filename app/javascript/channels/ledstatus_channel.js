import consumer from "./consumer"

consumer.subscriptions.create("LedstatusChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var setvalue = '';
    $.each(data["ledstatus"], function(index, value){
      $(".led").each(function(index1, value1){
        var res = $(this).data("status");
        if(index == res){
          $(this).text(value);
        }
      })
    })
  }
});
