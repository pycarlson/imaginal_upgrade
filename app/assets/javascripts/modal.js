$(document).ready(function(){
  $('.to-sub-vid-modal a').on('click', function(e){
    e.preventDefault();
    $('#submit-vid-form').modal('show');
  });

  $('.profile-vid-edit').on('click', function(e){
    e.preventDefault();
    $('#submit-vid-form').modal('show');
  });
});