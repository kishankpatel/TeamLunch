$(document).ready( function () {
  $('#usersTable').DataTable();
  $('#placesTable').DataTable();
});

$(document).on("click",".close-alert",function() {
  $(".alert").hide();
});