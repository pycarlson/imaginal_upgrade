$(document).ready(function(){
  $('.to-sub-vid-modal a').on('click', function(e){
    e.preventDefault();
    $('#submit-vid-form').modal('show');
  });

  $('.edit-video').on('click', function(e){
      e.preventDefault();
      $('#edit-vid-form').modal('show');
  });

});