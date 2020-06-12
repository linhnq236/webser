$( document ).on('turbolinks:load', function() {
  var html_district = '';
  var html_ward = '';
  var house_active = 0;
  $('select.city').change(function() {
    var idCity = this.value;
    console.log(idCity);
    $(".district option").each(function(){
      var cityid = $(this).data("cityid");
      if (idCity == cityid) {
        $(this).css({"display": "block"});
      }else{
        $(this).css({"display": "none"});
      }
    })
  })
  $('select.district').change(function() {
    // var idDistrict = this.value;
    $.ajax({
      type: "get",
      url: "/api/getward/" + this.value,
      success: function(rep){
        $.each(rep["data"], function(index, value){
          html_ward += `<option value="${value["id"]}">${value["name"]}</option>`
        })
        $(".ward").html(html_ward);
      },
      error: function(rep){
        console.log(rep);
      }
    })
  })
  // click name_house -> rooms houses
  $(".blockquotehouse").first().css({"box-shadow":"7px 4px 8px -1px rgba(87,143,240,1)"});
  var idhouse = $(".thishouse").first().data("idhouse");
      house_active = idhouse;
  $(`.${idhouse}_house`).removeClass("d-none");
  // $(".blockquotehouse").first().addClass("edithouse");
  $(".thishouse").click(function(){
    var idhouse = $(this).data("idhouse");
        house_active = idhouse;
    $(".room").each(function(){
      var idroom = $(this).data("idroom");
      if (idroom == idhouse) {
        $(`.${idhouse}_house`).removeClass("d-none");
        $(`.block_house_${idhouse}`).css({"box-shadow":"7px 4px 8px -1px rgba(87,143,240,1)"});
      }else{
        $(`.${idroom}_house`).addClass("d-none");
        $(".blockquotehouse").each(function(){
          var notactive = $(this).data("idhouse");
          if (idhouse != notactive) {
            console.log(notactive);
            $(`.block_house_${notactive}`).removeAttr('style');
          }
        })
      }
    })
  })
  // location
  $(".edithouse").click(function(){
    location.href = `/houses/${house_active}/edit`;
  })
  $(".deletehouse").click(function(){
    if (confirm("Các phòng ở ngôi nhà này sẽ bị xóa sạch.")) {
      location.href = `/deletehouse/${house_active}`;
    }
    return false;
  })
})
