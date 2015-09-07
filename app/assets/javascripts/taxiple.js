if ($("nav").is('*')) {
  var elem = $('nav');
  var offset = elem.offset();
  var topValue = offset.top + elem.height() - 1;
  var width = elem.width();
  $(window).scroll(function(event) {
    var y = $(this).scrollTop();
    if (y >= topValue) {
      if (!$('nav').hasClass('follow')) {
        $("nav").hide().addClass("follow").fadeIn(250);
      }
    } else {
      $(".follow").removeClass("follow");
    }
  });
}
