$(document).ready(function() {
    console.log("OK...");
    $("#hide-successes").on("change", function(event) {
        if (event.target.checked) {
            $(".accepted").css("display", "none");
        } else {
            $(".accepted").css("display", "table-row");
        }
    });
});
