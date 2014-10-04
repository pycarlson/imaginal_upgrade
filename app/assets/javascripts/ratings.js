$(document).ready(function(){
  
  var $star         = $(".star");
  var $starLink     = $(".star a");
  var oneStarWidth  = 24;

  $starLink.on("click", function(e){
    e.preventDefault();
    
    var $rated        = ($(this).data('rated'));
    var $categoryName = ($(this).data('name'));
    var $title        = $('#star-brand h2')

    if ($rated === true) {
      $title.text("We already have your vote for " + $categoryName + ". Try another?");

      window.setTimeout(function() {
        $title.text('Vote. Share. Change the World.');
      }, 3000);

    } else if ($rated === false) {

      var $votedAlerts = ["Boom! " + $categoryName + " vote received. Keep going.",
                        "Booya! " + $categoryName + " vote registered. This is good!",
                        "Yayo! We got your " + $categoryName + " vote. Keep Rocking",
                        "I like you. You voted for " + $categoryName + ". Try another?",
                        "Right on. Good call. " + $categoryName + " voted tallied.",
                        "Nice! You voted for " + $categoryName + ". Did you share yet?",
                        "Your voice has been counted, at least for " + $categoryName + ".",
                        "Wow! Great vote for " + $categoryName + "? Cool.",
                        "My friend. We appreciate your vote for " + $categoryName + ".",
                        "Hmm… Your vote for " + $categoryName + " has registered.",
                        "This is what I like about you… You vote for " + $categoryName + ".",
                        "Oooh good call on " + $categoryName + ". Duly noted.",
                        "Reading you loud and clear on " + $categoryName + ".",
                        "OK. " + $categoryName + ". Check. Make sure you share ----->",
                        "Vote. " + $categoryName + ". Check. Share and change the world --->",
                        "We got your vote for " + $categoryName + ". Let's be friends?",
                        "You voted for " + $categoryName + ". You are an imaginal!",
                        "Heyo! Look at that. " + $categoryName + " vote completed.",
                        "What's that?  Did you just vote on " + $categoryName + ". Hell yeah!",
                        "This is awesome! You voted for " + $categoryName + ".",
                        "Imaginal is great! You voted for " + $categoryName + ".",
                        "Nice. You vote on " + $categoryName + ", we adjust the score.",
                        "Boom shaka laka. " + $categoryName + " vote registered.",
                        "" + $categoryName + " has been locked in.",
                        "You've rated this on " + $categoryName + ". Have you shared it yet?"]


      var $alert = $votedAlerts[Math.floor(Math.random() * $votedAlerts.length)];
      $title.text($alert);

      window.setTimeout(function() {
        $title.text('Vote. Share. Change the World.');
      }, 3000);

      $(this).parents('.stars').find('.colorBoxAverage').css('width', oneStarWidth * parseInt($(this).data('rating'), 10 ));

      var url = $(this).attr("href");
      $.ajax({
        type: "post",
        url: url
      });
    }
  });


  var $productionQualityAverage = $('.yellow').data('avg'); 
  var $radicalCreativityAverage = $('.violet').data('avg');
  var $communalEffortAverage = $('.blue').data('avg');
  var $radicalInclusivityAverage = $('.green').data('avg');
  var $civicResponsibilityAverage = $('.red').data('avg');
  var $immediacyAverage = $('.orange').data('avg');

  $('.yellow .colorBoxAverage')
    .css( 'width', oneStarWidth * $productionQualityAverage )
    .css( 'background-color', '#C7B500');
  $('.violet .colorBoxAverage')
    .css( 'width', oneStarWidth * $radicalCreativityAverage )
    .css( 'background-color', '#A02FD3');
  $('.blue .colorBoxAverage')
    .css( 'width', oneStarWidth * $communalEffortAverage )
    .css( 'background-color', '#106DE3');
  $('.green .colorBoxAverage')
    .css( 'width', oneStarWidth * $radicalInclusivityAverage )
    .css( 'background-color', '#55BC00');
  $('.red .colorBoxAverage')
    .css( 'width', oneStarWidth * $civicResponsibilityAverage )
    .css( 'background-color', '#D62806');
  $('.orange .colorBoxAverage')
    .css( 'width', oneStarWidth * $immediacyAverage )
    .css( 'background-color', '#D85D00');

  $('.stars a').mouseover( function(e) {
    var anchor = $(this),
        par = anchor.parents('.stars'),
        avgBox = par.find('.colorBoxAverage'),
        colorBox = par.find('.colorBoxInteraction');

    colorBox
      .css('background-color', '#C7E7EE')
      .css('width', oneStarWidth * anchor.data('rating'));

    avgBox.fadeOut(50);

  }).mouseleave( function(e) {
    var anchor = $(this),
        par = anchor.parents('.stars'),
        avgBox = par.find('.colorBoxAverage'),
        colorBox = par.find('.colorBoxInteraction');

    colorBox.css('width', 0);
    avgBox.fadeIn(50);
  });

});
