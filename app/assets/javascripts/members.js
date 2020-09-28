$( document ).on('turbolinks:load', function() {
  var countElements = 0;

  $(".addmember").click(function(){
    countElements ++;
    html = `
      <tr class="RowPerson_${countElements}">
        <td class="text-center">
          <input type="text" name="member[name][]" class="form-control">
        </td>
        <td class="text-center">
          <input type="date" name="member[birth][]" class="form-control">
        </td>
        <td class="text-danger text-center">
          <select class="form-control"  required name="member[sex][]">
            <option value="0">${I18n.t('layout.male')}</option>
            <option value="1">${I18n.t('layout.female')}</option>
          </select>
        </td>
        <td class="text-center">
          <input type="text" name="member[indentifycard][]" class="form-control text-center"/>
        </td>
        <td class="text-center">
          <input type="text" name="member[address][]" required class="form-control text-center"/>
        </td>
        <td class="text-center">
          <input type="text" name="member[phone][]" class="form-control text-center"/>
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
      $(`.RowPerson_${columnRowRemove}`).remove();
    })
  })
  $(".removepersonList").click(function(){
    var columnRowRemove = $(this).data("rowremove");
    $(`.RowPersonList_${columnRowRemove}`).remove();
  })
  // removefield person
  $(".removememberRow").click(function(){
    var deleterow = $(this).data("deleterow");
    $(`.member_${deleterow}`).remove();
    $(this).remove();
  })
})
