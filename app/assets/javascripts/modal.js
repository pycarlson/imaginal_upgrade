$(document).ready(function(){
  $('#submit-vid-form').modal('hide');
  $('.to-sub-vid-modal a').on('click', function(e){
    e.preventDefault();
    $('#submit-vid-form').modal('show');
  });
});