$(function(){
	$('.all-check').each(function(){
		$(this).on('click', function(){
			$(".all-check").each(function(){
				var allValue = $(this).val();
				if (allValue == 1){
					$(this).removeProp("checked");
					$(this).val(0);
					$(".cart-concon").css("background", "");
				}else {
					$(this).prop("checked","checked");
					$(this).val(1);
					$(".cart-concon").css("background", "#fff4e8");
				};
			});

			var allValue = $(".all-check:first").val();
			$(".only-value").each(function(){
				var onlyValue = $(this).val();
				if (allValue == 1 && onlyValue == 1){
					return
				};

				if (allValue == 1 && onlyValue == 0){
					$(this).prop("checked","checked");
					$(this).val(1);
				};

				if (allValue == 0 && onlyValue == 0){
					return
				};				

				if (allValue == 0 && onlyValue == 1){
					$(this).removeProp("checked");
					$(this).val(0);
				};
			});
		});
	});

	$(".check-value").each(function(){
		var checkValue = $(this).val();
		if (checkValue == 1){
			$(this).prop("checked", "checked");
			$(".cart-concon").css("background", "#fff4e8");
		}
	});

	$(".only-value").each(function(){
		$(this).on('click', function(){
			var onlyValue = $(this).val();
			if (onlyValue == 1){
				$(this).removeProp("checked");
				$(this).val(0);
				$(this).parent().parent().css("background", "");
			}else {
				$(this).prop("checked");
				$(this).val(1);
				$(this).parent().parent().css("background", "#fff4e8");
			};

			$('.all-check').each(function(){
				$(this).removeProp("checked");
				$(this).val(0);
			});

			var onlyValueSize = $(".only-value").size();
			var checkedSize = $(".only-value:checked").size();
			if (onlyValueSize == checkedSize) {
				$('.all-check').each(function(){
					$(this).prop("checked","checked");
					$(this).val(1);
				});
			}
		});
	});

	$(".tt-add").on('click', function(){
		var addValue = $(this).prev().val();
		var pid = $(this).next().val();
		var price = parseInt($(this).parent().prev().text());
		// window.alert(parseInt(price).toFixed(1));
		addValue = parseInt(addValue) + 1;
		total_price = price * addValue
		$(this).prev().val(addValue);
		$(this).parent().next().html('<i class="fa fa-jpy fa-sm" aria-hidden="true"></i>' + total_price.toFixed(1));
		$.post('shopping_carts/add_amount', {amount: addValue, product_id: pid}, function(){

		})
	});
});