$( document ).on('turbolinks:load', function() {
  App.room = App.cable.subscriptions.create('LedstatusChannel', {
    received: function(data) {
      var setvalue = '';
      $.each(data["ledstatus"], function(index, value){
        $(".led").each(function(index1, value1){
          var res = $(this).data("status");
          if(index == res){
            $(this).text(value);
          }
        })
      })
    },
  });
})
