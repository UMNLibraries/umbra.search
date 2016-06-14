$(document).ready(function(){

  function umbra_serialize_event_value(data) {
    return data + '|' + window.location.hostname + '|' + window.location.pathname
  }

  function umbra_ga_event(category, action, label) {
    ga('send', {
      hitType: 'event',
      eventCategory: category,
      eventAction:  action,
      eventLabel: umbra_serialize_event_value(label)
    });
  }

  if ($(".blacklight-catalog-show").length > 0) {
    var metadata = JSON.parse($(".metadata").attr('data-metadata')); 
    ga('send', 'pageview', {
      'dimension1': metadata['dataProvider_ssi']
    });

    ga('send', 'pageview', {
      'dimension2': metadata['sourceResource_type_ssi']
    });

    ga('send', 'pageview', {
      'dimension3': metadata['import_job_name_ssi']
    });

    umbra_ga_event('Record View', 'Full Record', metadata['id']);
  }

  $(".pin-it-large a").click(function() {
    umbra_ga_event('Social Media', 'Pinterest Full Record', '');
  });

  $(".view-original-full-record").click(function() {
    var metadata = JSON.parse($(".metadata").attr('data-metadata'));
    umbra_ga_event('View Original', 'Full Record Click', metadata['id']);
  });

  $(".view-original-search").click(function() {
    umbra_ga_event('View Original', $(this).attr('data-context'), $(this).attr('data-document-id'));
  });

  $("#facet-creator_ssim a.facet_select").click(function() {
    umbra_ga_event('Facet', 'Creator Facet Select', $(this).text());
  });

  $("#facet-sourceresource_type_ssi a.facet_select").click(function() {
    umbra_ga_event('Facet', 'Type Facet Select', $(this).text());
  });

  $("#facet-dataprovider_ssi a.facet_select").click(function() {
    umbra_ga_event('Facet', 'Contributing Institution Facet Select', $(this).text());
  });

  $("#facet-keywords_ssim a.facet_select").click(function() {
    umbra_ga_event('Facet', 'Subject Facet Select', $(this).text());
  });

  $("#facet-sourceresource_spatial_state_ssi a.facet_select").click(function() {
    umbra_ga_event('Facet', 'Location Facet Select', $(this).text());
  });

  $("#facet-sourceresource_date_begin_ssi a.facet_select").click(function() {
    umbra_ga_event('Facet', 'Year Facet Select', $(this).text());
  });

  $(".blacklight-pages-home .featured-content a").click(function() {
    umbra_ga_event('Featured Content Click', 'Home Page', $(this).attr('href'));
  });

  $(".blacklight-pages-home .featured-content .blog a").click(function() {
    umbra_ga_event('Featured Content Click', 'Blog', $(this).attr('href'));
  });

  $(".blacklight-pages-home .featured-content .news a").click(function() {
    umbra_ga_event('Featured Content Click', 'News', $(this).attr('href'));
  });

  $(".search-thumbnail a").click(function() {
    umbra_ga_event('Search Thumbnail', 'List View Click', $(this).attr('href'));
  });

  $(".blacklight-catalog-index .cover-image a").click(function() {
    umbra_ga_event('Search Thumbnail', 'Gallery View Click', $(this).attr('href'));
  });

  $(".blacklight-catalog-index .documents-list .title a").click(function() {
    umbra_ga_event('Search Record Title', 'List View Click', $(this).attr('href'));
  });

  $(".blacklight-catalog-index .subjects-search-results a").click(function() {
    umbra_ga_event('Search Record Subject', 'List View Click', $(this).attr('href'));
  });

  $("#metadata .related a").click(function() {
    umbra_ga_event('Full Record Sidebar', 'Related Content Click', $(this).attr('href'));
  });

  $("#metadata .subjects a").click(function() {
    umbra_ga_event('Full Record Sidebar', 'subjects Click', $(this).attr('href'));
  });

  $(".blacklight-pages-home #home-search .search-btn").click(function() {
    umbra_ga_event('Search', 'Home Page Jumbo Search', $("#home-search #q").val());
  });

  $(".blacklight-pages-home #primary-nav .search-btn").click(function() {
    umbra_ga_event('Search', 'Home Page Navbar Search', $("#primary-nav #q").val());
  });

  $(".blacklight-catalog-index .search-btn").click(function() {
    umbra_ga_event('Search', 'Catalog Navbar Search', $("#q").val());
  });

  $(".blacklight-pages-home .home-panel .browse-options a").click(function() {
    umbra_ga_event('Browse Options Dropdown', 'Home Page Jumbo', $(this).text());
  });

  $(".blacklight-pages-home #primary-nav  .browse-options a").click(function() {
    umbra_ga_event('Browse Options Dropdown', 'Home Page Navbar', $(this).text());
  });

  $(".blacklight-catalog .browse-options a").click(function() {
    umbra_ga_event('Browse Options Dropdown', 'Catalog Page Navbar', $(this).text());
  });

  $(".blacklight-pages-home .home-panel a.help-link").click(function() {
    umbra_ga_event('Help Links', 'Home Page Jumbo', $(this).text());
  });

  $(".blacklight-pages-home #help a").click(function() {
    umbra_ga_event('Help Links', 'Home Page Navbar', $(this).text());
  });

  $(".blacklight-catalog #help a").click(function() {
    umbra_ga_event('Help Links', 'Catalog Page Navbar', $(this).text());
  });

});