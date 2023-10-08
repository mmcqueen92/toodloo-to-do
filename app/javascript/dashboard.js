$(document).on("turbolinks:load", function () {
  // Wait for the document to load using Turbolinks

  // Assuming you have an input field with id 'date-input'
  $("#date-input").on("change", function () {
    var selectedDate = $(this).val();
    console.log("A DATE HAS BEEN SELECTED")
    $.ajax({
      type: "GET",
      url: "<%= tasks_for_day_path %>",
      data: { date: selectedDate },
      dataType: "script",
      success: function () {
        $("#tasks-list").html(data);
      },
      error: function () {
        // Handle errors if necessary
      },
    });
  });
});
