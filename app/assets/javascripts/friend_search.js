function initFriendSearch() {  
  $("#friend-search").on("keyup", function(){
    var target = $(this);
    var searchTerm = $("#search_term").val();
    $.ajax({
      url: target.attr("action"),
      method: "GET",
      data: {search: searchTerm}
    }).done(function(data){
      $("#friend-search-results").html(data);
    }).fail(function(){
      console.log("friend search failed")
    })
  })
}  