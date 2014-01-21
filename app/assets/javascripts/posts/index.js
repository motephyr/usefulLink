$(function() {
  $('#ajax_data').click(function(){
    $.ajax({
      url: '/posts/teach.json',
      dataType:'json',
    }).success(function(data) {
      var json = JSON.stringify(data);
      $('#content').html(json);
    })
  })
});
