(function() {
var jQuery;
if (window.jQuery === undefined || window.jQuery.fn.jquery !== '2.1.3') {
  var script_tag = document.createElement('script');
  script_tag.setAttribute("type","text/javascript");
  script_tag.setAttribute("src", "//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js");
  if (script_tag.readyState) {
    script_tag.onreadystatechange = function () { // For old versions of IE
        if (this.readyState == 'complete' || this.readyState == 'loaded') {
            scriptLoadHandler();
        }
    };
  } else {
    script_tag.onload = scriptLoadHandler;
  }
  (document.getElementsByTagName("head")[0] || document.documentElement).appendChild(script_tag);
} else {
  jQuery = window.jQuery;
  main();
}

function scriptLoadHandler() {
  jQuery = window.jQuery.noConflict(true);
  main();
}
function main() {
  jQuery(document).ready(function($) {
    var css_link = $("<link>", {
      rel: "stylesheet",
      type: "text/css",
      href: "<%= URI.join(root_url, path_to_stylesheet("widget.css")).to_s %>"
    });
    css_link.appendTo('head');


    var form = <%= render 'search_form' %>
    $('.umbra-search-widget').html(form);
    $( ".umbra-search-widget #umbra-search-form" ).submit(function( event ) {
      search = $( "input:first" ).val();
      url = "http://umbrasearch.org/catalog?utf8=%E2%9C%93&search_field=all_fields&q=" + search;
      window.location = url;
      event.preventDefault();
    });

  });
}
})();