(function() {


// 收货地址
  $(document).on('click', '.new-address-btn', function() {
    var $this = $(this);

    $.get($this.attr('href'),function(data,status){
      if ($('#address_form_modal').length > 0) {
          $('#address_form_modal').remove();
        }
      $('body').append(data);
      $('#address_form_modal').modal();
    })
    return false;
  })
  
  .on('ajax:success', '.address-form', function(e, data) {
    if (data.status == 'ok') {
      $('#address_form_modal').modal('hide');
      $('#address_list').html(data.data);
    } else {
      $('#address_form_modal').html($(data.data).html());
    }
  })

  .on('ajax:success', '.set-default-address-btn, .remove-address-btn', function(e, data) {
    $('#address_list').html(data.data);
  })

  $('.create-order-form').submit(function() {
    var addressID = $('input[name="address_id"]:checked').val(),
        $form = $(this);

    if (!addressID) {
      alert("请选择收货地址!");
      return false;
    } else {
      $form.find('input[name="address_id"]').val(addressID);
      return true;
    }
  })

 // $('.set-default-address-btn').on('click', function() {
 //    var $this = $(this);
 //    xmlhttp = new XMLHttpRequest();
 //    xmlhttp.open('put', $this.attr('href'), true);
 //    xmlhttp.send();
 //    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
 //      alert("1dfsa");
 //      document.getElementById(".set-default-address-btn").innerHTML=xmlhttp.responseText;

 //    }
 // };
  // $(".set-default-address-btn").click(function(){
  //   var $this = $(this);
  //   $.ajax({url:$this.attr('href'),success:function(result){
  //       $("#address_list").html(result);
  //   }});
  // });
 
 // .on('ajax:success', '.remove-address-btn', function(e, data) {
 //    if(data.status =='ok'){
 //      $('#address_list').html(data.data);  
 //    }
 //  })
// 购物车
  $('.add-to-cart-btn').on('click', function() {
    var $this = $(this),
        $amount = $('input[name="amount"]'),
        $prog = $this.find('i');

    if ($amount.length >0 && isNaN($amount.val())) {
      alert("您填写的是非法字符请重新确认");
      return false;
    }

    if ($amount.val() <= 0) {
      alert("购买数量至少为 1");
      return false;
    }

    $.post($this.attr('href'),
    {
      product_id: $this.data('product-id'), amount: $amount.val()
    },
    function(data,status){
      if ($('#shopping_cart_modal').length > 0) {
          $('#shopping_cart_modal').remove();
        }
      $('body').append(data);
      $('#shopping_cart_modal').modal();
    })
    return false;
  })

})()

