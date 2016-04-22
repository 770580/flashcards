function timer() {
  second = 0
  setInterval(function() { answerTimer() }, 1000);
}

function answerTimer() {
  second++;
  $("#answer_timer").val(second); 
}

$(document).ready(function(){
  var form = $("#check_form");
  $(form).ready(function(){
    timer();
  });
});
