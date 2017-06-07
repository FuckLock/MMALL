// 用户登录
$(document).ready(function(){
  $("#cd-signin").click(function(){
    $.get("/sessions/new",function(data,status){
       if ($('#cd-user-modal').length > 0) {
          $('#cd-user-modal').remove();
        }
      $('body').append(data);
      $('#cd-user-modal').modal();
    });
    return false;
  });
});
