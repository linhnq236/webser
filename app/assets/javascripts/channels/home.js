$( document ).on('turbolinks:load', function() {
  App.room = App.cable.subscriptions.create('LedstatusChannel', {
    received: function(data) {
      var setvalue = '';
      var setareapin = '';
      $.each(data["ledstatus"], function(index, value){
        $.each(value, function(i,v){
          $.each(v, function(ii,vv){
            $.each(vv, function(iii,vvv){
              $(`.led${index}`).each(function(index1, value1){
                var res = $(this).data("status");
                var areapin = $(this).data("areapin");
                setareapin = index + i + ii + iii;
                if(areapin == setareapin){
                  $(this).text(vvv);
                  if (vvv == 'on') {
                    $(`.${areapin}`).removeClass('bg-primary');
                    $(`.${areapin}`).addClass('bg-danger');
                  }else if(vvv == 'off'){
                    $(`.${areapin}`).removeClass('bg-danger');
                    $(`.${areapin}`).addClass('bg-primary');
                  }

                  if(vvv == 'disable') {
                    var changeturnon = areapin.replace('active', 'turnon');
                    var changeturnoff = areapin.replace('active', 'turnoff');
                    var changetime = areapin.replace('active', 'time');
                   $(`.${areapin}`).removeClass('bg-primary');
                   $(`.${areapin}`).addClass('bg-danger hasdisable');
                   $(`.${changeturnon}`).text('0000-00-00 00:00');
                   $(`.${changeturnoff}`).text('0000-00-00 00:00');
                   $(`.${changetime}`).text('00:00');
                 }else if(vvv == 'enable'){
                   $(`.${areapin}`).removeClass('bg-danger hasdisable');
                   $(`.${areapin}`).addClass('bg-primary');
                 }
                }
              })
            })
          })
        })
      })
    },
  });
})
