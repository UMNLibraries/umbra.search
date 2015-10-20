$(document).ready(function(){
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

    ga('send', {
      hitType: 'event',
      eventCategory: 'Record View',
      eventAction: 'Full Record',
      eventLabel: metadata['id']
    });
  }

  $(".pin-it-large a").click(function() {
    ga('send', {
      hitType: 'event',
      eventCategory: 'Social Media',
      eventAction: 'Pinterest Full Record',
      eventLabel: window.location.href 
    });
  });
  
  $(".view-original-full-record").click(function() {
    var metadata = JSON.parse($(".metadata").attr('data-metadata'));
    ga('send', {
      hitType: 'event',
      eventCategory: 'View Original',
      eventAction: 'Full Record Click',
      eventLabel: metadata['id']
    });
  });

  $(".view-original-search").click(function() {
    var id      = $(this).attr('data-document-id');
    var context = $(this).attr('data-context');
    ga('send', {
      hitType: 'event',
      eventCategory: 'View Original',
      eventAction: context,
      eventLabel: id
    });
  });

  $("#facet-creator_ssim a.facet_select").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Facet',
      eventAction: 'Creator Facet Select',
      eventLabel: text
    });
  });

  $("#facet-sourceresource_type_ssi a.facet_select").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Facet',
      eventAction: 'Type Facet Select',
      eventLabel: text
    });
  });

  $("#facet-dataprovider_ssi a.facet_select").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Facet',
      eventAction: 'Contributing Institution Facet Select',
      eventLabel: text
    });
  });

  $("#facet-subject_ssim a.facet_select").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Facet',
      eventAction: 'Subject Institution Facet Select',
      eventLabel: text
    });
  });

  $("#facet-sourceresource_spatial_state_ssi a.facet_select").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Facet',
      eventAction: 'Location Facet Select',
      eventLabel: text
    });
  });

  $("#facet-sourceresource_date_begin_ssi a.facet_select").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Facet',
      eventAction: 'Year Facet Select',
      eventLabel: text
    });
  });

  $(".featured-content a").click(function() {
    var url = $(this).attr('href');
    ga('send', {
      hitType: 'event',
      eventCategory: 'Home Page',
      eventAction: 'Featured Content Click',
      eventLabel: url
    });
  });

  $(".search-thumbnail a").click(function() {
    var url = $(this).attr('href');
    ga('send', {
      hitType: 'event',
      eventCategory: 'Search Thumbnail',
      eventAction: 'List View Click',
      eventLabel: url
    });
  });

  $(".blacklight-catalog-index .cover-image a").click(function() {
    var url = $(this).attr('href');
    ga('send', {
      hitType: 'event',
      eventCategory: 'Search Thumbnail',
      eventAction: 'Gallery View Click',
      eventLabel: url
    });
  });

  $(".blacklight-catalog-index .documents-list .title a").click(function() {
    var url = $(this).attr('href');
    ga('send', {
      hitType: 'event',
      eventCategory: 'Search Record Title',
      eventAction: 'List View Click',
      eventLabel: url
    });
  });

  $("#metadata .related a").click(function() {
    var url = $(this).attr('href');
    ga('send', {
      hitType: 'event',
      eventCategory: 'Full Record Sidebar',
      eventAction: 'Related Content Click',
      eventLabel: url
    });
  });

  $("#metadata .subjects a").click(function() {
    var url = $(this).attr('href');
    ga('send', {
      hitType: 'event',
      eventCategory: 'Full Record Sidebar',
      eventAction: 'subjects Click',
      eventLabel: url
    });
  });

  $(".blacklight-pages-home #home-search .search-btn").click(function() {
    var text = $("#home-search #q").val();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Search',
      eventAction: 'Home Page Jumbo Search',
      eventLabel: text
    });
  });

  $(".blacklight-pages-home #primary-nav .search-btn").click(function() {
    var text = $("#primary-nav #q").val();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Search',
      eventAction: 'Home Page Navbar Search',
      eventLabel: text
    });
  });

  $(".blacklight-catalog-index .search-btn").click(function() {
    var text = $("#q").val();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Search',
      eventAction: 'Catalog Navbar Search',
      eventLabel: text
    });
  });

  $(".blacklight-pages-home .home-panel .browse-options a").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Browse Options Dropdown',
      eventAction: 'Home Page Jumbo',
      eventLabel: text
    });
  });

  $(".blacklight-pages-home #primary-nav  .browse-options a").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Browse Options Dropdown',
      eventAction: 'Home Page Navbar',
      eventLabel: text
    });
  });

  $(".blacklight-catalog .browse-options a").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Browse Options Dropdown',
      eventAction: 'Catalog Page Navbar',
      eventLabel: text
    });
  });

  $(".blacklight-pages-home .home-panel a.help-link").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Help Links',
      eventAction: 'Home Page Jumbo',
      eventLabel: text
    });
  });

  $(".blacklight-pages-home #help a").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Help Links',
      eventAction: 'Home Page Navbar',
      eventLabel: text
    });
  });

  $(".blacklight-catalog #help a").click(function() {
    var text = $(this).text();
    ga('send', {
      hitType: 'event',
      eventCategory: 'Help Links',
      eventAction: 'Catalog Page Navbar',
      eventLabel: text
    });
  });

});