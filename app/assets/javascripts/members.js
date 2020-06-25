$( document ).on('turbolinks:load', function() {
  var countElements = 0;
  console.log(countElements);
  $(".addmember").click(function(){
    countElements ++;
    html = `
      <tr class="RowPerson_${countElements}">
        <td class="text-center">
          <input type="text" name="name" class="form-control">
        </td>
        <td class="text-center">
          <input type="date" name="checkservice" class="form-control">
        </td>
        <td class="text-danger text-center">
          <select class="form-control"  required name="sex">
            <option value="0">Nam</option>
            <option value="1">Nữ</option>
          </select>
        </td>
        <td class="text-center">
          <input type="text" name="service" class="form-control text-center"/>
        </td>
        <td class="text-center">
          <input type="text" name="service" class="form-control text-center"/>
        </td>
        <td class="text-center">
          <input type="text" name="service" class="form-control text-center"/>
        </td>
        <td class="text-center">
          <a class="btn btn-danger text-white removeperson" data-rowremove="${countElements}" name="removefield">
            <i class="fa fa-minus-circle"></i>
          </a>
        </td>
      </tr>
    `;
    $(".members").append(html);
    $(".removeperson").click(function(){
      var columnRowRemove = $(this).data("rowremove");
      console.log(columnRowRemove);
      $(`.RowPerson_${columnRowRemove}`).remove();
    })
  })
  // removefield person
})
