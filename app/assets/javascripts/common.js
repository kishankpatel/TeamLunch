$(document).ready( function () {
  $('#usersTable').DataTable();
  $('#placesTable').DataTable();


  $("#close-sidebar").click(function() {
    $(".page-wrapper").removeClass("toggled");
  });
  $("#show-sidebar").click(function() {
    $(".page-wrapper").addClass("toggled");
  });
});

$(document).on("click",".close-alert",function() {
  $(".alert").hide();
});