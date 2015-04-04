$(document).ready(function() {
  $('#default-exhibit-tour-start').click(function() {
    var tour = new Tour({
      steps: [
      {
        element: "#default-exhibit-tour-start",
        title: "Umbra Exhibits",
        backdrop: true,
        content: "Want to organize and describe Umbra content your own way? Get started by making an exhibit."
      },
      {
        element: "#folder_ids_",
        title: "Select Umbra Records",
        placement: "left",
        reflex: true,
        content: "Select one or more Umbra records for your exhibit by clicking on search result checkboxes. (Click one now)"
      },
      {
        element: "#folder-tools",
        title: "Pick an Exhibit",
        reflex: true,
        content: "Add your Umbra records to an exhibit by clicking on the exhibit picker dropdown and selecting. A default exhibit is provided for you."
      }
    ]});
    tour.restart();
  });

  $('#new-exhibit-tour-start').click(function() {
    var tour = new Tour({
      steps: [
      {
        element: "#exhibits-menu",
        title: "Create Exhibits",
        content: "After creating an account, revisit this menu to create new exhibits."
      }
    ]});
    tour.restart();
  });

});