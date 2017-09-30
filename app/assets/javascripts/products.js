$(function(){
	$(".small-image").mouseover(function(){
		$(".bigimage-con").html('');
		var smallSrc = $(this).attr("src");
		var middleSrc = smallSrc.replace("thumb", "middle")	
		$(".bigimage-con").append('<img src="' + middleSrc + '" class="main-image"/>');
	});

	$('.add-btn').on('click', function(){
		// window.alert("fasdfdsaf");
		var sum = 1;
		var baseValue = $('.input-con').val();
		var Value = sum + parseInt(baseValue)
		$('.input-con').val(Value);
	});

	$('.reduce-btn').on('click', function(){
		// window.alert("fasdfdsaf");
		var baseValue = $('.input-con').val();
		if(baseValue == 1){
			return
		}else {
			var Value = parseInt(baseValue) - 1 
			$('.input-con').val(Value);	
		}
	});

	$(".cart-add").on("click", function(){
		// window.alert($(".product-id").val());
		// window.alert($(".amount").val());
		var productId = $(".product-id").val();
		var amount = $(".amount").val();
		$.post('/shopping_carts', {product_id: productId, amount: amount}, function(data){
			// window.alert(data)
			$(".product-div").html(data);
			// $(".shopping-succ").
		});
	});
});