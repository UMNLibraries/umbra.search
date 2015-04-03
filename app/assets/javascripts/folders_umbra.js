$(document).ready(function() {
  $('input[type=checkbox][name="folder_ids[]').click(function() {
    if ($('#documents input:checkbox:checked').length > 0 ) {
      $('#exhibits-menu').hide();
    } else {
      $('#exhibits-menu').show();
    }
  });
});