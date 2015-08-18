$(document).ready(function() {
  $('.blacklight-pages-home input[type=text]').focus();
  $(window).scroll(function() {
      if ($(this).scrollTop() > 100) {
        $('.blacklight-pages-home .navbar-primary input[type=text]').focus();
        $('.blacklight-pages-home .navbar-primary').fadeIn(10);
        $('.blacklight-pages-home .home-panel #home-search').fadeOut(120);
      } else {
        $('.blacklight-pages-home input[type=text]').focus();
        $('.blacklight-pages-home .navbar-primary').fadeOut(10);
        $('.blacklight-pages-home .home-panel #home-search').fadeIn(100);
      }
  });
});