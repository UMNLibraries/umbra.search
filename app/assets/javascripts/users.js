$(document).ready(function() {
  $('#cropbox').Jcrop({
    setSelect: [0, 0, 230, 230],
    aspectRatio: 1,
    onSelect: updateCoords,
    onChange: updateCoords
  });

  function updateCoords(coords) {
    $('#user_crop_x').val(coords.x);
    $('#user_crop_y').val(coords.y);
    $('#user_crop_w').val(coords.w);
    $('#user_crop_h').val(coords.h);
  }

  if ($('#cropbox').length) {
    $('.thumb-tiny').hide();
    $('.thumb-tiny').before('<span class="glyphicon glyphicon-user"></span>');
  }
});