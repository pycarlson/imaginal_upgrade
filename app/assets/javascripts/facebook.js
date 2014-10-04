$(document).ready(function(){
  $('#facebook-popup').hide();

  window.setTimeout(function() {
    $("#facebook-popup").show(); 
  }, 10000);

  $('#facebook-popup a').on('click', function(e){
    e.preventDefault();
    $('#facebook-popup').hide();
  });
});


