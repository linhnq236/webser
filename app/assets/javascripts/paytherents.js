$( document ).on('turbolinks:load', function() {
  $(".checkpaytherent").click(function(){
    var paytherent_id = $(this).data("paytherent_id");
    var senddate = $(this).data("senddate");
    $.ajax({
      type: "PUT",
      url: "/api/updatePaytherent/" + paytherent_id,
      data: {
        senddate: senddate
      },
      success: function(response){
        console.log(response);
      },
      error: function(response){
        console.log(response);
      }
    })

  })
  var time = '';
  var text = '';
  var month = '';
  $('.senddate').on('change', function() {
    time = this.value;
  });
  $(".export_csv").click(function(){
    if (!time) {
      $.confirm({
        title: "Note !",
        content: "You must chosen month before export",
        closeIcon: true,
        buttons: {
          Ok: {
            btnClass: "btn-primary"
          }
        }
      })
      return false;
    }
    $.ajax({
      type: 'post',
      url: "/api/export.csv",
      data: {
        senddate: time
      },
      success: function(res){
        $.each(res['data'], function(index, value){
          $.each(value, function(ind, val){
            month = val['month'];
            text += `
              Fullname: ${val['fullname']}
              Email   : ${val['email']}
              Phone1  : ${val['phone1']}
              Phone2  : ${val['phone2']}
              House   : ${val['house']}
              Room    : ${val['room']}
              Payment : ${val['status'] == 1 ? "Yes" : "No"}
              Total   : ${val['total']} VND

              (Note: Let's check your email)
              ----------------------------------------------------------------
            `;
          })
        })
        var blob = new Blob([text], {type: "text/plain;charset=utf-8"});
         saveAs(blob, `${month}.txt`);
      },
      error: function(res){
        console.log(res);
      }
    })
  })
})
