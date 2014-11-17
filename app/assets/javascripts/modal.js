$(document).ready(function(){
  $('.to-sub-vid-modal a').on('click', function(e){
    e.preventDefault();
    $('#submit-vid-form').modal('show');
  });

  $('.get-signed-in a').on('click', function(e){
    e.preventDefault();
    $('#submit-vid-form-sign-in').modal('show');
  });

  $('.edit-video').on('click', function(e){
      e.preventDefault();
      $('#edit-vid-form').modal('show');
  });

  $('.delete-video').on('click', function(e){
        e.preventDefault();
        $('#edit-vid-form').modal('hide');
        $('#delete-vid-form').modal('show');
  });

  $('.modal-footer input').click(function() {
     console.log('click');
  });

});