/*global Bloodhound */

Blacklight.onLoad(function() {
  'use strict';
  $('tt-menu').hide();
  $('[data-autocomplete-enabled="true"]').each(function() {
    var $el = $(this);
    var suggestUrl = $el.data().autocompletePath;
    var terms = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: {
        url: '/' + suggestUrl + '?q=%QUERY',
        wildcard: '%QUERY'
      }
    });
    $el.typeahead(null, {
      name: 'terms',
      display: 'term',
      source: terms,
      limit: 25
    });
  });
});