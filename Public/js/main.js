$(function() {
    $.get("http://localhost:8081/cors", function(data) {
          console.log(data)
    });

    $.ajax({
           type: "post",
           url: "http://localhost:8081/cors",
           contentType: "application/json",
           success: function(data) {
                console.log(data)
           }
    });
});
