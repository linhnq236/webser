$( document ).on('turbolinks:load', function() {
  var d = new Date();
  var twoDigitMonth = ((d.getMonth().length+1) === 1)? (d.getMonth()+1) : '0' + (d.getMonth()+1);
  var twoDigitDay = ((d.getDate()) === 1)? (d.getDate()) : '0' + (d.getDate());
  var currentDate = d.getFullYear() + '-' + twoDigitMonth + "-" + twoDigitDay;
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
    if (Date.parse(value['created_at']) <= Date.parse(currentDate)){
      if (value['mark'] == 0) {
        count_report += 1;
      }
      html_report +=
      `<div class="overflow-hidden report-content m-1" data-id='${value['id']}'  style="color: blue;background: ${value['mark'] == 0 ? '#b0b3b8' : '' }" data-mark='${value['mark']}' data-date='${value['start_time']}'>
        <i class="fa fa-calendar"></i>
        ${value['title']}
        <div class="ml-4"><small>${moment(new Date()).format('yyyy-MM-dd')}</small></div>
      </div>`
    }
  })
  $(".show_report").html(
    `
      <div>${html_report}</div>
      <a href="/reports" class="text-white hovernotbackground">Xem tất cả</a>
    `
  );
  $(".report_notify").html(count_report);
})
