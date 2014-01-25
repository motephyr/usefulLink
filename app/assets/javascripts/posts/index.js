$(function() {
  $('#ajax_data').click(function(){
    $.ajax({
      url: '/posts.json',
      dataType:'json',
    }).success(function(data) {
      var json = JSON.stringify(data);
      $('#content').html(json);
    })
  })

  $('#ajax_page').click(function(){
    $.ajax({
      url: '/posts',
      dataType:'script'
    })
  })
});
