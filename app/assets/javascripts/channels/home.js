$( document ).on('turbolinks:load', function() {
  App.room = App.cable.subscriptions.create('LedstatusChannel', {
    received: function(data) {
      var setvalue = '';
      var setareapin = '';
      $.each(data["ledstatus"], function(index, value){
        $.each(value, function(i,v){
          $(`.led${index}`).each(function(index1, value1){
            var res = $(this).data("status");
            var areapin = $(this).data("areapin");
            setareapin = index + i;
            if(areapin == setareapin){
              $(this).text(v);
            }
          })
        })
      })
    },
  });
})
