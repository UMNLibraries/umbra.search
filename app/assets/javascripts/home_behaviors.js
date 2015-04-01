$(document).ready(function() {
  $(window).scroll(function() {
      if ($(this).scrollTop() > 100) {
        $('.blacklight-pages-home .navbar-primary').fadeIn(10);
        $('.blacklight-pages-home .home-panel #home-search').fadeOut(120);
      } else {
        $('.blacklight-pages-home .navbar-primary').fadeOut(10);
        $('.blacklight-pages-home .home-panel #home-search').fadeIn(100);
      }
  });
});