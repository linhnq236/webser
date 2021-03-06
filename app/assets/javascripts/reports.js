$( document ).on('turbolinks:load', function() {
  var d = new Date();
  var month = d.getMonth()+1;
  var day = d.getDate();
  var currentDate = d.getFullYear() + '-' +
      (month<10 ? '0' : '') + month + '-' +
      (day<10 ? '0' : '') + day;
  var html_report =  '';
  var count_report = 0;
  $(".rep_report").click(function(){
    var report_id = $(this).data('report_id');
    $.ajax({
      type: 'get',
      url: '/api/reports/'+report_id,
      success: function(response){
        $(".report_title").attr("value", response['data']['title']);
        $(".report_content").html(response['data']['content']);
        $(".report_rep_content").html(response['data']['rep_content']);
        $(".form_reports").attr("action", `/reports/${response['data']['id']}`);
        $(".button_rep_report").removeAttr("disabled");
      },
      error: function(response){
        console.log(response);
      }
    })
  })

  //
  $.each(gon.reports, function(index, value){
    var created_at = (value['created_at']);
    var format_created_at = moment(new Date(created_at)).format('yyyy-MM-D');
    if (Date.parse(format_created_at) <= Date.parse(currentDate)){
      if (value['mark'] == 0) {
        count_report += 1;
      }
      html_report +=
      `<div class="overflow-hidden report-content m-1" data-id='${value['id']}'  style="color: blue;background: ${value['mark'] == 0 ? '#b0b3b8' : '' }" data-mark='${value['mark']}' data-date='${value['start_time']}'>
        <i class="fa fa-calendar"></i>
        ${value['title']}
        <div class="ml-4"><small>${moment(new Date()).format('yyyy-MM-D')}</small></div>
      </div>`
    }
  })
  $(".show_report").html(
    `
      <div>${html_report}</div>
      <div class='text-center'>
        <a href="/reports?locale=${gon.locale}" class="text-white hovernotbackground text-decoration-none">${I18n.t('js.reports.all')}</a>
      </div>
    `
  );
  $(".report_notify").html(count_report);
  // ===========================4 status feddback===========================================
  $(".report_status").change(function(){
    $value = this.value;
    $report_id = $(this).data('report_id');
    $.ajax({
      type: 'post',
      url: '/api/status_feedback/'+$report_id + "/" + $value,
      success: function(response){
        if(response['status'] == 200){
          $.alert({
            title: "Notice",
            content: "Update successfully",
            iconClose: true,
          })
        }else{
          $.alert({
            title: "Notice",
            content: "Update failed",
            iconClose: true,
          })

        }
      },
      error: function(response){
        console.log(response);
      }
    })
  })
})
