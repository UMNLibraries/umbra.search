function noThumbnail(document_id, original_url) {
  // Wait for the JS stack to clear before running our searches
  setTimeout(cacheThumbnail.bind(null, document_id, original_url), 0);
  return original_url;
}

function cacheThumbnail(document_id, original_url) {
  console.log("Caching thumbnail image located at: ".concat(original_url));
  $.get('/thumbnail_cache/'.concat(document_id));
}