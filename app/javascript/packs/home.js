$( document ).on('turbolinks:load', function() {
  $(".on").click(function(){
    $.ajax({
      url: "http://192.168.1.16/LED=ON",
      headers: {  'Access-Control-Allow-Origin': '*' },
      success: function(){
        alert("ok");
      },
    })
  })
  $(".off").click(function(){
    $.ajax({
      url: "http://192.168.1.16/LED=OFF",
      headers: {  'Access-Control-Allow-Origin': '*' },
      success: function(){
        alert("ok");
      },

    })
  })
})
